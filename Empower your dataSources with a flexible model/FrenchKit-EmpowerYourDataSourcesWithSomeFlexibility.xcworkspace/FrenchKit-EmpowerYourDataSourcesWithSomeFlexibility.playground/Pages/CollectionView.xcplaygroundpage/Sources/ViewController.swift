import Foundation
import UIKit
import DifferenceKit

public class ViewController: UIViewController {

    private lazy var collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    private lazy var dataSource = DataSource()

    override public func loadView() {
        view = collectionView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - Public

    public func configure(with viewModel: SimpleCollectionViewModel) {
        let changeSets = StagedChangeset<SimpleCollectionViewModel>(source: dataSource.viewModel, target: viewModel)
        collectionView.reload(using: changeSets) { viewModel in
            dataSource.viewModel = viewModel
        }
    }

    // MARK: - Private methods

    private func setUp() {
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

public typealias SimpleCollectionViewModel = CollectionViewModel<Never, UIColor>

public class DataSource: NSObject, UICollectionViewDataSource {

    public var viewModel = SimpleCollectionViewModel()

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].count
    }

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}
