//: [Previous](@previous)

import Foundation
import UIKit

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}

extension UIButton: Configurable {
    typealias ViewModel = String
    func configure(with model: String) {
        setTitle(model, for: .normal)
    }
}

extension UILabel: Configurable {
    func configure(with model: String) {
        text = model
    }
}

struct ConfigurableWrapper<ConcreteClass: Configurable>: Configurable {
    typealias Model = ConcreteClass.Model
    private let wrappedInstance: ConcreteClass

    init(_ wrappedInstance: ConcreteClass) {
        self.wrappedInstance = wrappedInstance
    }

    func configure(with model: Model) {
        wrappedInstance.configure(with: model)
    }
}

let button = UIButton()
let label = UILabel()

let configurableButton = ConfigurableWrapper(button)
let configurableLabel = ConfigurableWrapper(label)

// Cool, I can store Configurable in a variable


type(of: configurableButton)
type(of: configurableLabel)
// Meh, not that cool


//: [Next](@next)
