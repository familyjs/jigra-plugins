#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

// Define the plugin using the JIG_PLUGIN Macro, and
// each method the plugin supports using the JIG_PLUGIN_METHOD macro.
JIG_PLUGIN(PushNotificationsPlugin, "PushNotifications",
           JIG_PLUGIN_METHOD(register, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(unregister, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(checkPermissions, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(requestPermissions, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(getDeliveredNotifications, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeAllDeliveredNotifications, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(removeDeliveredNotifications, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(createChannel, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(listChannels, JIGPluginReturnPromise);
           JIG_PLUGIN_METHOD(deleteChannel, JIGPluginReturnPromise);
)
