import Foundation
import Jigra

@objc(ScreenOrientationPlugin)
public class ScreenOrientationPlugin: JIGPlugin {

    private let implementation = ScreenOrientation()

    override public func load() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.orientationDidChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
        if let viewController = (self.bridge?.viewController as? JIGBridgeViewController) {
            implementation.setJigraViewController(viewController)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc public func orientation(_ call: JIGPluginCall) {
        let orientationType = implementation.getCurrentOrientationType()
        call.resolve(["type": orientationType])
    }

    @objc public func lock(_ call: JIGPluginCall) {
        guard let lockToOrientation = call.getString("orientation") else {
            call.reject("Input option 'orientation' must be provided.")
            return
        }
        implementation.lock(lockToOrientation) { error in
            if let error = error {
                call.reject(error.localizedDescription)
            }
            call.resolve()
        }

    }

    @objc public func unlock(_ call: JIGPluginCall) {
        implementation.unlock { error in
            if let error = error {
                call.reject(error.localizedDescription)
            }
            call.resolve()
        }
    }

    @objc private func orientationDidChange() {
        // Ignore changes in orientation if unknown, face up, or face down
        if UIDevice.current.orientation.isValidInterfaceOrientation {
            let orientation = implementation.getCurrentOrientationType()
            notifyListeners("screenOrientationChange", data: ["type": orientation])
        }
    }
}
