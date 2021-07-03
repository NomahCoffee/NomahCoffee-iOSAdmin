//
//  ProductEditorViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/29/21.
//

import UIKit
import SnapKit

class ProductEditorViewController: UIViewController, ProductEditorViewDelegate {
    
    // MARK: Properties
    
    var productProtocol: ProductProtocol?
        
    var viewModel: ProductEditorViewModel?
    
    var actionType: ProductEditorActionType?
    
    var productType: ProductType?
    
    lazy var productEditorView: ProductEditorView = {
        guard
            let viewModel = viewModel,
            let actionType = actionType
        else {
            return ProductEditorView()
        }
        
        let productEditorView = ProductEditorView()
        productEditorView.viewModel = viewModel
        productEditorView.actionType = actionType
        productEditorView.delegate = self
        return productEditorView
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(closeButtonTapped))
        
        view.addSubview(productEditorView)
        
        productEditorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        title = actionType?.navigationTitle
    }
    
    init(productType: ProductType, actionType: ProductEditorActionType) {
        self.productType = productType
        self.actionType = actionType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: ProductEditorViewDelegate
    
    func createCoffee(name: String, price: Double, description: String, inStock: Bool) {
        NetworkingManager.createCoffee(
            name: name,
            price: price,
            description: description,
            inStock: inStock,
            completion: { error in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                self.dismiss(animated: true, completion: {
                    self.productProtocol?.refreshList()
                })
            }
        )
    }
    
    func editCoffee(name: String, price: Double, description: String, inStock: Bool) {
        guard let productId = viewModel?.coffee?.id else {
            errorFound(.productIDDoesNotExist)
            return
        }
        
        NetworkingManager.editCoffee(
            id: productId,
            name: name,
            price: price,
            description: description,
            inStock: inStock,
            completion: { error in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                self.dismiss(animated: true, completion: {
                    self.productProtocol?.refreshList()
                })
            }
        )
    }
    
    func errorFound(_ error: ProductEditorError) {
        let alert = UIAlertController(title: error.errorTitle, message: error.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
