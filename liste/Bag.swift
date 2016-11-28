//
//  Bag.swift
//  Aufteilen
//
//  Created by Daniel Riewe on 28.11.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import Foundation

struct Bag<Element: Hashable> {
    // 1
    fileprivate var contents: [Element: Int] = [:]
    
    // 2
    var uniqueCount: Int {
        return contents.count
    }
    
    // 3
    var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }
    
    // 1
    init() { }
    
    // 2
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            add(element)
        }
    }
    
    // 3
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Element, value: Int) {
        for (element, count) in sequence {
            add(element, occurrences: count)
        }
    }
    
    // 1
    mutating func add(_ member: Element, occurrences: Int = 1) {
        // 2
        precondition(occurrences > 0, "Can only add a positive number of occurrences")
        
        // 3
        if let currentCount = contents[member] {
            contents[member] = currentCount + occurrences
        } else {
            contents[member] = occurrences
        }
    }
    
    mutating func remove(_ member: Element, occurrences: Int = 1) {
        // 1
        guard let currentCount = contents[member], currentCount >= occurrences else {
            preconditionFailure("Removed non-existent elements")
        }
        
        // 2
        precondition(occurrences > 0, "Can only remove a positive number of occurrences")
        
        // 3
        if currentCount > occurrences {
            contents[member] = currentCount - occurrences
        } else {
            contents.removeValue(forKey: member)
        }
    }
}

extension Bag: CustomStringConvertible {
    var description: String {
        return String(describing: contents)
    }
}

extension Bag: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension Bag: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Element, Int)...) {
        // The map converts elements to the "named" tuple the initializer expects.
        self.init(elements.map { (key: $0.0, value: $0.1) })
    }
}

extension Bag: Sequence {
    // 1
    typealias Iterator = AnyIterator<(element: Element, count: Int)>
    
    func makeIterator() -> Iterator {
        // 2
        var iterator = contents.makeIterator()
        
        // 3
        return AnyIterator {
            return iterator.next()
        }
    }
}

extension Bag: Collection {
    // 1
    typealias Index = BagIndex<Element>
    
    var startIndex: Index {
        // 2.1
        return BagIndex(contents.startIndex)
    }
    
    var endIndex: Index {
        // 2.2
        return BagIndex(contents.endIndex)
    }
    
    subscript (position: Index) -> Iterator.Element {
        precondition((startIndex ..< endIndex).contains(position), "out of bounds")
        // 3
        let dictionaryElement = contents[position.index]
        return (element: dictionaryElement.key, count: dictionaryElement.value)
    }
    
    func index(after i: Index) -> Index {
        // 4
        return Index(contents.index(after: i.index))
    }
}

// 1
struct BagIndex<Element: Hashable> {
    // 2
    fileprivate let index: DictionaryIndex<Element, Int>
    
    // 3
    fileprivate init(_ dictionaryIndex: DictionaryIndex<Element, Int>) {
        self.index = dictionaryIndex
    }
}

extension BagIndex: Comparable {
    static func == (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index == rhs.index
    }
    
    static func < (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index < rhs.index
    }
}
