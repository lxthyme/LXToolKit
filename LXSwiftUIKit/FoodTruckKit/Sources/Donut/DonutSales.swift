//
//  File.swift
//  
//
//  Created by lxthyme on 2023/9/1.
//

import Foundation

public struct DonutSales: Identifiable, Comparable {
    public var id: Donut.ID { donut.id }
    public var donut: Donut
    public var sales: Int
    public static func <(lhs: DonutSales, rhs: DonutSales) -> Bool {
        if lhs.sales == rhs.sales {
            return lhs.donut.id < rhs.donut.id
        } else {
            return lhs.sales < rhs.sales
        }
    }
}

// MARK: - 👀
public extension DonutSales {
    static var previewArray: [DonutSales] = [
        .init(donut: .classic, sales: 5),
        .init(donut: .picnicBasket, sales: 3),
        .init(donut: .strawberrySprinkles, sales: 10),
        .init(donut: .nighttime, sales: 4),
        .init(donut: .blackRaspberry, sales: 12)
    ]
}
