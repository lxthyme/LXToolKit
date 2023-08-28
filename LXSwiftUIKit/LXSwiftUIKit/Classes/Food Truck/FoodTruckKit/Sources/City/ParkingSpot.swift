//
//  File.swift
//  
//
//  Created by lxthyme on 2023/8/25.
//

import Foundation
import CoreLocation

public struct ParkingSpot: Identifiable, Hashable {
    public var id: String { name }
    public var name: String
    public var location: CLLocation
    public var cameraDistance: Double = 1000
}
