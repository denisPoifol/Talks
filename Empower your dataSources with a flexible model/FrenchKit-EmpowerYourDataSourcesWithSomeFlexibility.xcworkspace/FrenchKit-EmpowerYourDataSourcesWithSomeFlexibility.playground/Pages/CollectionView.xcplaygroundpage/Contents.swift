//: [Previous](@previous)
import UIKit
import DifferenceKit
import PlaygroundSupport

let colors: [UIColor] = [
    .red,
    .blue,
    .green,
    .yellow,
    .purple,
    .white,
]

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

let viewModel = SimpleCollectionViewModel(
    cells: Array(repeating: colors, count: 10)
        .flatMap { $0 }
)
viewController.configure(with: viewModel)
//: ### Play me here to see the configurated viewController

let shuffledViewModel = SimpleCollectionViewModel(
    cells: Array(repeating: colors, count: 10)
        .flatMap { $0 }
        .shuffled()
)
viewController.configure(with: shuffledViewModel)
//: ### Play me here to see the updated collectionView with animations


let sectionnedCollectionViewModel = SimpleCollectionViewModel(
    sections: [
        SimpleCollectionViewModel.Section(cells: colors),
        SimpleCollectionViewModel.Section(cells: colors),
        SimpleCollectionViewModel.Section(cells: colors),
    ]
)
viewController.configure(with: sectionnedCollectionViewModel)
//: ### Play me here to see the updated tableView with animations
