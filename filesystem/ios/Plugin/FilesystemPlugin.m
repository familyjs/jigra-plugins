#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(FilesystemPlugin, "Filesystem",
           JIG_PLUGIN_METHOD(readFile, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(writeFile, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(appendFile, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(deleteFile, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(mkdir, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(rmdir, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(readdir, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getUri, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(stat, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(rename, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(copy, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(checkPermissions, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(requestPermissions, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(downloadFile, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeAllListeners, JIGPluginReturnPromise);
)
