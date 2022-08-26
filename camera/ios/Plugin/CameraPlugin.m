#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

JIG_PLUGIN(JIGCameraPlugin, "Camera",
  JIG_PLUGIN_METHOD(getPhoto, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(pickImages, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(checkPermissions, JIGPluginReturnPromise);
  JIG_PLUGIN_METHOD(requestPermissions, JIGPluginReturnPromise);
)
