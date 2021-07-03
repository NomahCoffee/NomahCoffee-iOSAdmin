//
//  ProductListViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

class ProductListViewController: UIViewController, ProductListViewDelegate, ProductProtocol {
    
    // MARK: Properties
    
    private var productType: ProductType
        
    private lazy var productListView: ProductListView = {
        let productListView = ProductListView()
        productListView.delegate = self
        return productListView
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = productType.listNavigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
        
        view.addSubview(productListView)
        
        productListView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        reloadData()
    }
    
    init(productType: ProductType) {
        self.productType = productType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Functions
    
    public func reloadData() {
        switch productType {
        case .coffee:
            NetworkingManager.getCoffee(completion: { coffees in
                guard let coffees = coffees else { return }
                self.productListView.viewModel = ProductListViewModel(coffees: coffees)
            })
        }
    }
    
    // MARK: Actions
    
    @objc func addTapped() {
        let productEditorViewController = ProductEditorViewController(productType: productType, actionType: .create)
        productEditorViewController.productProtocol = self
        productEditorViewController.viewModel = ProductEditorViewModel(coffee: nil)
        let productEditorNavigationController = UINavigationController(rootViewController: productEditorViewController)
        navigationController?.present(productEditorNavigationController, animated: true, completion: nil)
    }
    
    // MARK: ProductListViewDelegate
    
    func present(viewController: ProductEditorViewController) {
        viewController.productProtocol = self
        let productEditorNavigationController = UINavigationController(rootViewController: viewController)
        navigationController?.present(productEditorNavigationController, animated: true)
    }
    
    // MARK: ProductProtocol
    
    func refreshList() {
        reloadData()
    }

}
