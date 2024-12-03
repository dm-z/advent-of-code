import Foundation

let mulPattern = #"mul\((\d{1,3}),(\d{1,3})\)"#

func findSumOfMul(data: String) -> UInt {
    var sum: UInt = 0
    let regExp = try! NSRegularExpression(pattern: mulPattern, options: [])
    let matches = regExp.matches(in: data, options: [], range: NSRange(location: 0, length: data.count))
    
    for match in matches {
        if let range = Range(match.range, in: data) {
            let matchedSubstring = String(data[range])
            sum = sum + mul(data: matchedSubstring)
        }
    }
    
    return sum
}

func mul(data:String) -> UInt {
    let cleanSubstring = data.replacingOccurrences(of: "mul", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    let numbersString = cleanSubstring.split(separator: ",")
    let num1 = UInt(numbersString.first!)!
    let num2 = UInt(numbersString.last!)!
    return num1 * num2
}

// part 1
print(findSumOfMul(data: Input.string))

func enabledOrDisabled(string: String) -> Bool {
    if string == "do()" { return true }
    if string == "don't()" { return false }
    return false
}

func dosAndDonts(data: String) -> UInt {
    let doPattern = #"(do\(\)|don't\(\))"#
    var enabled = true
    var sum: UInt = 0
    
    // Iterate over matches of mul and control instructions
    let pattern = #"mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)"#
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return 0 }
    let matches = regex.matches(in: data, options: [], range: NSRange(data.startIndex..<data.endIndex, in: data))
        
    for match in matches {
        if let range = Range(match.range, in: data) {
            let matchedText = String(data[range])
            
            if let controlMatch = matchedText.range(of: doPattern, options: .regularExpression) {
                enabled = enabledOrDisabled(string: matchedText)
            } else if enabled, let mulMatch = matchedText.range(of: mulPattern, options: .regularExpression) {
                sum += mul(data: matchedText)
            }
        }
    }
    
    return sum
}

// part 2
print(dosAndDonts(data: Input.string))
