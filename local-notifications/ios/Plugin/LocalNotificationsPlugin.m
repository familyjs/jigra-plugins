#import <Foundation/Foundation.h>
#import <Jigra/Jigra.h>

JIG_PLUGIN(LocalNotificationsPlugin, "LocalNotifications",
    JIG_PLUGIN_METHOD(schedule, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(requestPermissions, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(checkPermissions, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(cancel, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(getPending, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(registerActionTypes, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(areEnabled, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(getDeliveredNotifications, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(removeAllDeliveredNotifications, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(removeDeliveredNotifications, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(createChannel, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(deleteChannel, JIGPluginReturnPromise);
    JIG_PLUGIN_METHOD(listChannels, JIGPluginReturnPromise);
)
