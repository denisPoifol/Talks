import Foundation
import DifferenceKit

extension TableSectionViewModel: ContentEquatable {
    public func isContentEqual(to source: TableSectionViewModel<HeaderFooterViewModel, CellViewModel>) -> Bool {
        return id.isContentEqual(to: source.id)
    }
}

extension TableSectionViewModel: Differentiable {
    public var differenceIdentifier: String {
        return id
    }
}

extension TableSectionViewModel: DifferentiableSection where
    CellViewModel: Hashable & Differentiable,
    HeaderFooterViewModel: Hashable & Differentiable {
    public init<C>(source: TableSectionViewModel,
            elements: C) where C: Swift.Collection, C.Element == CellViewModel {
        self.init(
            id: source.id,
            header: source.header,
            cells: elements.map { $0 },
            footer: source.footer
        )
    }

    public var elements: [CellViewModel] {
        return cells
    }

    public typealias Collection = [CellViewModel]
}
