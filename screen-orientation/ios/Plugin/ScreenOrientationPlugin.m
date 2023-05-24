#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

JIG_PLUGIN(ScreenOrientationPlugin, "ScreenOrientation",
  JIG_PLUGIN_METHOD(orientation, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(lock, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(unlock, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(removeAllListeners, JIGPluginReturnPromise);
)