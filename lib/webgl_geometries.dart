import 'dart:async';

import 'package:example/TouchListener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:three_dart/three_dart.dart' as THREE;
import 'package:three_dart_jsm/three_dart_jsm.dart' as THREE_JSM;


class webgl_geometries extends StatefulWidget {
  String fileName;

  webgl_geometries({Key? key, required this.fileName}) : super(key: key);

  createState() => _State();
}

class _State extends State<webgl_geometries> {


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

  int startTime = 0;

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


  initPage() async {

    camera = new THREE.PerspectiveCamera( 45, width / height, 1, 2000 );
    camera.position.y = 400;

    scene = new THREE.Scene();

    var object;

    var ambientLight = new THREE.AmbientLight( 0xcccccc, 0.4 );
    scene.add( ambientLight );

    var pointLight = new THREE.PointLight( 0xffffff, 0.8 );
    camera.add( pointLight );
    scene.add( camera );

    var _loader = new THREE.TextureLoader(null);
    var map = await _loader.loadAsync( 'assets/textures/uv_grid_opengl.jpg', null );
    map.wrapS = map.wrapT = THREE.RepeatWrapping;
    map.anisotropy = 16;

    var material = new THREE.MeshPhongMaterial( { "map": map, "side": THREE.DoubleSide } );

    //

    object = new THREE.Mesh( new THREE.SphereGeometry( 75, 20, 10 ), material );
    object.position.set( - 300, 0, 200 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.IcosahedronGeometry( 75, 1 ), material );
    object.position.set( - 100, 0, 200 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.OctahedronGeometry( 75, 2 ), material );
    object.position.set( 100, 0, 200 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.TetrahedronGeometry( 75, 0 ), material );
    object.position.set( 300, 0, 200 );
    scene.add( object );

    //

    object = new THREE.Mesh( new THREE.PlaneGeometry( 100, 100, 4, 4 ), material );
    object.position.set( - 300, 0, 0 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.BoxGeometry( 100, 100, 100, 4, 4, 4 ), material );
    object.position.set( - 100, 0, 0 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.CircleGeometry( radius: 50, segments: 20, thetaStart: 0, thetaLength: THREE.Math.PI * 2 ), material );
    object.position.set( 100, 0, 0 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.RingGeometry( 10, 50, 20, 5, 0, THREE.Math.PI * 2 ), material );
    object.position.set( 300, 0, 0 );
    scene.add( object );

    //

    object = new THREE.Mesh( new THREE.CylinderGeometry( 25, 75, 100, 40, 5 ), material );
    object.position.set( - 300, 0, - 200 );
    scene.add( object );

    var points = [];

    for ( var i = 0; i < 50; i ++ ) {

      points.add( new THREE.Vector2( THREE.Math.sin( i * 0.2 ) * THREE.Math.sin( i * 0.1 ) * 15 + 50, ( i - 5 ) * 2 ) );

    }

    object = new THREE.Mesh( new THREE.LatheGeometry( points, segments: 20 ), material );
    object.position.set( - 100, 0, - 200 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.TorusGeometry( 50, 20, 20, 20 ), material );
    object.position.set( 100, 0, - 200 );
    scene.add( object );

    object = new THREE.Mesh( new THREE.TorusKnotGeometry( 50, 10, 50, 20 ), material );
    object.position.set( 300, 0, - 200 );
    scene.add( object );


    startTime = DateTime.now().millisecondsSinceEpoch;
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

    var timer = DateTime.now().millisecondsSinceEpoch * 0.0001;

    camera.position.x = THREE.Math.cos( timer ) * 800;
    camera.position.z = THREE.Math.sin( timer ) * 800;

    camera.lookAt( scene.position );

    scene.traverse( ( object ) {

      if ( object.isMesh == true ) {

        object.rotation.x = timer * 5;
        object.rotation.y = timer * 2.5;

      }

    } );


 
    render();

    Future.delayed(Duration(milliseconds: 40), () {
      animate();
    });
  }


  @override
  void dispose() {
    
    print(" dispose ............. ");

    three3dRender.dispose();

    super.dispose();
  }


 
}
