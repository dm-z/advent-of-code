func arrayFrom(data: String) -> [String] {
    var array = [String]()
    for line in data.split(separator: "\n") {
        array.append(String(line))
    }
    return array
}

func isSafelySorted(string: String, minDiff: Int, maxDiff: Int) -> Bool {
    let array = string.split(separator: " ").map { Int($0) ?? 0 }
    return isSafelySorted(array: array, minDiff: minDiff, maxDiff: maxDiff)
}

func isSafelySorted(array: [Int], minDiff: Int, maxDiff: Int) -> Bool
{
    var previous: Int? = nil
    var diff:Int = 0
    for element in array {
        if previous == nil {
            previous = element
            continue
        }
        let newDiff = previous! - element
        
        if abs(newDiff) >= minDiff,
            abs(newDiff)<=maxDiff,
           newDiff * diff >= 0 {
            diff = newDiff
            previous = element
        } else {
            return false
        }
    }
    return true
}

func numOfSafelySortedIn(data: String) -> Int {
    var sum = 0
    let lines = arrayFrom(data: data)
    for line in lines {
        if isSafelySorted(string: line, minDiff: 1, maxDiff: 3) {
            sum += 1
        }
    }
    return sum
}

func numOfSafelySortedWithDampenerIn(data: String) -> Int {
    var sum = 0
    let lines = arrayFrom(data: data)
    for line in lines {
        if isSafelySorted(string: line, minDiff: 1, maxDiff: 3) {
            sum += 1
        } else {
            let array = line.split(separator: " ").map { Int($0) ?? 0 }
            for i in 0..<array.count {
                let newArray = Array(array[..<i] + array[(i + 1)...])
                if isSafelySorted(array: newArray, minDiff: 1, maxDiff: 3) {
                    sum += 1
                    break
                }
            }
        }
    }
    return sum
}

// part 1
print(numOfSafelySortedIn(data: Input.string))

//part 2
print (numOfSafelySortedWithDampenerIn(data: Input.string))
