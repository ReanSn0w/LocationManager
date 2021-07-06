//
//  Enums.swift
//  
//
//  Created by Дмитрий Папков on 06.07.2021.
//

import Foundation
import MapKit

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
