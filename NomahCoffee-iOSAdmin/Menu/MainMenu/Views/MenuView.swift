//
//  MenuView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/28/21.
//

import UIKit
import SnapKit

protocol MenuViewDelegate {
    func present(viewController: UIViewController)
}

class MenuView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    var delegate: MenuViewDelegate?
    
    private var viewModel: MenuTableViewModel {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: Init
    
    init(viewModel: MenuTableViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? UITableViewCell else { return UITableViewCell() }

        cell.textLabel?.text = viewModel.menuOptions[indexPath.row].title
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.present(viewController: viewModel.menuOptions[indexPath.row].detailController)
    }

}
