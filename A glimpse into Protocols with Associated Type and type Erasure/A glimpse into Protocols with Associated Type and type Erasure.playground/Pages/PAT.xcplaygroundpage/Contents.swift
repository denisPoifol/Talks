//: [Previous](@previous)

import Foundation

protocol Identifiable {
    associatedtype Identifier
    var id: Identifier { get }
}

struct StringIdentifiableStruct: Identifiable {

    let id: String
    /* Other properties */
}

struct IntIdentifiableStruct: Identifiable {
    typealias Identifier = Int
    let id: Int
    /* Other properties */
}

extension Equatable where Self: Identifiable, Self.Identifier: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Hashable where Self: Identifiable, Self.Identifier: Hashable {
    var hashValue: Int { return id.hashValue }
}


extension StringIdentifiableStruct: Hashable {}
extension IntIdentifiableStruct: Hashable {}


let a = StringIdentifiableStruct(id: "id")
let b = IntIdentifiableStruct(id: 0)

let identifiable: Identifiable = a
// Fail

//: [Next](@next)
