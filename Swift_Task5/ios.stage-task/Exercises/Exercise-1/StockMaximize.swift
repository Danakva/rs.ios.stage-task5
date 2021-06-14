import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        if Set(prices).count <= 1 {
            return 0
        }
        return getProfit(prices)
    }
    
    func getProfit(_ prices: [Int]) -> Int {
        guard prices.count != 0 else { return 0 }
        let sortedPrices = prices.sorted { $1 < $0 }
        let max = sortedPrices[0]
        
        guard let firstIndexOfMax = prices.firstIndex(of: max) else { return 0 }
        let tempArray = Array(prices[0..<firstIndexOfMax])
        let prof = max * tempArray.count - tempArray.reduce(0, +)
        if firstIndexOfMax + 1 != prices.count {
            return prof + getProfit(Array(prices.suffix(from: firstIndexOfMax + 1)))
        } else {
            return prof
        }
    }
    
}
