import 'dart:async';

import 'package:example/TouchListener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:three_dart/three_dart.dart' as THREE;
import 'package:three_dart_jsm/three_dart_jsm.dart' as THREE_JSM;



class webgl_animation_multiple extends StatefulWidget {
  String fileName;

  webgl_animation_multiple({Key? key, required this.fileName}) : super(key: key);

  createState() => _State();
}

class _State extends State<webgl_animation_multiple> {


  late FlutterGlPlugin three3dRender;
  THREE.WebGLRenderer? renderer;

  int? fboId;
  late double width;
  late double height;

  Size? screenSize;

  late THREE.Scene scene;
  late THREE.Camera camera;
  late THREE.Mesh mesh;

  //////////////////////////////
  // Global objects
  //////////////////////////////
  late THREE.Scene worldScene; // THREE.Scene where it all will be rendered


  THREE.Clock clock = new THREE.Clock();
  THREE_JSM.OrbitControls? controls;
  
  num dpr = 1.0;

  var AMOUNT = 4;

  bool verbose = true;

  late THREE.Object3D object;

  late THREE.Texture texture;

  late List<Map<String, dynamic>> MODELS;
  late List<Map<String, dynamic>> UNITS;
  var mixers = []; // All the THREE.AnimationMixer objects for all the animations in the scene


  var numLoadedModels = 0;


  late THREE.WebGLMultisampleRenderTarget renderTarget;

  dynamic? sourceTexture;
  
  bool loaded = false;

  late THREE.Object3D model;


  Map<String, List<Function>> _listeners = {};

  @override
  void initState() {
    super.initState();   
  }



  addEventListener(String name, Function callback, [bool flag = false]) {
    var _cls = _listeners[name] ?? [];
    _cls.add(callback);
    _listeners[name] = _cls;
  }

  removeEventListener(String name, Function callback, [bool flag = false]) {
    var _cls = _listeners[name] ?? [];
    _cls.remove(callback);
    _listeners[name] = _cls;
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

  emit(String name, event) {
    var _callbacks = _listeners[name];
    if(_callbacks != null && _callbacks.length > 0) {
      var _len = _callbacks.length;
      for(int i = 0; i < _len; i++) {
        var _cb = _callbacks[i];
        _cb(event);
      }
    }
  }
  
  Widget _build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              TouchListener(
                touchstart: (event) {
                  emit("touchstart", event);
                },
                touchmove: (event) {
                  emit("touchmove", event);
                },
                touchend: (event) {
                  emit("touchend", event);
                },
                pointerdown: (event) {
                  emit("pointerdown", event);
                },
                pointermove: (event) {
                  emit("pointermove", event);
                },
                pointerup: (event) {
                  emit("pointerup", event);
                },
                wheel: (event) {
                  emit("wheel", event);
                },
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

     

    renderer!.render(worldScene, camera);

   
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
    renderer = THREE.WebGLRenderer(_options);
    renderer!.setPixelRatio(dpr);
    renderer!.setSize( width, height, false );
    renderer!.shadowMap.enabled = false;
    
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

    
    //////////////////////////////


    //////////////////////////////
    // Information about our 3D models and units
    //////////////////////////////

    // The names of the 3D models to load. One-per file.
    // A model may have multiple SkinnedMesh objects as well as several rigs (armatures). Units will define which
    // meshes, armatures and animations to use. We will load the whole scene for each object and clone it for each unit.
    // Models are from https://www.mixamo.com/
    MODELS = [
      { "name": "Soldier" },
      { "name": "Parrot" },
    ];

    // Here we define instances of the models that we want to place in the scene, their position, scale and the animations
    // that must be played.
    UNITS = [
      {
        "modelName": "Soldier", // Will use the 3D model from file models/gltf/Soldier.glb
        "meshName": "vanguard_Mesh", // Name of the main mesh to animate
        "position": { "x": 0, "y": 0, "z": 0 }, // Where to put the unit in the scene
        "scale": 1, // Scaling of the unit. 1.0 means: use original size, 0.1 means "10 times smaller", etc.
        "animationName": "Idle" // Name of animation to run
      },
      {
        "modelName": "Soldier",
        "meshName": "vanguard_Mesh",
        "position": { "x": 3, "y": 0, "z": 0 },
        "scale": 2,
        "animationName": "Walk"
      },
      {
        "modelName": "Soldier",
        "meshName": "vanguard_Mesh",
        "position": { "x": 1, "y": 0, "z": 0 },
        "scale": 1,
        "animationName": "Run"
      },
      {
        "modelName": "Parrot",
        "meshName": "mesh_0",
        "position": { "x": - 4, "y": 0, "z": 0 },
        "rotation": { "x": 0, "y": THREE.Math.PI, "z": 0 },
        "scale": 0.01,
        "animationName": "parrot_A_"
      },
      {
        "modelName": "Parrot",
        "meshName": "mesh_0",
        "position": { "x": - 2, "y": 0, "z": 0 },
        "rotation": { "x": 0, "y": THREE.Math.PI / 2, "z": 0 },
        "scale": 0.02,
        "animationName": null
      },
    ];

    //////////////////////////////
    // The main setup happens here
    //////////////////////////////
    
    initScene2();
    loadModels();
    //////////////////////////////


    
    
    loaded = true;


    animate();


    // scene.overrideMaterial = new THREE.MeshBasicMaterial();
  }

  initScene2() {

    camera = new THREE.PerspectiveCamera( 45, width / height, 1, 10000 );
    camera.position.set( 3, 6, - 10 );
    camera.lookAt( THREE.Vector3(0, 1, 0) );

    clock = new THREE.Clock();

    worldScene = new THREE.Scene();
    worldScene.background = THREE.Color.fromHex( 0xa0a0a0 );
    worldScene.fog = new THREE.Fog( 0xa0a0a0, 10, 22 );

    var hemiLight = new THREE.HemisphereLight( 0xffffff, 0x444444 );
    hemiLight.position.set( 0, 20, 0 );
    worldScene.add( hemiLight );

    var dirLight = new THREE.DirectionalLight( 0xffffff );
    dirLight.position.set( - 3, 10, - 10 );
    dirLight.castShadow = true;
    dirLight.shadow!.camera!.top = 10;
    dirLight.shadow!.camera!.bottom = - 10;
    dirLight.shadow!.camera!.left = - 10;
    dirLight.shadow!.camera!.right = 10;
    dirLight.shadow!.camera!.near = 0.1;
    dirLight.shadow!.camera!.far = 40;
    worldScene.add( dirLight );

    // ground
    var groundMesh = new THREE.Mesh(
      new THREE.PlaneGeometry( 40, 40 ),
      new THREE.MeshPhongMaterial( {
        "color": 0x999999,
        "depthWrite": false
      } )
    );

    groundMesh.rotation.x = - THREE.Math.PI / 2;
    groundMesh.receiveShadow = true;
    worldScene.add( groundMesh );
    

  }

  //////////////////////////////
    // Function implementations
    //////////////////////////////
    /**
     * Function that starts loading process for the next model in the queue. The loading process is
     * asynchronous: it happens "in the background". Therefore we don't load all the models at once. We load one,
     * wait until it is done, then load the next one. When all models are loaded, we call loadUnits().
     */
    loadModels() {

      for ( var i = 0; i < MODELS.length; ++ i ) {

        var m = MODELS[ i ];

        loadGltfModel( m, () {

          ++ numLoadedModels;

          if ( numLoadedModels == MODELS.length ) {

            print( "All models loaded, time to instantiate units..." );
            instantiateUnits();

          }

        } );

      }

    }

    /**
     * Look at UNITS configuration, clone necessary 3D model scenes, place the armatures and meshes in the scene and
     * launch necessary animations
     */
    instantiateUnits() {

      var numSuccess = 0;

      for ( var i = 0; i < UNITS.length; ++ i ) {

      
        var u = UNITS[ i ];
        var model = getModelByName( u["modelName"] );

        if ( model != null ) {

          var clonedScene = THREE_JSM.SkeletonUtils.clone( model["scene"] );

       
          if ( clonedScene != null ) {

            // THREE.Scene is cloned properly, let's find one mesh and launch animation for it
            var clonedMesh = clonedScene.getObjectByName( u["meshName"] );

        
            if ( clonedMesh != null ) {

              var mixer = startAnimation( clonedMesh, List<THREE.AnimationClip>.from(model["animations"]), u["animationName"] );

              // Save the animation mixer in the list, will need it in the animation loop
              mixers.add( mixer );
              numSuccess ++;

            }

            // Different models can have different configurations of armatures and meshes. Therefore,
            // We can't set position, scale or rotation to individual mesh objects. Instead we set
            // it to the whole cloned scene and then add the whole scene to the game world
            // Note: this may have weird effects if you have lights or other items in the GLTF file's scene!
            worldScene.add( clonedScene );

            if ( u["position"] != null ) {

              clonedScene.position.set( u["position"]["x"], u["position"]["y"], u["position"]["z"] );

            }

            if ( u["scale"] != null ) {

              clonedScene.scale.set( u["scale"], u["scale"], u["scale"] );

            }

            if ( u["rotation"] != null ) {

              clonedScene.rotation.x = u["rotation"]["x"];
              clonedScene.rotation.y = u["rotation"]["y"];
              clonedScene.rotation.z = u["rotation"]["z"];

            }

          }

        } else {

          print( "Can not find model ${u["modelName"]}" );

        }

      }

      print(" Successfully instantiated ${numSuccess} units ");

    }

    /**
     * Start animation for a specific mesh object. Find the animation by name in the 3D model's animation array
     * @param skinnedMesh {THREE.SkinnedMesh} The mesh to animate
     * @param animations {Array} Array containing all the animations for this model
     * @param animationName {string} Name of the animation to launch
     * @return {THREE.AnimationMixer} Mixer to be used in the render loop
     */
    startAnimation( skinnedMesh, animations, animationName ) {

      var mixer = new THREE.AnimationMixer( skinnedMesh );
      var clip = THREE.AnimationClip.findByName( animations, animationName );

      if ( clip != null ) {

        var action = mixer.clipAction( clip );
        action.play();

      }

      return mixer;

    }

    /**
     * Find a model object by name
     * @param name
     * @returns {object|null}
     */
    getModelByName( name ) {

      for ( var i = 0; i < MODELS.length; ++ i ) {

        if ( MODELS[ i ]["name"] == name ) {

          return MODELS[ i ];

        }

      }

      return null;

    }

    /**
     * Load a 3D model from a GLTF file. Use the GLTFLoader.
     * @param model {object} Model config, one item from the MODELS array. It will be updated inside the function!
     * @param onLoaded {function} A callback function that will be called when the model is loaded
     */
    loadGltfModel( model, onLoaded ) {

      var loader = new THREE_JSM.GLTFLoader(null);
      var modelName = "assets/models/gltf/" + model["name"] + ".gltf";

      loader.load( modelName, ( gltf ) {

        var scene = gltf["scene"];

        model["animations"] = gltf["animations"];
        model["scene"] = scene;

        // Enable Shadows

        gltf["scene"].traverse( ( object ) {

          if ( object.isMesh ) {

            object.castShadow = true;

          }

        } );

        print( "Done loading model ${model["name"]} " );

        onLoaded();

      }, null, null );

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



    var mixerUpdateDelta = clock.getDelta();


    // Update all the animation frames

    for ( var i = 0; i < mixers.length; ++ i ) {

      mixers[ i ].update( mixerUpdateDelta );

    }



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
