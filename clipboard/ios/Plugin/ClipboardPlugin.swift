import Foundation
import Jigra

@objc(ClipboardPlugin)
public class ClipboardPlugin: JIGPlugin {
    private let implementation = Clipboard()

    @objc func read(_ call: JIGPluginCall) {
        let result = implementation.read()

        if !result.isEmpty {
            call.resolve(result)
        } else {
            call.reject("There is no data on the clipboard")
        }
    }

    @objc func write(_ call: JIGPluginCall) {
        var result: Result<Void, Error>

        if let string = call.options["string"] as? String {
            result = implementation.write(content: string, ofType: Clipboard.ContentType.string)
        } else if let urlString = call.options["url"] as? String {
            result = implementation.write(content: urlString, ofType: Clipboard.ContentType.url)
        } else if let imageBase64 = call.options["image"] as? String {
            result = implementation.write(content: imageBase64, ofType: Clipboard.ContentType.image)
        } else {
            call.reject("No content provided")
            return
        }

        switch result {
        case .success:
            call.resolve()
        case .failure(let err):
            JIGLog.print(err.localizedDescription)
            call.reject(err.localizedDescription)
        }
    }
}
