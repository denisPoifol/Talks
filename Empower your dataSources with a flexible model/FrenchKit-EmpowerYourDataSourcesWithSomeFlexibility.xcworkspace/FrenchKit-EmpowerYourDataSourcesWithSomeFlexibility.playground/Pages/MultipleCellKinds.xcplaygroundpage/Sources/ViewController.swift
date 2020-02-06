import Foundation
import UIKit
import DifferenceKit


public class ViewController: UIViewController {

    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource()

    override public func loadView() {
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - Public

    public func configure(with viewModel: MultipleCellTableViewModel) {
        let changeSets = StagedChangeset<MultipleCellTableViewModel>(source: dataSource.viewModel, target: viewModel)
        tableView.reload(using: changeSets, with: .automatic) { viewModel in
            dataSource.viewModel = viewModel
        }
    }

    // MARK: - Private methods

    private func setUp() {
        tableView.dataSource = dataSource
    }
}

public typealias MultipleCellTableViewModel = TableViewModel<Never, CellViewModel>

public enum CellViewModel: Hashable, Differentiable {
    case left(String)
    case center(String)
    case right(String)
}


public class DataSource: NSObject, UITableViewDataSource {

    public var viewModel = MultipleCellTableViewModel()

    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel[section].cells.count
    }

    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel[indexPath] {
        case let .left(text):
            let tableViewCell = UITableViewCell()
            tableViewCell.textLabel?.text = text
            tableViewCell.textLabel?.textAlignment = .left
            return tableViewCell
        case let .center(text):
            let tableViewCell = UITableViewCell()
            tableViewCell.textLabel?.text = text
            tableViewCell.textLabel?.textAlignment = .center
            return tableViewCell
        case let .right(text):
            let tableViewCell = UITableViewCell()
            tableViewCell.textLabel?.text = text
            tableViewCell.textLabel?.textAlignment = .right
            return tableViewCell
        }
    }
}
