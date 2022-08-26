#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(TextZoomPlugin, "TextZoom",
           JIG_PLUGIN_METHOD(getPreferred, JIGPluginReturnPromise);
)
