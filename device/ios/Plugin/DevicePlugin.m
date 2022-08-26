#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(DevicePlugin, "Device",
           JIG_PLUGIN_METHOD(getId, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getInfo, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getBatteryInfo, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getLanguageCode, JIGPluginReturnPromise);
)
