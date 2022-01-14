
import 'package:example/misc_animation_keys.dart';
import 'package:example/webgl_animation_cloth.dart';
import 'package:example/webgl_animation_keyframes.dart';
import 'package:example/webgl_animation_multiple.dart';
import 'package:example/webgl_clipping.dart';
import 'package:example/webgl_clipping_advanced.dart';
import 'package:example/webgl_clipping_intersection.dart';
import 'package:example/webgl_clipping_stencil.dart';
import 'package:example/webgl_geometries.dart';
import 'package:example/webgl_loader_gltf.dart';
import 'package:example/webgl_loader_gltf_test.dart';
import 'package:example/webgl_loader_obj_mtl.dart';
import 'package:example/webgl_loader_texture_basis.dart';
import 'package:example/webgl_materials.dart';
import 'package:example/webgl_shadowmap_viewer.dart';
import 'package:example/webgl_skinning_simple.dart';

import 'filesJson.dart';
import 'webgl_camera_array.dart';
import 'webgl_geometry_shapes.dart';
import 'webgl_geometry_text.dart';
import 'webgl_instancing_performance.dart';
import 'webgl_loader_obj.dart';
import 'webgl_materials_browser.dart';
import 'package:flutter/material.dart';
import 'webgl_shadow_contact.dart';

class ExampleApp extends StatefulWidget {
  ExampleApp({Key? key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ExampleApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              },
              itemCount: filesJson.length
            );
          },
        ),
      ),
    );
  }


  String getName( String file ) {

    var name = file.split( '_' );
    name.removeAt(0);
    return name.join( ' / ' );

  }

  Widget _buildItem(BuildContext context, int index) {

    var fileName = filesJson[index];

    var assetFile = "assets/screenshots/${fileName}.jpg";
    var name = getName(fileName);

    return TextButton(
      onPressed: () {
        _goto(context, fileName);
      }, 
      child: Container(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 50
              ),
              child: Image.asset(assetFile),
            ),
            Container(
              child: Text(name),
            )
          ],
        )
      )
    );
  }

  _goto(BuildContext context, String fileName) {

    Widget page;

    if(fileName == "webgl_camera_array") {
      page = webgl_camera_array(fileName: fileName);
    } else if(fileName == "webgl_loader_obj") {
      page = webgl_loader_obj(fileName: fileName);
    } else if(fileName == "webgl_materials_browser") {
      page = webgl_materials_browser(fileName: fileName);
    } else if(fileName == "webgl_shadow_contact") {
      page = webgl_shadow_contact(fileName: fileName);
    } else if(fileName == "webgl_geometry_text") {
      page = webgl_geometry_text(fileName: fileName);
    } else if(fileName == "webgl_geometry_shapes") {
      page = webgl_geometry_shapes(fileName: fileName);
    } else if(fileName == "webgl_instancing_performance") {
      page = webgl_instancing_performance(fileName: fileName);
    } else if(fileName == "webgl_shadowmap_viewer") {
      page = webgl_shadowmap_viewer(fileName: fileName);
    } else if(fileName == "webgl_loader_gltf") {
      page = webgl_loader_gltf(fileName: fileName);
    } else if(fileName == "webgl_loader_gltf_test") {
      page = webgl_loader_gltf_test(fileName: fileName);
    } else if(fileName == "webgl_loader_obj_mtl") {
      page = webgl_loader_obj_mtl(fileName: fileName);
    } else if(fileName == "webgl_animation_keyframes") {
      page = webgl_animation_keyframes(key: webgl_animation_keyframesGlobalKey, fileName: fileName);
    } else if(fileName == "webgl_loader_texture_basis") {
      page = webgl_loader_texture_basis(fileName: fileName);
    } else if(fileName == "webgl_animation_multiple") {
      page = webgl_animation_multiple(fileName: fileName);
    } else if(fileName == "webgl_skinning_simple") {
      page = webgl_skinning_simple(fileName: fileName);
    } else if(fileName == "misc_animation_keys") {
      page = misc_animation_keys(fileName: fileName);
    } else if(fileName == "webgl_clipping_intersection") {
      page = webgl_clipping_intersection(fileName: fileName);
    } else if(fileName == "webgl_clipping_advanced") {
      page = webgl_clipping_advanced(fileName: fileName);
    } else if(fileName == "webgl_clipping_stencil") {
      page = webgl_clipping_stencil(fileName: fileName);
    } else if(fileName == "webgl_clipping") {
      page = webgl_clipping(fileName: fileName);
    } else if(fileName == "webgl_geometries") {
      page = webgl_geometries(fileName: fileName);
    } else if(fileName == "webgl_animation_cloth") {
      page = webgl_animation_cloth(fileName: fileName);
    } else if(fileName == "webgl_materials") {
      page = webgl_materials(fileName: fileName);
      
    } else {
      throw("_goto fileName ${fileName} is not support yet ");
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        }
      )
    );
  }

}
