import Foundation
import Jigra

@objc(PreferencesPlugin)
public class PreferencesPlugin: JIGPlugin {
    private var preferences = Preferences(with: PreferencesConfiguration())

    @objc func configure(_ call: JIGPluginCall) {
        let group = call.getString("group")
        let configuration: PreferencesConfiguration

        if let group = group {
            if group == "NativeStorage" {
                configuration = PreferencesConfiguration(for: .cordovaNativeStorage)
            } else {
                configuration = PreferencesConfiguration(for: .named(group))
            }
        } else {
            configuration = PreferencesConfiguration()
        }

        preferences = Preferences(with: configuration)
        call.resolve()
    }

    @objc func get(_ call: JIGPluginCall) {
        guard let key = call.getString("key") else {
            call.reject("Must provide a key")
            return
        }

        let value = preferences.get(by: key)

        call.resolve([
            "value": value as Any
        ])
    }

    @objc func set(_ call: JIGPluginCall) {
        guard let key = call.getString("key") else {
            call.reject("Must provide a key")
            return
        }
        let value = call.getString("value", "")

        preferences.set(value, for: key)
        call.resolve()
    }

    @objc func remove(_ call: JIGPluginCall) {
        guard let key = call.getString("key") else {
            call.reject("Must provide a key")
            return
        }

        preferences.remove(by: key)
        call.resolve()
    }

    @objc func keys(_ call: JIGPluginCall) {
        let keys = preferences.keys()

        call.resolve([
            "keys": keys
        ])
    }

    @objc func clear(_ call: JIGPluginCall) {
        preferences.removeAll()
        call.resolve()
    }

    @objc func migrate(_ call: JIGPluginCall) {
        var migrated: [String] = []
        var existing: [String] = []
        let oldPrefix = "_jig_"
        let oldKeys = UserDefaults.standard.dictionaryRepresentation().keys.filter { $0.hasPrefix(oldPrefix) }

        for oldKey in oldKeys {
            let key = String(oldKey.dropFirst(oldPrefix.count))
            let value = UserDefaults.standard.string(forKey: oldKey) ?? ""
            let currentValue = preferences.get(by: key)

            if currentValue == nil {
                preferences.set(value, for: key)
                migrated.append(key)
            } else {
                existing.append(key)
            }
        }

        call.resolve([
            "migrated": migrated,
            "existing": existing
        ])
    }

    @objc func removeOld(_ call: JIGPluginCall) {
        let oldPrefix = "_jig_"
        let oldKeys = UserDefaults.standard.dictionaryRepresentation().keys.filter { $0.hasPrefix(oldPrefix) }
        for oldKey in oldKeys {
            UserDefaults.standard.removeObject(forKey: oldKey)
        }
        call.resolve()
    }
}
