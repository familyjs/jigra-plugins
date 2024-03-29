import Foundation
import Jigra

@objc(DevicePlugin)
public class DevicePlugin: JIGPlugin {
    private let implementation = Device()

    @objc func getId(_ call: JIGPluginCall) {
        if let uuid = UIDevice.current.identifierForVendor {
            call.resolve([
                "identifier": uuid.uuidString
            ])
        } else {
            call.reject("Id not available")
        }
    }
    @objc func getInfo(_ call: JIGPluginCall) {
        var isSimulator = false
        var modelName = ""
        #if targetEnvironment(simulator)
        isSimulator = true
        modelName = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "Simulator"
        #else
        modelName = implementation.getModelName()
        #endif

        let memUsed = implementation.getMemoryUsage()
        let diskFree = implementation.getFreeDiskSize() ?? 0
        let realDiskFree = implementation.getRealFreeDiskSize() ?? 0
        let diskTotal = implementation.getTotalDiskSize() ?? 0
        let systemVersionNum = implementation.getSystemVersionInt() ?? 0

        call.resolve([
            "memUsed": memUsed,
            "diskFree": diskFree,
            "diskTotal": diskTotal,
            "realDiskFree": realDiskFree,
            "realDiskTotal": diskTotal,
            "name": UIDevice.current.name,
            "model": modelName,
            "operatingSystem": "ios",
            "osVersion": UIDevice.current.systemVersion,
            "iOSVersion": systemVersionNum,
            "platform": "ios",
            "manufacturer": "Apple",
            "isVirtual": isSimulator,
            "webViewVersion": UIDevice.current.systemVersion
        ])
    }

    @objc func getBatteryInfo(_ call: JIGPluginCall) {
        UIDevice.current.isBatteryMonitoringEnabled = true

        call.resolve([
            "batteryLevel": UIDevice.current.batteryLevel,
            "isCharging": UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
        ])

        UIDevice.current.isBatteryMonitoringEnabled = false
    }

    @objc func getLanguageCode(_ call: JIGPluginCall) {
        let code = implementation.getLanguageCode()
        call.resolve([
            "value": code
        ])
    }

    @objc func getLanguageTag(_ call: JIGPluginCall) {
        let tag = implementation.getLanguageTag()
        call.resolve([
            "value": tag
        ])
    }

}
