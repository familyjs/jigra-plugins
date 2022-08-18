#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(StatusBarPlugin, "StatusBar",
           JIG_PLUGIN_METHOD(setStyle, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setBackgroundColor, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(show, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(hide, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getInfo, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setOverlaysWebView, JIGPluginReturnPromise);
)
