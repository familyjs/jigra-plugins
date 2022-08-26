import Foundation
import Jigra

@objc(TextZoomPlugin)
public class TextZoomPlugin: JIGPlugin {
    private let textZoom = TextZoom()

    @objc func getPreferred(_ call: JIGPluginCall) {
        call.resolve([
            "value": textZoom.preferredFontSize()
        ])
    }
}
