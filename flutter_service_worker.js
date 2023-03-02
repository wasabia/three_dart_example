'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "15f73b7e8a8209c2206210b3ac8dea1b",
"version.json": "ff966ab969ba381b900e61629bfb9789",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/assets/screenshots/webgl_loader_obj_mtl.jpg": "16bdd7ed74814acc73fff3b0b838832d",
"assets/assets/screenshots/webgl_loader_fbx.jpg": "8af8a9d536e6fb3c518507ebeac25ea3",
"assets/assets/screenshots/misc_animation_keys.jpg": "cf05fe48d7154137a06768d815b9850e",
"assets/assets/screenshots/webgl_camera.jpg": "de1370376c86f31202173a90860166f9",
"assets/assets/screenshots/webgl_animation_skinning_morph.jpg": "ef659a89e9764d135611db6409411895",
"assets/assets/screenshots/webgl_shadowmap_viewer.jpg": "949a3530092f619cedfe4a4414dd86c8",
"assets/assets/screenshots/webgl_skinning_simple.jpg": "78512a6b4f54ec10eabecd0cf4fec739",
"assets/assets/screenshots/webgl_materials.jpg": "73133c87bc5c7a86b9e4bef25688422e",
"assets/assets/screenshots/misc_controls_pointerlock.jpg": "da8f8a7d22e7182ec1d02b3c08ecc0e2",
"assets/assets/screenshots/misc_controls_fly.jpg": "cf74175a48eac3552e1476f2fc584703",
"assets/assets/screenshots/webgl_shadow_contact.jpg": "2304a71b165a23a324437e979741bf28",
"assets/assets/screenshots/webgl_morphtargets_horse.jpg": "03ba3fbdb5c2f7ab45e91a42422f290c",
"assets/assets/screenshots/misc_controls_transform.jpg": "43a3c73f4522ffd5e06346c7c290fe56",
"assets/assets/screenshots/webgl_loader_texture_basis.jpg": "8ea6d45ce146f3d37342b4004ad7221b",
"assets/assets/screenshots/misc_controls_orbit.jpg": "2ae581a4be9aefebf40bd0fa125650b4",
"assets/assets/screenshots/webgl_clipping_intersection.jpg": "7beafe1049ec9d671ecf8036a72088e3",
"assets/assets/screenshots/webgl_instancing_performance.jpg": "ae670a8468853ff756f739477785080c",
"assets/assets/screenshots/webgl_animation_skinning_additive_blending.jpg": "72d6b1dae234645bfe4b8e9164fa8294",
"assets/assets/screenshots/webgl_materials_browser.jpg": "1fdeedadba88f73f29622ce45dc1ed74",
"assets/assets/screenshots/webgl_geometry_text.jpg": "17327acf9321626f5e7d08c9ea77aaeb",
"assets/assets/screenshots/webgl_geometry_colors.jpg": "2479e6ab39c76b05763fca054d0628bf",
"assets/assets/screenshots/webgl_loader_gltf.jpg": "269365a2338e27e0095f42e346c7009e",
"assets/assets/screenshots/webgl_loader_obj.jpg": "237ac174b0b5eeb222a1d85b4deb7d43",
"assets/assets/screenshots/webgl_camera_array.jpg": "b1826f9bd6bc43fab6f3e62b46dc4242",
"assets/assets/screenshots/misc_controls_map.jpg": "488589ece8be1c940b66d905878128b8",
"assets/assets/screenshots/webgl_animation_skinning_blending.jpg": "876d2f3013a3400ee4e4be234d917f61",
"assets/assets/screenshots/webgl_helpers.jpg": "851b40ac56ac23fa480b9ad99b0bbcc8",
"assets/assets/screenshots/webgl_clipping.jpg": "db01a6fbf787622c4f8d6f5245a46241",
"assets/assets/screenshots/webgl_geometries.jpg": "00dd62430371a3b8c2508e264cdc9586",
"assets/assets/screenshots/misc_controls_drag.jpg": "54c4c32547c0a66f2a1bea81fe587ca2",
"assets/assets/screenshots/webgl_animation_keyframes.jpg": "ae80b2a6ba92e2709c47547db2190ca2",
"assets/assets/screenshots/webgl_clipping_advanced.jpg": "06fec3e9f4bcc19611b4fc1822b00140",
"assets/assets/screenshots/webgl_loader_svg.jpg": "6e8ddefd1f6ae30a778bdc6e43987364",
"assets/assets/screenshots/webgl_morphtargets.jpg": "21db9fe6b3a536ebc6fbcdf54208ca6f",
"assets/assets/screenshots/misc_controls_trackball.jpg": "7756cde5f13c42d0943ea3f614af85be",
"assets/assets/screenshots/misc_controls_arcball.jpg": "dad403f0b88a1f24d14a9c8854566125",
"assets/assets/screenshots/webgl_clipping_stencil.jpg": "13dde3f848bf1e788ef3b1e0edd90a54",
"assets/assets/screenshots/webgl_animation_cloth.jpg": "e1fbd6c039a7f295bfcd140ceec3fe0c",
"assets/assets/screenshots/webgl_morphtargets_sphere.jpg": "d9e66e946f51b2d693b2663759888259",
"assets/assets/screenshots/webgl_geometry_shapes.jpg": "6b7c73a2adcaa9496c5dcc79aca95135",
"assets/assets/screenshots/webgl_animation_multiple.jpg": "0ee7867d592fe3818ba5899e7e2266d1",
"assets/assets/textures/land_ocean_ice_cloud_2048.jpg": "b07dffb39178b6c32ded56481356ffaa",
"assets/assets/textures/memorial.png": "33284cc4352d2285357a739572535d6d",
"assets/assets/textures/kinect.mp4": "fb564196692eeae497708e96deea9cb4",
"assets/assets/textures/crate_grey8.tga": "7711cb3f146f819a9b6ba88f00a57168",
"assets/assets/textures/disturb.jpg": "f1b4c29e355977cd1e12c0063c500406",
"assets/assets/textures/equirectangular/spot1Lux.hdr": "10f6838d551057ac5b45f68c33e16a32",
"assets/assets/textures/equirectangular/pedestrian_overpass_1k.hdr": "b52d400303d1578413b7283eb1e64e6c",
"assets/assets/textures/equirectangular/moonless_golf_1k.hdr": "da9edde9ad39465900a7935dc15ab8d7",
"assets/assets/textures/equirectangular/venice_sunset_1k.hdr": "704548cc835be5bb43bbb280395869e7",
"assets/assets/textures/equirectangular/royal_esplanade_1k.hdr": "375181a19c870eb048c0751a468396d4",
"assets/assets/textures/equirectangular/quarry_01_1k.hdr": "d4c4954484c7a713e283b22f71591f26",
"assets/assets/textures/pano.mp4": "e8d11d595f46e98389304418424fbe74",
"assets/assets/textures/roughness_map.jpg": "b2ed84242538e86fe13d0a17d02705e5",
"assets/assets/textures/grid.png": "34401589a72c5aff231eadd64bbdc958",
"assets/assets/textures/waterdudv.jpg": "3def38543f645790e6d836fcc6bdc02d",
"assets/assets/textures/snellen.png": "bc1a888f08c921506cc84a81f8049b43",
"assets/assets/textures/square-outline.png": "b905d896d71bc85b43df499e7689d3ae",
"assets/assets/textures/uv_grid_directx.jpg": "86c5fd733d18aeaf0ba91bf7f778c278",
"assets/assets/textures/colors.png": "d7f400f404eec84540a93770785ae2d3",
"assets/assets/textures/envmap.png": "4a3d4f25652c670e32663464720108c3",
"assets/assets/textures/piz_compressed.exr": "9813f6798a87967c373c3d43687323a3",
"assets/assets/textures/sintel.mp4": "36abd8180373525089df094e2f5a5cea",
"assets/assets/textures/kinect.nfo": "ce2e7db348773f1e41837adf7cf3f05f",
"assets/assets/textures/MaryOculus.mp4": "a35701d85172949d3f917991256a5f1e",
"assets/assets/textures/MaryOculus.webm.nfo": "6033b42667e392be12600265c9e641e5",
"assets/assets/textures/kandao3_depthmap.jpg": "0ed734d8828e17b18d9c75722435af52",
"assets/assets/textures/patterns/circuit_pattern.png": "28b98bbb36ff23e53db769b04875c9ea",
"assets/assets/textures/patterns/readme.txt": "c31a1f446cabe388e79e639786b1b1ea",
"assets/assets/textures/patterns/bright_squares256.png": "c007be9453123b75ca0fdf66a0f67671",
"assets/assets/textures/hardwood2_bump.jpg": "bb09e96aa13d1d314ae8ba5a9e42175b",
"assets/assets/textures/sprite0.jpg": "a19a72e4b5d084b6e79789db5ec6a23d",
"assets/assets/textures/sprites/snowflake3.png": "2dbe07e000ba1b4fe4ec5b862294caaf",
"assets/assets/textures/sprites/disc.png": "f1d753f1a8e6ebb30d283f17ca43a560",
"assets/assets/textures/sprites/snowflake1.png": "99c51beabb59b5b026c814fe294c5966",
"assets/assets/textures/sprites/spark1.png": "6fcfa7e6789e87957c0c7419c18fad9c",
"assets/assets/textures/sprites/snowflake5.png": "90be2cc86bdf4bbbc07fe92e0aa650e6",
"assets/assets/textures/sprites/snowflake4.png": "b97b73a720a59d03da0c49c296eb338f",
"assets/assets/textures/sprites/snowflake2.png": "671fe112535f517acaca0b60430d62ef",
"assets/assets/textures/sprites/snowflake7_alpha.png": "fc324da1add18a604b09e35a1c817cfd",
"assets/assets/textures/sprites/ball.png": "d9b2f9599b4c7b18010ad937667c39d2",
"assets/assets/textures/sprites/circle.png": "af5735c195346d58bc2244da9d48678b",
"assets/assets/textures/sintel.ogv": "f0312fcfa5e1d5867d32ff1b6fa74de9",
"assets/assets/textures/tri_pattern.jpg": "d121adfc4964a0ac46055d7afc71429a",
"assets/assets/textures/2294472375_24a3b8ef46_o.jpg": "5c1129fdec69f5eeefc4dcbf174c1443",
"assets/assets/textures/square-outline-textured.png": "6f7897fbc8a9c08f656e19446b46f735",
"assets/assets/textures/golfball.jpg": "a84bbaa7e0765def26c0c6f7f8272bd9",
"assets/assets/textures/brick_diffuse.jpg": "d59d03c861d2e85435cffd9813b25742",
"assets/assets/textures/MaryOculus.webm": "949ad7230032cc12e1be8093d77cd5ce",
"assets/assets/textures/kinect.webm": "0e558d600bd7dadf0deec488bf62ee5e",
"assets/assets/textures/brick_roughness.jpg": "5f1e9e3fa70ee879bef174b8da9220ad",
"assets/assets/textures/crate.gif": "da499b8537ee3ce0ed8469c0a73ecc2c",
"assets/assets/textures/uv_grid_opengl.jpg": "ea0adfcb01cfcb26fe36ac0005606444",
"assets/assets/textures/sprite.png": "d30f6af129314958fefb4fbe7edbe00c",
"assets/assets/textures/hardwood2_diffuse.jpg": "94bed574871efc2888038b57b23805d1",
"assets/assets/textures/equirectangular.png": "d15cbe71af2f4aca6df2270082d48766",
"assets/assets/textures/sprite0.png": "fbb77be9f02a7624181a10267b2b447e",
"assets/assets/textures/sprite2.png": "52b94f4ec699433ec83b9dca02becb5d",
"assets/assets/textures/alphaMap.jpg": "051a8faf14e8c77b49af6a153ab59ebb",
"assets/assets/textures/WalkingManSpriteSheet.png": "7ab79333cfe9bda5396bca85739bf5c9",
"assets/assets/textures/sprite1.png": "1a949586f4b0d119da0dbe0d25567e11",
"assets/assets/textures/terrain/readme.txt": "ab72de6fc737288d22513546b0551d29",
"assets/assets/textures/terrain/grasslight-big-nm.jpg": "d9b46098a647b139e79b771b1db961a3",
"assets/assets/textures/terrain/grasslight-big.jpg": "801373c211724f955fb17e1e2b5ba453",
"assets/assets/textures/758px-Canestra_di_frutta_(Caravaggio).jpg": "ded243e7192fa2754b87132984fbd936",
"assets/assets/textures/waternormals.jpg": "4418dde3f6abc21dc32506acf5f5b093",
"assets/assets/textures/pano.webm": "8be67c8ddac7c78069dbab34904c0587",
"assets/assets/textures/brick_bump.jpg": "18cbaac66dfe58cc57143f00de9405e0",
"assets/assets/textures/water.jpg": "bcfb9394f4141ab0c9cdaeaf62f1aadd",
"assets/assets/textures/sprite1.jpg": "e24dddfab1d3d608bf1ab6df01b790cb",
"assets/assets/textures/uncompressed.exr": "498a429eb6cc1a32e8d7262c63a70740",
"assets/assets/textures/hardwood2_roughness.jpg": "875c202ad7ad9d6b2272d1b03fbc50fb",
"assets/assets/textures/cm_viridis.png": "cec34c745302ac9091aebbe5bc1ba576",
"assets/assets/textures/kandao3.jpg": "26411563b5165e1d5fd0416466091667",
"assets/assets/textures/crate_color8.tga": "07d97eb1bb89a4d20e5b9632745fd858",
"assets/assets/textures/cm_gray.png": "1d7f40ed70c85369b03d19318a6bb6f4",
"assets/assets/textures/memorial.hdr": "c7273f5a8dff35c6a32e0810e3b241e1",
"assets/assets/textures/memorial.exr": "0e6e83bf87be93d81574a8735a820b6d",
"assets/assets/KOMO-v5.cube": "356971b72bd7a755ab995e1903af9519",
"assets/assets/lut.cube": "b8241bbc7a3c5b0da7947d6be8b37fe0",
"assets/assets/kenpixel.ttf": "16b75ff9ac3ffcfaf20de34bcebc3ad8",
"assets/assets/winter.jpg": "e075c0795b3f3890dda68a6f6e3e0096",
"assets/assets/models/svg/energy.svg": "59e605ac6c9b373d5303f55a905306f5",
"assets/assets/models/svg/hexagon.svg": "4eddac4f6e1c006980a8af121a10a6ab",
"assets/assets/models/svg/threejs.svg": "da6a5e2f456916bb016f70d1bd8436ee",
"assets/assets/models/svg/tiger.svg": "be17ac47cc132f4dbb13e7b2633ea898",
"assets/assets/models/svg/zero-radius.svg": "3f1e45e8ec8a0263207c99ed0a271f1b",
"assets/assets/models/svg/lineJoinsAndCaps.svg": "c3ca49a123f1bc4ec27aa9ca8a79484c",
"assets/assets/models/svg/multiple-css-classes.svg": "e9d2881030b2616203392aff02672ac0",
"assets/assets/models/obj/male02/male-02-1noCulling.JPG": "5d6c59c0e5da41d8c556135234d79221",
"assets/assets/models/obj/male02/male02.mtl": "b4d34e3408d76351c58ba2e670a06194",
"assets/assets/models/obj/male02/01_-_Default1noCulling.dds": "24e4a946fa9d56474cca36e2b5493fc7",
"assets/assets/models/obj/male02/male021.obj": "cf5274057b092620a56af04b604f8f92",
"assets/assets/models/obj/male02/readme.txt": "f5dcf333d006e0074b18f373e16cfdaf",
"assets/assets/models/obj/male02/male02.obj": "310586de426d900e1540d98f81ed2b81",
"assets/assets/models/obj/male02/male-02-1noCulling.dds": "0f246da0478d233b3a382e855797b6fd",
"assets/assets/models/obj/male02/male02_dds.mtl": "7a5d46828b2ea3facaf5cdccf7e93de0",
"assets/assets/models/obj/male02/orig_02_-_Defaul1noCulling.JPG": "8835a9c4b8023e8c206413ff8eb5cd26",
"assets/assets/models/obj/male02/01_-_Default1noCulling.JPG": "bfd3c8b3c40709aabea8ae05b90f3411",
"assets/assets/models/obj/male02/orig_02_-_Defaul1noCulling.dds": "1be543407ebedf651a0a3dca353c882b",
"assets/assets/models/json/pressure.json": "fda8a2dbf74c3e9f7d00bb9ca6d33b52",
"assets/assets/models/json/QRCode_buffergeometry.json": "7ff7673b3d7361a3d67abee3be0dff52",
"assets/assets/models/json/WaltHeadLo_buffergeometry.json": "51fe46b6f984d83f64ed7122da66da49",
"assets/assets/models/json/suzanne_buffergeometry.json": "cc368f5ceeb955f6337ee9bc0e2fa3f5",
"assets/assets/models/gltf/Xbot.gltf": "6d460ece6062aa71496d5488b8bb8c8c",
"assets/assets/models/gltf/Soldier.gltf": "f28f5e803b5fa500ed0a13ec273ec6a0",
"assets/assets/models/gltf/coffeemat.glb": "febfe8b2160939471cf7886998f3712f",
"assets/assets/models/gltf/AnimatedMorphSphere/glTF/AnimatedMorphSphere.bin": "89a37a235af1600ec85a6b40a0b67c31",
"assets/assets/models/gltf/AnimatedMorphSphere/glTF/AnimatedMorphSphere.gltf": "6522250402bd7cd581595b19173d356a",
"assets/assets/models/gltf/DamagedHelmet/glTF/Default_albedo.jpg": "76f93d96015a7dc91e39ac24ae8f62c1",
"assets/assets/models/gltf/DamagedHelmet/glTF/DamagedHelmet.gltf": "bbe003fceb4f61fa9583d303e696ee04",
"assets/assets/models/gltf/DamagedHelmet/glTF/Default_emissive.jpg": "fa8c756ea48eac1b18f1e74c03b34436",
"assets/assets/models/gltf/DamagedHelmet/glTF/Default_metalRoughness.jpg": "294a81a28afbf24cc5ee6cd6aad44786",
"assets/assets/models/gltf/DamagedHelmet/glTF/DamagedHelmet.bin": "5699fad9d84869a17865b85ec25f9fe5",
"assets/assets/models/gltf/DamagedHelmet/glTF/Default_normal.jpg": "48d9ff1bd7adf4abfa7fbe231cb016bd",
"assets/assets/models/gltf/DamagedHelmet/glTF/Default_AO.jpg": "609356e5861cd5eee9a3af2b98bc8c30",
"assets/assets/models/gltf/RobotExpressive/README.md": "618dbef254938ad1de3e6bcf8c0750f6",
"assets/assets/models/gltf/RobotExpressive/RobotExpressive.glb": "70610664823701a3341a6e3db0af2fa7",
"assets/assets/models/gltf/RobotExpressive/RobotExpressive.gltf": "b4c118d95e9fe6302891fce6fecc6a6d",
"assets/assets/models/gltf/RobotExpressive/RobotExpressive2.gltf": "f1d0d893640b1aaf8f5da74567e4f1fd",
"assets/assets/models/gltf/Parrot.gltf": "770845294750c038ea952d4c1a53687d",
"assets/assets/models/gltf/LeePerrySmith.gltf": "d07a7a2f1e669c065fa9d530e28fc6c8",
"assets/assets/models/gltf/BoomBox.glb": "bac5ec68e72a0b1b154f18652f78144f",
"assets/assets/models/gltf/untitled.glb": "28e6e25c195f0bc0f862c8a663aa3f20",
"assets/assets/models/gltf/SimpleSkinning.gltf": "2f05ada4c1527b99bcbda5c6a9df35b5",
"assets/assets/models/gltf/test/tokyo.gltf": "8fa505fb941de7db5568c852d99b8bf4",
"assets/assets/models/gltf/test/untitled22.gltf": "d4f87051fe4e013d0103c8b33c2b965e",
"assets/assets/models/gltf/test/animate7.gltf": "66ead976a05c10cfcc01d411d63679d1",
"assets/assets/models/gltf/Horse.gltf": "12c160d79373c55e38ede83dee9ca3e5",
"assets/assets/models/fbx/stanford-bunny.fbx": "9e1173a2339050c15e4605f2da8babc7",
"assets/assets/models/fbx/bunny_thickness.jpg": "07976de10799d4e445ac08371c7d222f",
"assets/assets/models/fbx/nurbs.fbx": "2dddd25b6748ea4c2dafc2662443e881",
"assets/assets/models/fbx/white.jpg": "374efe1a93cd762bceb5a3e998a098d6",
"assets/assets/models/fbx/Samba%2520Dancing.fbx": "9a80489e046f0d3e164a6f0955a8df98",
"assets/assets/pingfang.ttf": "67ee533e4da77ffdef0fc1df1fa7935f",
"assets/assets/demo.png": "9c2194fc650645e9c913811bbb52aec8",
"assets/NOTICES": "7972c7df385d4d4b397f16fd690c5e59",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/AssetManifest.json": "1d34600af92ffe237a0e510dd29576e8",
"index.html": "942e847a70cf2eb3387def4a033bd799",
"/": "942e847a70cf2eb3387def4a033bd799",
"main.dart.js": "69441e1a638810995356e7fe6d1f24a0",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
