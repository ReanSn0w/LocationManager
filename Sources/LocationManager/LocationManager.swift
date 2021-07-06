import MapKit
import Combine

public class LocationManager: ObservableObject {
    public static var shared = LocationManager()
    
    private var locationCancellable: AnyCancellable? = nil
    
    /** Стандартное значение для разворачивания объекта с локацией */
    private(set) var defaultLocation: CLLocation
    public let locationManager = CLLocationManager()
    
    @Published var currentLocation: CLLocation? = nil
    
    private init() {
        defaultLocation = .init(
            latitude: 55.755819,
            longitude: 37.617644)
        
        locationCancellable = locationManager.publisher(for: \.location)
            .sink(receiveValue: { newLocation in
                self.currentLocation = newLocation
            })
    }
    
    public func requestAccess(
        mode: AccessMode,
        accuracy: Accuracy)
    {
        locationManager.desiredAccuracy = accuracy.rawValue
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        switch mode {
        case .always:
            self.locationManager.requestAlwaysAuthorization()
        case .inUse:
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func setDefaultLocation(new location: CLLocation) {
        self.defaultLocation = location
    }
}

/** Базовые методы для взаимодействия с локацией*/
extension LocationManager {
    public func requestLocation() {
        locationManager.requestLocation()
    }
    
    public func startTrackingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    public func stopTrackingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

/** Проверти для удобства взаимодействия */
extension LocationManager {
    var currentUnwrappedLocation: CLLocation {
        guard let location = currentLocation else {
            return defaultLocation
        }
        
        return location
    }
    
    var currentCoordinate: CLLocationCoordinate2D? {
        self.currentLocation?.coordinate
    }
    
    var currentUnwrappedCoordinate: CLLocationCoordinate2D {
        currentUnwrappedLocation.coordinate
    }
}

/** Методы для работы с дистанцией*/
extension LocationManager {
    /** Дистанция в метрах до заданной точки, возвращает nil если локация пользователя не определена*/
    public func distance(from clLocation: CLLocation) -> Int? {
        guard let location = currentLocation else {
            return nil
        }
        
        return Int(location.distance(from: clLocation))
    }
    
    /** Дистанция в метрах до заданной точки, возвращает nil если локация пользователя не определена*/
    public func distance(from coordinate: CLLocationCoordinate2D) -> Int? {
        distance(from: CLLocation(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude))
    }
    
    /** Дистанция в метрах до заданной точки, возвращает расстояние от дефолтного местоположения, если локация пользователя не определена*/
    public func unwrappedDistance(from clLocation: CLLocation) -> Int {
        Int(currentUnwrappedLocation.distance(from: clLocation))
    }
    
    /** Дистанция в метрах до заданной точки, возвращает расстояние от дефолтного местоположения, если локация пользователя не определена*/
    public func unwrappedDistance(from coordinate: CLLocationCoordinate2D) -> Int {
        unwrappedDistance(from: CLLocation(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude))
    }
}
