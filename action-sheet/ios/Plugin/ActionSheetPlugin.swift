import Foundation
import Jigra

/**
 * Please read the Jigra iOS Plugin Development Guide
 * here: https://jigrajs.web.app/docs/plugins/ios
 */
@objc(ActionSheetPlugin)
public class ActionSheetPlugin: JIGPlugin {
    private let implementation = ActionSheet()

    @objc func showActions(_ call: JIGPluginCall) {
        let title = call.options["title"] as? String
        let message = call.options["message"] as? String

        let options = call.getArray("options", JSObject.self) ?? []
        var alertActions = [UIAlertAction]()
        for (index, option) in options.enumerated() {
            let style = option["style"] as? String ?? "DEFAULT"
            let title = option["title"] as? String ?? ""
            var buttonStyle: UIAlertAction.Style = .default
            if style == "DESTRUCTIVE" {
                buttonStyle = .destructive
            } else if style == "CANCEL" {
                buttonStyle = .cancel
            }
            let action = UIAlertAction(title: title, style: buttonStyle, handler: { (_) -> Void in
                call.resolve([
                    "index": index
                ])
            })
            alertActions.append(action)
        }

        DispatchQueue.main.async { [weak self] in
            if let alertController = self?.implementation.buildActionSheet(title: title, message: message, actions: alertActions) {
                self?.setCenteredPopover(alertController)
                self?.bridge?.viewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
