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

    public func configure(with viewModel: SimpleTableViewModel) {
        let changeSets = StagedChangeset<SimpleTableViewModel>(source: dataSource.viewModel, target: viewModel)
        tableView.reload(using: changeSets, with: .automatic) { viewModel in
            dataSource.viewModel = viewModel
        }
    }

    // MARK: - Private methods

    private func setUp() {
        tableView.dataSource = dataSource
    }
}

public typealias SimpleTableViewModel = TableViewModel<Never, String>

public class DataSource: NSObject, UITableViewDataSource {

    public var viewModel = SimpleTableViewModel()

    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel[section].cells.count
    }

    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = viewModel[indexPath]
        return tableViewCell
    }
}
