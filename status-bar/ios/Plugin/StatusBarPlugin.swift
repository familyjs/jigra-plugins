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
                if #available(iOS 13.0, *) {
                    bridge?.statusBarStyle = .darkContent
                } else {
                    bridge?.statusBarStyle = .default
                }
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
        let animation = call.getString("animation", "SLIDE")
        if animation == "FADE" {
            bridge?.statusBarAnimation = .fade
        } else if animation == "NONE" {
            bridge?.statusBarAnimation = .none
        } else {
            bridge?.statusBarAnimation = .slide
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
            if #available(iOS 13.0, *) {
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
            } else {
                if bridge.statusBarStyle == .lightContent {
                    style = "DARK"
                } else {
                    style = "LIGHT"
                }
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
