func arraysFromData(data: String, leftArray: inout [Int], rightArray: inout [Int]) {
    for line in data.split(separator: "\n") {
        let values = line.split(separator: "   ")
        leftArray.append(Int(values.first!)!)
        rightArray.append(Int(values.last!)!)
    }
}

func sortedArray(array: [Int]) -> [Int] {
    let newArray = array.sorted {$0 < $1}
    return newArray
}

func sumFromDistances(data: String) -> UInt {
    var sum: UInt = 0
    var left = [Int]()
    var right = [Int]()
    arraysFromData(data: data, leftArray: &left, rightArray: &right)
    let sortedLeft = sortedArray(array: left)
    let sortedRight = sortedArray(array: right)
    var globalIndex = 0
    while globalIndex < sortedLeft.count {
        let number1 = sortedLeft[globalIndex]
        let number2 = sortedRight[globalIndex]
        sum = sum + UInt(abs(number1 - number2))
        globalIndex += 1
    }
    
    return sum
}

// part 1
print(sumFromDistances(data: Input.string))

func num(item: Int, in array:[Int]) -> Int {
    var count = 0
    for elem in array {
        if elem == item { count += 1 }
    }
    return count
}

func similaritySum(data: String) -> UInt {
    var sum: UInt = 0
    var left = [Int]()
    var right = [Int]()
    arraysFromData(data: data, leftArray: &left, rightArray: &right)
    let leftSet = Set (left)
    for item in leftSet {
        sum = sum + UInt(item * num(item: item, in: right))
    }
    
    return sum
}

// part 2
print(similaritySum(data: Input.string))
