#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(AppPlugin, "App",
           JIG_PLUGIN_METHOD(exitApp, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getInfo, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getLaunchUrl, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getState, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(minimizeApp, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeAllListeners, JIGPluginReturnPromise);
)
