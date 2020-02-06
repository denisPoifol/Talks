import Foundation
import UIKit

public struct TableViewModel<HeaderFooterViewModel, CellViewModel> {
    public typealias Section = TableSectionViewModel<HeaderFooterViewModel, CellViewModel>

    public var sections: [Section]

    public var headers: LazyMapCollection<[Section], HeaderFooterViewModel?> { return sections.lazy.map { $0.header } }
    public var footers: LazyMapCollection<[Section], HeaderFooterViewModel?> { return sections.lazy.map { $0.footer } }

    public init(sections: [Section]) {
        self.sections = sections
    }

    public init(section: Section) {
        self.init(sections: [section])
    }

    public init(cells: [CellViewModel]) {
        let section = Section(cells: cells)
        self.init(section: section)
    }

    public init() {
        self.init(sections: [])
    }

    public subscript(indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section][indexPath[1]]
    }
}
extension TableSectionViewModel: Equatable where CellViewModel: Equatable, HeaderFooterViewModel: Equatable {}
extension TableSectionViewModel: Hashable where CellViewModel: Hashable, HeaderFooterViewModel: Hashable {}
extension TableViewModel: Equatable where CellViewModel: Equatable, HeaderFooterViewModel: Equatable {}
extension TableViewModel: Hashable where CellViewModel: Hashable, HeaderFooterViewModel: Hashable {}

public struct TableSectionViewModel<HeaderFooterViewModel, CellViewModel> {

    public init(id: String = "",
         header: HeaderFooterViewModel? = nil,
         cells: [CellViewModel],
         footer: HeaderFooterViewModel? = nil) {
        self.id = id
        self.header = header
        self.cells = cells
        self.footer = footer
    }

    public init() {
        self.init(cells: [])
    }

    public var header: HeaderFooterViewModel?
    public var cells: [CellViewModel]
    public var footer: HeaderFooterViewModel?
    public var id: String
}

extension TableViewModel: Collection {
    public typealias Index = Int
    public typealias Element = TableSectionViewModel<HeaderFooterViewModel, CellViewModel>

    public var startIndex: Int { return sections.startIndex }
    public var endIndex: Int { return sections.endIndex }

    public subscript(index: Index) -> Section {
        get { return sections[index] }
        set { sections[index] = newValue }
    }

    public func index(after i: Index) -> Index {
        return sections.index(after: i)
    }
}

extension TableSectionViewModel: Collection {
    public typealias Index = Int
    public typealias Element = CellViewModel

    public var startIndex: Int { return cells.startIndex }
    public var endIndex: Int { return cells.endIndex }

    public subscript(index: Index) -> CellViewModel {
        get { return cells[index] }
        set { cells[index] = newValue }
    }

    public func index(after i: Index) -> Index {
        return cells.index(after: i)
    }
}

extension TableViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        TableSectionViewModel<HeaderFooterViewModel, CellViewModel> == C.Element,
        TableViewModel<HeaderFooterViewModel, CellViewModel>.Index == R.Bound {
            sections.replaceSubrange(subrange, with: newElements)
    }

}
extension TableSectionViewModel: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C: Swift.Collection,
        R: RangeExpression,
        CellViewModel == C.Element,
        TableSectionViewModel<HeaderFooterViewModel, CellViewModel>.Index == R.Bound {
            cells.replaceSubrange(subrange, with: newElements)
    }
}
