//
//  ProductListView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

protocol ProductListViewDelegate {
    /// Trigger the navigation controller to push a new view controller
    /// - Parameter viewController: the `ProductEditorViewController` to push onto the stack
    func present(viewController: ProductEditorViewController)
}

class ProductListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Properties
    
    var delegate: ProductListViewDelegate?
    
    var viewModel: ProductListViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = ProductListConstants.cellSize
        layout.sectionInset = ProductListConstants.collectionViewInsets
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductListCell.self,
                                forCellWithReuseIdentifier: ProductListCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.coffees.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.reuseIdentifier,
                                                          for: indexPath) as? ProductListCell,
            let coffee = viewModel?.coffees[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        
        cell.coffee = coffee
        return cell
    }
        
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let coffee = viewModel?.coffees[indexPath.row] else { return }
        let productEditorViewController = ProductEditorViewController(productType: .coffee, actionType: .edit)
        productEditorViewController.viewModel = ProductEditorViewModel(coffee: coffee)
        delegate?.present(viewController: productEditorViewController)
    }
    
}
