import Foundation
import DifferenceKit

extension CollectionSectionViewModel: ContentEquatable {
    public func isContentEqual(to source: CollectionSectionViewModel<SupplementaryViewModel, CellViewModel>) -> Bool {
        return id.isContentEqual(to: source.id)
    }
}

extension CollectionSectionViewModel: Differentiable {
    public var differenceIdentifier: String {
        return id
    }
}

extension CollectionSectionViewModel: DifferentiableSection where
    CellViewModel: Hashable & Differentiable,
SupplementaryViewModel: Hashable & Differentiable {
    public init<C>(source: CollectionSectionViewModel,
            elements: C) where C: Swift.Collection, C.Element == CellViewModel {
        self.init(
            id: source.id,
            supplementaryViewModels: source.supplementaryViewModels,
            header: source.header,
            footer: source.footer,
            cells: elements.map { $0 }
        )
    }

    public var elements: [CellViewModel] {
        return cells
    }

    public typealias Collection = [CellViewModel]
}
