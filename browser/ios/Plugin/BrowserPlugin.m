#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

JIG_PLUGIN(JIGBrowserPlugin, "Browser",
  JIG_PLUGIN_METHOD(open, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(close, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(removeAllListeners, JIGPluginReturnPromise);
)
