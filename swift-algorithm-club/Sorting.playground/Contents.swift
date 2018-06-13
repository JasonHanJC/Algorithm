//: Insertion sort O(n^2)

func insertionSort<T: Comparable>(elements: inout [T]) {
    for i in 0..<elements.count {
        var j = i
        while j > 0 && elements[j] < elements[j - 1] {
            elements.swapAt(j - 1, j)
            j -= 1
        }
    }
}

var array = [ 8, 3, 5, 4, 6 ]
//insertionSort(elements: &array)
//array

//: Selection sort O(n^2)
// find the smallest element everytime


//: Shell Sort

public func shellSort(_ list: inout [Int]) {
    var sublistCount = list.count / 2
    while sublistCount > 0 {
        for pos in 0..<sublistCount {
            // insertionSort(&list, start: pos, gap: sublistCount)
        }
        sublistCount = sublistCount / 2
    }
}

3 & 4

