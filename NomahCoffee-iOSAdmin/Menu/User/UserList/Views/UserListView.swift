//
//  UserListView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/23/21.
//

import UIKit

protocol UserListViewDelegate {
    /// Trigger the navigation controller to push a new view controller
    /// - Parameter viewController: the `UIViewController` to push onto the stack
    func push(viewController: UIViewController)
}

class UserListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    var delegate: UserListViewDelegate?
    
    var viewModel: UserListViewModel? {
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
    
    init() {
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
        return viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = viewModel?.users[indexPath.row].username
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel?.users[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let userEditorViewController = UserEditorViewController(actionType: .editOther(user: user))
        delegate?.push(viewController: userEditorViewController)
    }

}
