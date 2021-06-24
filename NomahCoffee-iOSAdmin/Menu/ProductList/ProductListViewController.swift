//
//  ProductListViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: Properties
    
    private var productType: ProductType
        
    private lazy var productListView: ProductListView = {
        let productListView = ProductListView()
        return productListView
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(productListView)
        
        productListView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        switch productType {
        case .coffee:
            NetworkingManager.getCoffee(completion: { coffees in
                guard let coffees = coffees else { return }
                self.productListView.viewModel = ProductListViewModel(coffees: coffees)
            })
        }
        
        title = productType.navigationTitle
    }
    
    init(productType: ProductType) {
        self.productType = productType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
