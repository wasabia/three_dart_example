import 'dart:async';

import 'package:example/TouchListener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:three_dart/three_dart.dart' as THREE;
import 'package:three_dart_jsm/three_dart_jsm.dart' as THREE_JSM;


class webgl_clipping_stencil extends StatefulWidget {
  String fileName;

  webgl_clipping_stencil({Key? key, required this.fileName}) : super(key: key);

  createState() => _State();
}

class _State extends State<webgl_clipping_stencil> {


  late FlutterGlPlugin three3dRender;
  THREE.WebGLRenderer? renderer;

  int? fboId;
  late double width;
  late double height;

  Size? screenSize;

  late THREE.Scene scene;
  late THREE.Camera camera;
  late THREE.Mesh mesh;


  late THREE.AnimationMixer mixer;
  THREE.Clock clock = new THREE.Clock();
  
  num dpr = 1.0;

  var AMOUNT = 4;

  bool verbose = true;

  late THREE.Object3D object;

  late THREE.Texture texture;

  late THREE.WebGLMultisampleRenderTarget renderTarget;

  dynamic? sourceTexture;
  
  bool loaded = false;

  late THREE.Object3D model;


  late List<THREE.Plane> planes;
  late List<THREE.PlaneHelper> planeHelpers;
  late List<THREE.Mesh> planeObjects;


  @override
  void initState() {
    super.initState();   
  }



  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height;

    three3dRender = FlutterGlPlugin();

    Map<String, dynamic> _options = {
      "antialias": true,
      "alpha": false,
      "width": width.toInt(), 
      "height": height.toInt(), 
      "dpr": dpr
    };
    
    await three3dRender.initialize(options: _options);

    setState(() { });

    // TODO web wait dom ok!!!
    Future.delayed(Duration(milliseconds: 100), () async {
      await three3dRender.prepareContext();

      initScene();
      animate();
      
    });
  
  }

  

  initSize(BuildContext context) {
    if (screenSize != null) {
      return;
    }

    final mqd = MediaQuery.of(context);

    screenSize = mqd.size;
    dpr = mqd.devicePixelRatio;

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.fileName),
        ),
        body: Builder(
          builder: (BuildContext context) {
            initSize(context);  
            return SingleChildScrollView(
              child: _build(context)
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("render"),
          onPressed: () {
            clickRender();
          },
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.black,
                  child: Builder(
                    builder: (BuildContext context) {
                      if(kIsWeb) {
                        return three3dRender.isInitialized ? HtmlElementView(viewType: three3dRender.textureId!.toString()) : Container();
                      } else {
                        return three3dRender.isInitialized ? Texture(textureId: three3dRender.textureId!) : Container();
                      }
                    }
                  )
                )
              ),
              
            ],
          ),
        ),

      ],
    );
  }

  render() {

    int _t = DateTime.now().millisecondsSinceEpoch;

    final _gl = three3dRender.gl;

     

    renderer!.render(scene, camera);

   
    int _t1 = DateTime.now().millisecondsSinceEpoch;

    if(verbose) {
      print("render cost: ${_t1 - _t} ");
      print(renderer!.info.memory);
      print(renderer!.info.render);
    }
    
   
    // 重要 更新纹理之前一定要调用 确保gl程序执行完毕
    _gl.flush();

    if(verbose) print(" render: sourceTexture: ${sourceTexture} ");

    if(!kIsWeb) {
      three3dRender.updateTexture(sourceTexture);
    }
    
  }

  initRenderer() {
    Map<String, dynamic> _options = {
      "width": width, 
      "height": height,
      "gl":  three3dRender.gl,
      "antialias": true,
      "canvas": three3dRender.element
    };
    renderer = THREE.WebGLRenderer( _options );
    renderer!.setPixelRatio(dpr);
    renderer!.setSize( width, height, false );
    renderer!.shadowMap.enabled = true;
    renderer!.localClippingEnabled = true;
    
    if(!kIsWeb) {
      var pars = THREE.WebGLRenderTargetOptions({ "format": THREE.RGBAFormat });
      renderTarget = THREE.WebGLMultisampleRenderTarget((width * dpr).toInt(), (height * dpr).toInt(), pars);
      renderTarget.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget);
    }
  }


  
  initScene() {
    initRenderer();
    initPage();
  }


  createPlaneStencilGroup( geometry, plane, renderOrder ) {

    var group = new THREE.Group();
    var baseMat = new THREE.MeshBasicMaterial();
    baseMat.depthWrite = false;
    baseMat.depthTest = false;
    baseMat.colorWrite = false;
    baseMat.stencilWrite = true;
    baseMat.stencilFunc = THREE.AlwaysStencilFunc;

    // back faces
    var mat0 = baseMat.clone();
    mat0.side = THREE.BackSide;
    mat0.clippingPlanes = List<THREE.Plane>.from([ plane ]);
    mat0.stencilFail = THREE.IncrementWrapStencilOp;
    mat0.stencilZFail = THREE.IncrementWrapStencilOp;
    mat0.stencilZPass = THREE.IncrementWrapStencilOp;

    var mesh0 = new THREE.Mesh( geometry, mat0 );
    mesh0.renderOrder = renderOrder;
    group.add( mesh0 );

    // front faces
    var mat1 = baseMat.clone();
    mat1.side = THREE.FrontSide;
    mat1.clippingPlanes = List<THREE.Plane>.from([ plane ]);
    mat1.stencilFail = THREE.DecrementWrapStencilOp;
    mat1.stencilZFail = THREE.DecrementWrapStencilOp;
    mat1.stencilZPass = THREE.DecrementWrapStencilOp;

    var mesh1 = new THREE.Mesh( geometry, mat1 );
    mesh1.renderOrder = renderOrder;

    group.add( mesh1 );

    return group;

  }

  initPage() async {

    scene = new THREE.Scene();

    camera = new THREE.PerspectiveCamera( 36, width / height, 1, 100 );
    camera.position.set( 2, 2, 2 );

    scene.add( new THREE.AmbientLight( 0xffffff, 0.5 ) );

    camera.lookAt(scene.position);

    var dirLight = new THREE.DirectionalLight( 0xffffff, 1 );
    dirLight.position.set( 5, 10, 7.5 );
    dirLight.castShadow = true;
    dirLight.shadow!.camera!.right = 2;
    dirLight.shadow!.camera!.left = - 2;
    dirLight.shadow!.camera!.top	= 2;
    dirLight.shadow!.camera!.bottom = - 2;

    dirLight.shadow!.mapSize.width = 1024;
    dirLight.shadow!.mapSize.height = 1024;
    scene.add( dirLight );

    planes = [
      new THREE.Plane( new THREE.Vector3( - 1, 0, 0 ), 0 ),
      new THREE.Plane( new THREE.Vector3( 0, - 1, 0 ), 0 ),
      new THREE.Plane( new THREE.Vector3( 0, 0, - 1 ), 0 )
    ];

    planeHelpers = planes.map( (p) => new THREE.PlaneHelper( p, 2, 0xffffff ) ).toList();
    planeHelpers.forEach( (ph) {

      ph.visible = false;
      scene.add( ph );

    } );

    var geometry = new THREE.TorusKnotGeometry( 0.4, 0.15, 220, 60 );
    object = new THREE.Group();
    scene.add( object );

    // Set up clip plane rendering
    planeObjects = [];
    var planeGeom = new THREE.PlaneGeometry( 4, 4 );

    for ( int i = 0; i < 3; i ++ ) {

      var poGroup = new THREE.Group();
      var plane = planes[ i ];
      var stencilGroup = createPlaneStencilGroup( geometry, plane, i + 1 );


      var _planes = planes.where( (p) => p != plane ).toList();

      // plane is clipped by the other clipping planes
      var planeMat = new THREE.MeshStandardMaterial( {

          "color": 0xff00ff,
          "metalness": 0.1,
          "roughness": 0.75,
          "clippingPlanes": _planes,

          "stencilWrite": true,
          "stencilRef": 0,
          "stencilFunc": THREE.NotEqualStencilFunc,
          "stencilFail": THREE.ReplaceStencilOp,
          "stencilZFail": THREE.ReplaceStencilOp,
          "stencilZPass": THREE.ReplaceStencilOp,

        } );
      var po = new THREE.Mesh( planeGeom, planeMat );
      // po.onAfterRender =  ( renderer ) {

      //   renderer.clearStencil();

      // };

      po.renderOrder = i + 1.1;

      object.add( stencilGroup );
      poGroup.add( po );
      planeObjects.add( po );
      scene.add( poGroup );

    }

    var material = new THREE.MeshStandardMaterial( {

      "color": 0xFFC107,
      "metalness": 0.1,
      "roughness": 0.75,
      "clippingPlanes": planes,
      "clipShadows": true,
      "shadowSide": THREE.DoubleSide,

    } );

    // add the color
    var clippedColorFront = new THREE.Mesh( geometry, material );
    clippedColorFront.castShadow = true;
    clippedColorFront.renderOrder = 6;
    object.add( clippedColorFront );


    var ground = new THREE.Mesh(
      new THREE.PlaneGeometry( 9, 9, 1, 1 ),
      new THREE.ShadowMaterial( { "color": 0, "opacity": 0.25, "side": THREE.DoubleSide } )
    );

    ground.rotation.x = - THREE.Math.PI / 2; // rotates X/Y to X/Z
    ground.position.y = - 1;
    ground.receiveShadow = true;
    scene.add( ground );

  
    loaded = true;


    animate();


    // scene.overrideMaterial = new THREE.MeshBasicMaterial();
  }

  clickRender() {
    print("clickRender..... ");
    animate();
  }

  animate() {

    if(!mounted) {
      return;
    }

    if(!loaded) {
      return;
    }



    var delta = clock.getDelta();


    if ( true ) {

      object.rotation.x += delta * 0.5;
      object.rotation.y += delta * 0.2;

    }

    for ( var i = 0; i < planeObjects.length; i ++ ) {

      var plane = planes[ i ];
      var po = planeObjects[ i ];
      plane.coplanarPoint( po.position );
      po.lookAt(
        THREE.Vector3(
          po.position.x - plane.normal.x,
          po.position.y - plane.normal.y,
          po.position.z - plane.normal.z,
        )
      );

    }


 
    render();

    // Future.delayed(Duration(milliseconds: 40), () {
    //   animate();
    // });
  }


  @override
  void dispose() {
    
    print(" dispose ............. ");

    three3dRender.dispose();

    super.dispose();
  }


 
}
