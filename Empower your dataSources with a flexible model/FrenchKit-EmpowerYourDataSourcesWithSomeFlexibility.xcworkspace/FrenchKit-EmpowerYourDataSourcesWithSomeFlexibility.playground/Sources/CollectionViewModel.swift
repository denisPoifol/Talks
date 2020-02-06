import Foundation

public struct CollectionViewModel<SupplementaryViewModel, CellViewModel> {
    public typealias Section = CollectionSectionViewModel<SupplementaryViewModel, CellViewModel>

    public var sections: [CollectionSectionViewModel<SupplementaryViewModel, CellViewModel>]

    public init(sections: [Section]) {
        self.sections = sections
    }

    public init(cells: [CellViewModel]) {
        let section = Section(cells: cells)
        self.init(section: section)
    }

    public init(section: Section) {
        self.init(sections: [section])
    }

    public init() {
        self.init(sections: [])
    }

    public var headers: LazyMapCollection<[Section], SupplementaryViewModel?> { return sections.lazy.map { $0.header } }
    public var footers: LazyMapCollection<[Section], SupplementaryViewModel?> { return sections.lazy.map { $0.footer } }

    public func cellViewModel(at indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section].cellViewModel(at: indexPath.row)
    }

    public func supplementaryViewModel(at indexPath: IndexPath, of kind: String) -> SupplementaryViewModel? {
        guard sections.count > indexPath.section else { return nil }
        return sections[indexPath.section].supplementaryViewModel(at: indexPath.row, of: kind)
    }

    public func numberOfItemsInSection(_ section: Int) -> Int {
        return sections[section].cells.count
    }
}

extension CollectionViewModel: Collection {
    public typealias Index = Int
    public typealias Element = CollectionSectionViewModel<SupplementaryViewModel, CellViewModel>

    public var startIndex: Int { return sections.startIndex }
    public var endIndex: Int { return sections.endIndex }

    public subscript(index: Index) -> Element {
        return sections[index]
    }

    public func index(after i: Index) -> Index {
        return sections.index(after: i)
    }
}

extension CollectionViewModel: Equatable where CellViewModel: Equatable, SupplementaryViewModel: Equatable {}
extension CollectionViewModel: Hashable where CellViewModel: Hashable, SupplementaryViewModel: Hashable {}

extension CollectionViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CollectionSectionViewModel<SupplementaryViewModel, CellViewModel> == C.Element,
        CollectionViewModel<SupplementaryViewModel, CellViewModel>.Index == R.Bound {
            sections.replaceSubrange(subrange, with: newElements)
    }

}

public struct CollectionSectionViewModel<SupplementaryViewModel, CellViewModel> {

    public var header: SupplementaryViewModel?
    public var footer: SupplementaryViewModel?
    public var supplementaryViewModels: [[String: SupplementaryViewModel]]
    public var cells: [CellViewModel]
    public let id: String

    public init() {
        self.init(cells: [])
    }

    public init(id: String = "",
         supplementaryViewModels: [[String: SupplementaryViewModel]] = [],
         header: SupplementaryViewModel? = nil,
         footer: SupplementaryViewModel? = nil,
         cells: [CellViewModel]) {
        self.id = id
        self.header = header
        self.footer = footer
        self.supplementaryViewModels = supplementaryViewModels
        self.cells = cells
    }

    public func cellViewModel(at index: Int) -> CellViewModel {
        return cells[index]
    }

    public func supplementaryViewModel(at index: Int, of kind: String) -> SupplementaryViewModel? {
        guard supplementaryViewModels.count > index else { return nil }
        return supplementaryViewModels[index][kind]
    }

    public mutating func insert(_ supplementaryViewModel: SupplementaryViewModel, of kind: String, at index: Int) {
        if !supplementaryViewModels.indices.contains(index) {
            supplementaryViewModels.append(
                contentsOf: Array(
                    repeating: [:],
                    count: index + 1 - supplementaryViewModels.count
                )
            )
        }
        supplementaryViewModels[index][kind] = supplementaryViewModel
    }
}

extension CollectionSectionViewModel: Collection {
    public typealias Index = Int
    public typealias Element = CellViewModel

    public var startIndex: Int { return cells.startIndex }
    public var endIndex: Int { return cells.endIndex }

    public subscript(index: Index) -> Element {
        return cells[index]
    }

    public func index(after i: Index) -> Index {
        return cells.index(after: i)
    }
}

extension CollectionSectionViewModel: Equatable where CellViewModel: Equatable, SupplementaryViewModel: Equatable {}
extension CollectionSectionViewModel: Hashable where CellViewModel: Hashable, SupplementaryViewModel: Hashable {}

extension CollectionSectionViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CellViewModel == C.Element,
        CollectionSectionViewModel<SupplementaryViewModel, CellViewModel>.Index == R.Bound {
            cells.replaceSubrange(subrange, with: newElements)
    }
}


