import Foundation
import Jigra

/**
 * StatusBar plugin. Requires "View controller-based status bar appearance" to
 * be "YES" in Info.plist
 */
@objc(StatusBarPlugin)
public class StatusBarPlugin: JIGPlugin {
    private var observer: NSObjectProtocol?

    override public func load() {
        observer = NotificationCenter.default.addObserver(forName: Notification.Name.jigraStatusBarTapped, object: .none, queue: .none) { [weak self] _ in
            self?.bridge?.triggerJSEvent(eventName: "statusTap", target: "window")
        }
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    @objc func setStyle(_ call: JIGPluginCall) {
        let options = call.options!

        if let style = options["style"] as? String {
            if style == "DARK" {
                bridge?.statusBarStyle = .lightContent
            } else if style == "LIGHT" {
                bridge?.statusBarStyle = .darkContent
            } else if style == "DEFAULT" {
                bridge?.statusBarStyle = .default
            }
        }

        call.resolve([:])
    }

    @objc func setBackgroundColor(_ call: JIGPluginCall) {
        call.unimplemented()
    }

    func setAnimation(_ call: JIGPluginCall) {
        let animation = call.getString("animation", "FADE")
        if animation == "SLIDE" {
            bridge?.statusBarAnimation = .slide
        } else if animation == "NONE" {
            bridge?.statusBarAnimation = .none
        } else {
            bridge?.statusBarAnimation = .fade
        }
    }

    @objc func hide(_ call: JIGPluginCall) {
        setAnimation(call)
        bridge?.statusBarVisible = false
        call.resolve()
    }

    @objc func show(_ call: JIGPluginCall) {
        setAnimation(call)
        bridge?.statusBarVisible = true
        call.resolve()
    }

    @objc func getInfo(_ call: JIGPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let bridge = self?.bridge else {
                return
            }
            let style: String
            switch bridge.statusBarStyle {
            case .default:
                if bridge.userInterfaceStyle == UIUserInterfaceStyle.dark {
                    style = "DARK"
                } else {
                    style = "LIGHT"
                }
            case .lightContent:
                style = "DARK"
            default:
                style = "LIGHT"
            }

            call.resolve([
                "visible": bridge.statusBarVisible,
                "style": style
            ])
        }
    }

    @objc func setOverlaysWebView(_ call: JIGPluginCall) {
        call.unimplemented()
    }
}
