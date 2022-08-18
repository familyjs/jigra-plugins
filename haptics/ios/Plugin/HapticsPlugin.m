#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(HapticsPlugin, "Haptics",
  JIG_PLUGIN_METHOD(impact, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(notification, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(selectionStart, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(selectionChanged, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(selectionEnd, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(vibrate, JIGPluginReturnPromise);
)
