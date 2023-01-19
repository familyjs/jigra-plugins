#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(KeyboardPlugin, "Keyboard",
           JIG_PLUGIN_METHOD(show, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(hide, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setAccessoryBarVisible, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setStyle, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setResizeMode, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getResizeMode, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(setScroll, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeAllListeners, JIGPluginReturnPromise);
)
