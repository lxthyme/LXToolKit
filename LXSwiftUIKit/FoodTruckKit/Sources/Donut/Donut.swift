//
//  File.swift
//  
//
//  Created by lxthyme on 2023/9/1.
//

import SwiftUI
import UniformTypeIdentifiers

public struct Donut: Identifiable, Hashable {
    public var id: Int
    public var name: String

    public var dough: Dough
    public var glaze: Glaze?
    public var topping: Topping?

    public var ingredients: [any Ingredient] {
        var result: [any Ingredient] = []
        result.append(dough)
        if let glaze {
            result.append(glaze)
        }
        if let topping {
            result.append(topping)
        }
        return result
    }
    public var flavors: FlavorProfile {
        ingredients
            .map(\.flavors)
            .reduce(into: FlavorProfile()) { partialResult, next in
                partialResult.formUnion(with: next)
            }
    }
    public func matches(searchText: String) -> Bool {
        if searchText.isEmpty {
            return true
        }
        if name.localizedCaseInsensitiveContains(searchText) {
            return true
        }

        return ingredients.contains { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

// MARK: - 👀
public extension Donut {
    static let classic = Donut(
        id: 0,
        name: String(localized: "The Classic", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .sprinkles
    )

    static let blueberryFrosted = Donut(
        id: 1,
        name: String(localized: "Blueberry Frosted", bundle: .main, comment: "A donut-flavor name."),
        dough: .blueberry,
        glaze: .blueberry,
        topping: .sugarLattice
    )

    static let strawberryDrizzle = Donut(
        id: 2,
        name: String(localized: "Strawberry Drizzle", bundle: .main, comment: "A donut-flavor name."),
        dough: .strawberry,
        glaze: .strawberry,
        topping: .sugarDrizzle
    )

    static let cosmos = Donut(
        id: 3,
        name: String(localized: "Cosmos", bundle: .main, comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .chocolate,
        topping: .starSprinkles
    )

    static let strawberrySprinkles = Donut(
        id: 4,
        name: String(localized: "Strawberry Sprinkles", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .strawberry,
        topping: .starSprinkles
    )

    static let lemonChocolate = Donut(
        id: 5,
        name: String(localized: "Lemon Chocolate", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .lemonLines
    )

    static let rainbow = Donut(
        id: 6,
        name: String(localized: "Rainbow", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .rainbow
    )

    static let picnicBasket = Donut(
        id: 7,
        name: String(localized: "Picnic Basket", bundle: .main, comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .strawberry,
        topping: .blueberryLattice
    )

    static let figureSkater = Donut(
        id: 8,
        name: String(localized: "Figure Skater", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .blueberry,
        topping: .sugarDrizzle
    )

    static let powderedChocolate = Donut(
        id: 9,
        name: String(localized: "Powdered Chocolate", bundle: .main, comment: "A donut-flavor name."),
        dough: .chocolate,
        topping: .powderedSugar
    )

    static let powderedStrawberry = Donut(
        id: 10,
        name: String(localized: "Powdered Strawberry", bundle: .main, comment: "A donut-flavor name."),
        dough: .strawberry,
        topping: .powderedSugar
    )

    static let custard = Donut(
        id: 11,
        name: String(localized: "Custard", bundle: .main, comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .spicy,
        topping: .lemonLines
    )

    static let superLemon = Donut(
        id: 12,
        name: String(localized: "Super Lemon", bundle: .main, comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .lemon,
        topping: .sprinkles
    )

    static let fireZest = Donut(
        id: 13,
        name: String(localized: "Fire Zest", bundle: .main, comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .spicy,
        topping: .spicySauceDrizzle
    )

    static let blackRaspberry = Donut(
        id: 14,
        name: String(localized: "Black Raspberry", bundle: .main, comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .blueberryDrizzle
    )

    static let daytime = Donut(
        id: 15,
        name: String(localized: "Daytime", bundle: .main, comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .rainbow
    )

    static let nighttime = Donut(
        id: 16,
        name: String(localized: "Nighttime", bundle: .main, comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .chocolate,
        topping: .chocolateDrizzle
    )

    static let all = [
        classic, blueberryFrosted, strawberryDrizzle,
        cosmos, strawberrySprinkles, lemonChocolate,
        rainbow, picnicBasket, figureSkater,
        powderedChocolate, powderedStrawberry, custard,
        superLemon, fireZest, blackRaspberry, daytime, nighttime
    ]
}


// MARK: - 👀
public extension UTType {
    static let donut = UTType(exportedAs: "com.example.apple-samplecode.donut")
}
