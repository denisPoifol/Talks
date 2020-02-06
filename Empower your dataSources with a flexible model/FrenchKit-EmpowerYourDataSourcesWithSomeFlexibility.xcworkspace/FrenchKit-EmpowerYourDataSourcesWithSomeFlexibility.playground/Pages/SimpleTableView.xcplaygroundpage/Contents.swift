import UIKit
import DifferenceKit
import PlaygroundSupport




let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

let viewModel = SimpleTableViewModel(
    cells: [
        "This",
        "is",
        "really",
        "simple",
        "to",
        "update",
    ]
)
viewController.configure(with: viewModel)
//: ### Play me here to see the configurated viewController

let shuffledViewModel = SimpleTableViewModel(
    cells: [
        "This",
        "is",
        "really",
        "simple",
        "to",
        "update",
    ].shuffled()
)
viewController.configure(with: shuffledViewModel)
//: ### Play me here to see the updated tableView with animations


let sectionnedTableViewModel = SimpleTableViewModel(
    sections: [
        SimpleTableViewModel.Section(repeating: "Section 1", count: 3),
        SimpleTableViewModel.Section(repeating: "Section 2", count: 3),
        SimpleTableViewModel.Section(repeating: "Section 3", count: 3),
    ]
)
viewController.configure(with: sectionnedTableViewModel)
//: ### Play me here to see the updated tableView with animations
//: [MultipleCellKinds](@next)
