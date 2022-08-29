//
//  MainScreenViewController.swift
//  TestApp
//
//  Created by Kirill Khristenko on 28.08.2022.
//

import UIKit
import Combine

final class MainScreenViewController: UIViewController {
    
    var service = MainScreenService.shared
    var isFetchingData = CurrentValueSubject<Bool, Never>(false)
    
    private typealias DataSource = UICollectionViewDiffableDataSource<HotSalesSection, HomeStore>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HotSalesSection, HomeStore>
    
    private lazy var contentView = MainScreenView()
    private var bindings = Set<AnyCancellable>()
    private let viewModel: MainScreenViewModel
    private let transition = PanelTransition()
    
    
    
    private var dataSource: DataSource!
    
    init(viewModel: MainScreenViewModel = MainScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        fetchData()
        configureDataSource()
    }
    
    func fetchData() {
        isFetchingData.value = true
        service.fetchHotSales()
            .sink { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
                self.isFetchingData.value = false
            } receiveValue: { [unowned self] in self.generateSnapshot(with: $0)
            }
            .store(in: &self.bindings)
    }
    
    private func generateSnapshot(with offers: [HomeStore]) {
        var snapshot = NSDiffableDataSourceSnapshot<HotSalesSection, HomeStore>()
        snapshot.appendSections([.main])
        snapshot.appendItems(offers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}
extension MainScreenViewController {
    private func configureDataSource() {
        dataSource = DataSource(collectionView: contentView.hotSalesCollectionView.hotSalesCollectionView, cellProvider: { (collectionView, indexPath, offer) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCollectionReusableCell(withType: HotSalesCell.self, for: indexPath)
            cell.viewModel = HotSalesCellViewModel(offer: offer)
            return cell
        })
    }
}
