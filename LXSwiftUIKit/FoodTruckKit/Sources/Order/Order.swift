//
//  Order.swift
//  
//
//  Created by lxthyme on 2023/8/25.
//

import Foundation
import SwiftUI

public struct Order: Identifiable, Equatable {
    public var id: String

    // order
    public var status: OrderStatus
    public var donuts: [Donut]
    public var sales: [Donut.ID: Int]
    public var grandTotal: Decimal

    // location
    public var city: City.ID
    public var parkingSpot: ParkingSpot.ID

    // metadata
    public var creationDate: Date
    public var completionDate: Date?
    public var temperature: Measurement<UnitTemperature>
    public var wasRaining: Bool

    public var duration: TimeInterval? {
        guard let completionDate else { return nil }
        return completionDate.timeIntervalSince(creationDate)
    }
    public var totalSales: Int {
        sales
            .map(\.value)
            .reduce(0, +)
    }
    public mutating func markAsComplete() {
        if case .completed = status {
            return
        }
        self.completionDate = .now
        self.status = .completed
    }
    public mutating func markAsNextStep(completion: (_ newStatus: OrderStatus) -> Void) {
        switch status {
        case .placed:
            // Next step is to prepare.
            self.status = .preparing
            completion(self.status)
        case .preparing:
            // Next step is to complete the order.
            self.status = .completed
            completion(self.status)
        default: //
            completion(self.status)
            return
        }
    }
    public mutating func markAsPreparing() {
        if case .preparing = status {
            return
        }
        self.status = .preparing
    }
    public var isPreparing: Bool {
        if case .preparing = status {
            return true
        }
        return false
    }
    public var isCompleted: Bool {
        if case .completed = status {
            return true
        }
        return false
    }
    public var formattedDate: String {
        let date: String = {
            if Calendar.current.isDateInToday(creationDate) {
                return String(localized: "Today")
            } else if Calendar.current.isDateInYesterday(creationDate) {
                return String(localized: "Yesterday")
            } else {
                return creationDate.formatted(date: .numeric, time: .omitted)
            }
        }()
        let time = creationDate.formatted(date: .omitted, time: .shortened)
        return "\(date), \(time)"
    }
    public func matches(searchText: String) -> Bool {
        if id.localizedCaseInsensitiveContains(searchText) {
            return true
        }
        return false
    }
}

extension Order {
    public static let preview = Order(
        id: String(localized: "Order#\(1203)"),
        status: .ready,
        donuts: [.classic],
        sales: [Donut.classic.id: 1],
        grandTotal: 4.78,
        city: City.cupertino.id,
        parkingSpot: City.cupertino.parkingSpots[0].id,
        creationDate: .now,
        completionDate: nil,
        temperature: .init(value: 72, unit: .fahrenheit),
        wasRaining: false
    )
    public static let preview2 = Order(
        id: String(localized: "Order#\(1204)"),
        status: .ready,
        donuts: [.picnicBasket, .blackRaspberry],
        sales: [Donut.picnicBasket.id: 2, Donut.blackRaspberry.id: 1],
        grandTotal: 4.78,
        city: City.cupertino.id,
        parkingSpot: City.cupertino.parkingSpots[0].id,
        creationDate: .now,
        completionDate: nil,
        temperature: .init(value: 72, unit: .fahrenheit),
        wasRaining: false
    )
    public static let preview3 = Order(
        id: String(localized: "Order#\(1205)"),
        status: .ready,
        donuts: [.classic],
        sales: [Donut.classic.id: 1],
        grandTotal: 4.78,
        city: City.cupertino.id,
        parkingSpot: City.cupertino.parkingSpots[0].id,
        creationDate: .now,
        completionDate: nil,
        temperature: .init(value: 72, unit: .fahrenheit),
        wasRaining: false
    )
    public static let preview4 = Order(
        id: String(localized: "Order#\(1206)"),
        status: .ready,
        donuts: [.fireZest, .superLemon, .daytime],
        sales: [Donut.fireZest.id: 1, Donut.superLemon.id: 1, Donut.daytime.id: 1],
        grandTotal: 4.78,
        city: City.cupertino.id,
        parkingSpot: City.cupertino.parkingSpots[0].id,
        creationDate: .now,
        completionDate: nil,
        temperature: .init(value: 72, unit: .fahrenheit),
        wasRaining: false
    )

    public static let previewArray = [preview, preview2, preview3, preview4]
}

public enum OrderStatus: Int, Codable, Comparable {
    case placed, preparing, ready, completed

    public var title: String {
        switch self {
        case .placed:
            return String(localized: "Placed", bundle: .main, comment: "Order status.")
        case .preparing:
            return String(localized: "Preparing", bundle: .main, comment: "Order status.")
        case .ready:
            return String(localized: "Ready", bundle: .main, comment: "Order status.")
        case .completed:
            return String(localized: "Completed", bundle: .main, comment: "Order status.")
        }
    }

    public var buttonTitle: String {
        switch self {
        case .placed:
            return String(localized: "Prepare", bundle: .main, comment: "Order next step.")
        case .preparing:
            return String(localized: "Ready", bundle: .main, comment: "Order next step.")
        case .ready:
            return String(localized: "Complete", bundle: .main, comment: "Order next step.")
        case .completed:
            return String(localized: "Complete", bundle: .main, comment: "Order next step.")
        }
    }

    public var iconSystemName: String {
        switch self {
        case .placed:
            return "paperplane"
        case .preparing:
            return "timer"
        case .ready:
            return "checkmark.circle"
        case .completed:
            return "shippingbox"
        }
    }

    public var label: some View {
        Label(title, systemImage: iconSystemName)
    }

    public static func <(lhs: OrderStatus, rhs: OrderStatus) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
