//
//  CitiesViewController.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

protocol AddCityDelegate: AnyObject {
    func didAddNewCity(_ name: String?)
}

final class CitiesViewController: BaseTableViewController {

    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load api
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetup()
    }
}

// MARK: - UI Components setup
extension CitiesViewController {
    
    private func navigationBarSetup() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(clickAddButton))
        navigationItem.setRightBarButton(addButtonItem, animated: true)
        extendedLayoutIncludesOpaqueBars = true
    }
    
    @objc private func clickAddButton(_ sender: Any) {
        let destination = AddCityViewController()
        destination.delegate = self
        present(destination, animated: true)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.className)
    }
}

//MARK: - AddCityDelegate
extension CitiesViewController: AddCityDelegate {
    func didAddNewCity(_ name: String?) {
        guard let name = name else { return }
    }
}

// MARK: - tableView delegate & datasource
extension CitiesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: CityTableViewCell.self, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = CityDetailViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
}
