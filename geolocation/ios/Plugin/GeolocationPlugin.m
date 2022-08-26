#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(GeolocationPlugin, "Geolocation",
  JIG_PLUGIN_METHOD(getCurrentPosition, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(watchPosition, JIGPluginReturnCallback);
  JIG_PLUGIN_METHOD(clearWatch, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(checkPermissions, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(requestPermissions, JIGPluginReturnPromise);
)
