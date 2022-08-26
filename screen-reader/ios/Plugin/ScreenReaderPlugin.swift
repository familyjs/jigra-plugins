import Foundation
import Jigra

@objc(ScreenReaderPlugin)
public class ScreenReaderPlugin: JIGPlugin {
    static let stateChangeEvent = "stateChange"

    override public func load() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onVoiceOverStateChanged(notification:)),
                                               name: UIAccessibility.voiceOverStatusDidChangeNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func isEnabled(_ call: JIGPluginCall) {
        let enabled = UIAccessibility.isVoiceOverRunning

        call.resolve([
            "value": enabled
        ])
    }

    @objc func speak(_ call: JIGPluginCall) {
        guard let value = call.getString("value") else {
            call.reject("No value provided")
            return
        }

        if UIAccessibility.isVoiceOverRunning {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIAccessibility.post(notification: .announcement, argument: value)
            }
        }

        call.resolve()
    }

    @objc private func onVoiceOverStateChanged(notification: NSNotification) {
        notifyListeners(ScreenReaderPlugin.stateChangeEvent, data: [
            "value": UIAccessibility.isVoiceOverRunning
        ])
    }
}
