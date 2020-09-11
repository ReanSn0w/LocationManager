//
//  EnvironmentValues.swift
//  
//
//  Created by Дмитрий Папков on 11.09.2020.
//

import SwiftUI

@available(iOS 13.0, *)
extension EnvironmentValues {
    public var locationManager: LocationManager {
        get {
            LocationManager.shared
        }
    }
}
