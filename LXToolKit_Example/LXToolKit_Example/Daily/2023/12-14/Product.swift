//
//  Product.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/14.
//

import Foundation

// struct Product: Codable {
struct Product {
    var title: String
    var yearIntroduced: Date
    var introPrice: Double
    var color: ColorKind

    enum CodingKeys: String, CodingKey {
        case title
        case yearIntroduced
        case introPrice
        case color
    }

    private static let priceFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.formatterBehavior = .default
        return nf
    }()
    private static let yearFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        return df
    }()

    // init(title: String, yearIntroduced: Date, introPrice: Double, color: ColorKind) {
    //     self.title = title
    //     self.yearIntroduced = yearIntroduced
    //     self.introPrice = introPrice
    //     self.color = color
    // }
}

// MARK: - 🔐
extension Product {
    enum ColorKind: Int {
        case red = 0
        case green = 1
        case blue = 2
        case undedefined = 3

        var suggestedColor: UIColor {
            switch self {
            case .red: return .systemRed
            case .green: return .systemGreen
            case .blue: return .systemBlue
            case .undedefined: return .label
            }
        }
    }
}

// MARK: - 👀
extension Product {
    func formattedPrice() -> String? {
        return Product.priceFormatter.string(from: NSNumber(value: introPrice))
    }
    func formattedDate() -> String? {
        return Product.yearFormatter.string(from: yearIntroduced)
    }
}

// MARK: - 👀
extension Product: Hashable {}
