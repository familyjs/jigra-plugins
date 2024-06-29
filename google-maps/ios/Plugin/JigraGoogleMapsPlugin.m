#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(JigraGoogleMapsPlugin, "JigraGoogleMaps",
   JIG_PLUGIN_METHOD(create, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableTouch, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(disableTouch, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(addMarker, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(addMarkers, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(addPolygons, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(addPolylines, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(addCircles, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(removeMarker, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(removeMarkers, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(removeCircles, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(removePolygons, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(removePolylines, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableClustering, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(disableClustering, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(destroy, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(setCamera, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(getMapType, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(setMapType, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableIndoorMaps, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableTrafficLayer, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableAccessibilityElements, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(enableCurrentLocation, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(setPadding, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(onScroll, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(onResize, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(onDisplay, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(getMapBounds, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(fitBounds, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(mapBoundsContains, JIGPluginReturnPromise);
   JIG_PLUGIN_METHOD(mapBoundsExtend, JIGPluginReturnPromise);
)
