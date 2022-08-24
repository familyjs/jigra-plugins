import Foundation
import Jigra

@objc(AppLauncherPlugin)
public class AppLauncherPlugin: JIGPlugin {

    @objc func canOpenUrl(_ call: JIGPluginCall) {
        guard let urlString = call.getString("url") else {
            call.reject("Must supply a URL")
            return
        }

        guard let url = URL.init(string: urlString) else {
            call.reject("Invalid URL")
            return
        }

        DispatchQueue.main.async {
            let canOpen = UIApplication.shared.canOpenURL(url)

            call.resolve([
                "value": canOpen
            ])
        }
    }

    @objc func openUrl(_ call: JIGPluginCall) {
        guard let urlString = call.getString("url") else {
            call.reject("Must supply a URL")
            return
        }

        guard let url = URL.init(string: urlString) else {
            call.reject("Invalid URL")
            return
        }

        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:]) { (completed) in
                call.resolve([
                    "completed": completed
                ])
            }
        }
    }
}
