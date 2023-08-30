//
//  Truck.swift
//  
//
//  Created by lxthyme on 2023/8/25.
//

import Foundation

public struct Truck {
    public var city: City = .cupertino
    public var location: ParkingSpot = City.cupertino.parkingSpots[0]
}

// MARK: - 👀
public extension Truck {
    static var preview = Truck()
}
