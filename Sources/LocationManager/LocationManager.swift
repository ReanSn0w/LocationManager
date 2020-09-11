import MapKit

@available (iOS 13.0, *)
public class LocationManager {
    private init() {}
    public static var shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    public var locationManager: CLLocationManager {
        get {
            self.manager 
        }
    }
}

@available (iOS 13.0, *)
extension LocationManager {
    public var recentLocation: CLLocation? {
        get {
            self.manager.location
        }
    }
}

@available (iOS 13.0, *)
extension LocationManager {
    public func requestAccess(
        mode: AccessMode,
        accuracy: Accuracy)
    {
        switch mode {
        case .always:
            self.manager.requestAlwaysAuthorization()
        case .inUse:
            self.manager.requestWhenInUseAuthorization()
        }
        
        manager.desiredAccuracy = accuracy.rawValue
        manager.distanceFilter = kCLDistanceFilterNone
    }
    
    public enum AccessMode {
        case inUse
        case always
    }
    
    public enum Accuracy: CLLocationAccuracy {
        case bestForNavidation
        case best
        case nearestTenMeters
        case hundredMeters
        case kilometer
        case threeKilometers
        
        func value() -> CLLocationAccuracy {
            switch self {
            case .bestForNavidation:
                return kCLLocationAccuracyBestForNavigation
            case .best:
                return kCLLocationAccuracyBest
            case .nearestTenMeters:
                return kCLLocationAccuracyNearestTenMeters
            case .hundredMeters:
                return kCLLocationAccuracyHundredMeters
            case .kilometer:
                return kCLLocationAccuracyKilometer
            case .threeKilometers:
                return kCLLocationAccuracyThreeKilometers
            }
        }
    }
}
