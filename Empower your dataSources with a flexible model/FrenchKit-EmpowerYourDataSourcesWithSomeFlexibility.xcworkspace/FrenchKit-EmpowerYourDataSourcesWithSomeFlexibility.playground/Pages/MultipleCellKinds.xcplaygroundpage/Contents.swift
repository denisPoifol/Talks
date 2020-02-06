//: [SimpleTableView](SimpleTableView)

import UIKit
import DifferenceKit
import PlaygroundSupport

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

let viewModel = MultipleCellTableViewModel(
    cells: [
        .left("This"),
        .center("is"),
        .right("really"),
        .left("simple"),
        .center("to"),
        .right("update"),
    ]
)
viewController.configure(with: viewModel)
//: ### Play me here to see the configurated viewController


let shuffledViewModel = MultipleCellTableViewModel(
    cells: [
        .left("This"),
        .center("is"),
        .right("really"),
        .left("simple"),
        .center("to"),
        .right("update"),
    ].shuffled()
)
viewController.configure(with: shuffledViewModel)
//: ### Play me here to see the updated tableView with animations

let sectionnedTableViewModel = MultipleCellTableViewModel(
    sections: [
        MultipleCellTableViewModel.Section(repeating: .left("Left"), count: 3),
        MultipleCellTableViewModel.Section(repeating: .center("center"), count: 3),
        MultipleCellTableViewModel.Section(repeating: .right("right"), count: 3),
    ]
)
viewController.configure(with: sectionnedTableViewModel)
//: ### Play me here to see the updated tableView with animations
