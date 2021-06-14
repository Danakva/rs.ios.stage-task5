import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        if message.count > 60 || message.count < 1 {
            return ""
        }
        return decrypt(message)
    }
    
    func decrypt(_ message: String) -> String {
        var chars = Array(message)
        var lastOpenBraces: (index: Int, multiplier: String)?
        var numberArray = [String]()
        for (index, symbol) in chars.enumerated() {
            if symbol.isNumber {
                numberArray.append(String(symbol))
            } else if symbol == "[" {
                let strValue = numberArray.joined()
                numberArray = []
                lastOpenBraces = (index, strValue)
            } else if symbol == "]" {
                guard let lastOpen = lastOpenBraces else {
                    return ""
                }
                let insideBraces = Array(chars[lastOpen.index+1..<index])
                var newInsideBraces = [String.Element]()
                if Int(lastOpen.multiplier) ?? 300 > 300 {
                    return ""
                }
                for _ in 0..<(Int(lastOpen.multiplier) ?? 1) {
                    newInsideBraces.append(contentsOf: insideBraces)
                }
                chars.replaceSubrange(lastOpen.index - lastOpen.multiplier.count...index, with: newInsideBraces)
                break
            }
        }
        if message == String(chars) {
            return message
        } else {
            return decrypt(String(chars))
        }
    }
}
