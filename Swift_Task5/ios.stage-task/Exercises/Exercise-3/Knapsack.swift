import Foundation

public typealias Supply = (weight: Int, value: Int)
struct AdvSupply {
    enum Typee {
        case food
        case drink
    }
    let supply: Supply
    let type: Typee
}

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    var resFoodSupply: [Supply] = []
    var resDrinkSupply: [Supply] = []
    
    var currentWeight: Int {
        resFoodSupply.reduce(0) { $0 + $1.weight } + resDrinkSupply.reduce(0) { $0 + $1.weight }
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var advSupplies = [AdvSupply]()
        advSupplies.append(contentsOf: drinks.map { AdvSupply(supply: $0, type: .drink)})
        advSupplies.append(contentsOf: foods.map { AdvSupply(supply: $0, type: .food)})
        let combinations = advSupplies.combinationsWithoutRepetition.filter { !$0.isEmpty }
        let allCombinations = combinations.filter { $0.contains{ $0.type == .drink } && $0.contains { $0.type == .food } && $0.reduce(0){ $0 + $1.supply.weight} <= maxWeight }
        let results = allCombinations.map { arr -> Int in
            let foodKm = arr.filter { $0.type == .food }.reduce(0) { $0 + $1.supply.value }
            let drinkKm = arr.filter { $0.type == .drink }.reduce(0) { $0 + $1.supply.value }
            return min(foodKm, drinkKm)
        }.sorted(by: >)
        return results.isEmpty ? 0 : results[0]
    }
}

extension Array {
    var combinationsWithoutRepetition: [[Element]] {
        guard !isEmpty else { return [[]] }
        return Array(self[1...]).combinationsWithoutRepetition.flatMap { [$0, [self[0]] + $0] }
    }
}
