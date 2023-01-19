#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(PreferencesPlugin, "Preferences",
           JIG_PLUGIN_METHOD(configure, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(get, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(set, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(remove, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(keys, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(clear, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(migrate, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeOld, JIGPluginReturnPromise);
)
