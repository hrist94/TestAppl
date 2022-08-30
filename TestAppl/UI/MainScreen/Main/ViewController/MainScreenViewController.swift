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
    
    private typealias DataSourceHot = UICollectionViewDiffableDataSource<SalesSection, HomeStore>
    private typealias SnapshotHot = NSDiffableDataSourceSnapshot<SalesSection, HomeStore>
    private typealias DataSourceBestSeller = UICollectionViewDiffableDataSource<SalesSection, BestSeller>
    private typealias SnapshotBestSeller = NSDiffableDataSourceSnapshot<SalesSection, BestSeller>
    
    private lazy var contentView = MainScreenView()
    private var bindings = Set<AnyCancellable>()
    private let viewModel: MainScreenViewModel
    private let transition = PanelTransition()
    
    
    
    private var dataSourceHot: DataSourceHot!
    private var dataSourceBestSeller: DataSourceBestSeller!

    
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
        configureDataSource1()
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
        service.fetchBestSellers()
            .sink { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
                self.isFetchingData.value = false
            } receiveValue: { [unowned self] in self.generateSnapshotBest(with: $0)
            }
            .store(in: &self.bindings)
    }
    
   private func generateSnapshot(with hotSales: [HomeStore]) {
        var snapshot = NSDiffableDataSourceSnapshot<SalesSection, HomeStore>()
        snapshot.appendSections([.hotSales])
        snapshot.appendItems(hotSales)
        dataSourceHot.apply(snapshot, animatingDifferences: true)
    }
    
    private func generateSnapshotBest(with offers: [BestSeller]) {
        var snapshot = NSDiffableDataSourceSnapshot<SalesSection, BestSeller>()
        snapshot.appendSections([.bestSellers])
        snapshot.appendItems(offers)
        dataSourceBestSeller.apply(snapshot, animatingDifferences: true)
    } 
}
extension MainScreenViewController {
    private func configureDataSource1() {
        dataSourceHot = DataSourceHot(collectionView: contentView.hotSalesCollectionView.hotSalesCollectionView, cellProvider: { (collectionView, indexPath, offer) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCollectionReusableCell(withType: HotSalesCell.self, for: indexPath)
            cell.viewModel = HotSalesCellViewModel(offer: offer)
            return cell
        })
        dataSourceBestSeller = DataSourceBestSeller(collectionView: contentView.bestSellersCollectionView.bestSellerCollectionView, cellProvider: { (collectionView, indexPath, offer) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCollectionReusableCell(withType: BestSellerCell.self, for: indexPath)
            cell.viewModel = BestSellersCellViewModel(offer: offer)
            return cell
        })
    }
}

enum SalesSection {
    case hotSales
    case bestSellers
}
