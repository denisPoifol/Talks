//: [Previous](@previous)

import Foundation
import PlaygroundSupport
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


// Type Erasure pattern from std lib

class _AnyConfigurableBase<ModelObject>: Configurable {

    typealias Model = ModelObject

    init() {
        guard type(of: self) != _AnyConfigurableBase.self else {
            fatalError("This class cannot be implemented")
        }
    }

    func configure(with model: ModelObject) {
        fatalError("Must be overiden")
    }
}

class _AnyConfigurableBox<ActualType: Configurable>: _AnyConfigurableBase<ActualType.Model> {
    private let configurable: ActualType

    init(_ configurable: ActualType) {
        self.configurable = configurable
    }

    override func configure(with model: Model) {
        configurable.configure(with: model)
    }
}

final class AnyConfigurable<Model>: Configurable {
    private let box: _AnyConfigurableBase<Model>

    init<Concrete: Configurable>(_ concrete: Concrete) where Concrete.Model == Model {
        box = _AnyConfigurableBox(concrete)
    }

    func configure(with model: Model) {
        box.configure(with: model)
    }
}

// Example UseCase

protocol ViewContract {
    var successLabel: AnyConfigurable<String> { get }
}

class ViewController: UIViewController, ViewContract {
    private(set) lazy var successLabel = AnyConfigurable(labelOrButton)

    private var labelOrButton =
//        UIButton(type: .custom)
        UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        view.addSubview(labelOrButton)
        labelOrButton.translatesAutoresizingMaskIntoConstraints = false
        labelOrButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelOrButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

let viewController = ViewController()
let viewContract = viewController as ViewContract
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true


viewContract.successLabel.configure(with: "awesome")


//@next

