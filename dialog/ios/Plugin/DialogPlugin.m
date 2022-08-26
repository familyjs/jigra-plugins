#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(DialogPlugin, "Dialog",
           JIG_PLUGIN_METHOD(alert, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(prompt, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(confirm, JIGPluginReturnPromise);
)
