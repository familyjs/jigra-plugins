import Foundation
import Jigra

public struct GoogleMapConfig: Codable {
    let width: Double
    let height: Double
    let x: Double // swiftlint:disable:this identifier_name
    let y: Double // swiftlint:disable:this identifier_name
    let center: LatLng
    let zoom: Double
    let styles: String?
    var mapId: String?

    init(fromJSObject: JSObject) throws {
        guard let width = fromJSObject["width"] as? Double else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'width' property")
        }

        guard let height = fromJSObject["height"] as? Double else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'height' property")
        }

        // swiftlint:disable:next identifier_name
        guard let x = fromJSObject["x"] as? Double else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'x' property")
        }

        // swiftlint:disable:next identifier_name
        guard let y = fromJSObject["y"] as? Double else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'y' property")
        }

        guard let zoom = fromJSObject["zoom"] as? Double else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'zoom' property")
        }

        guard let latLngObj = fromJSObject["center"] as? JSObject else {
            throw GoogleMapErrors.invalidArguments("GoogleMapConfig object is missing the required 'center' property")
        }

        guard let lat = latLngObj["lat"] as? Double, let lng = latLngObj["lng"] as? Double else {
            throw GoogleMapErrors.invalidArguments("LatLng object is missing the required 'lat' and/or 'lng' property")
        }

        self.width = round(width)
        self.height = round(height)
        self.x = x
        self.y = y
        self.zoom = zoom
        self.center = LatLng(lat: lat, lng: lng)
        if let stylesArray = fromJSObject["styles"] as? JSArray, let jsonData = try? JSONSerialization.data(withJSONObject: stylesArray, options: []) {
            self.styles = String(data: jsonData, encoding: .utf8)
        } else {
            self.styles = nil
        }

        self.mapId = fromJSObject["iOSMapId"] as? String
    }
}
