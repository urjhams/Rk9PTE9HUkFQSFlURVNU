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
    
    public var cities = [CityWeather]() {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        guard let name = name else { fatalError("There must be a name in this point") }
        loadWeather(of: name) { [weak self] in
            do {
                let model = try JSONDecoder().decode(CityWeather.self, from: $0)
                
                for index in 0..<(self?.cities ?? [CityWeather]()).count {
                    // if city is already added, just reload the data
                    if model.id == self?.cities[index].id {
                        self?.cities[index] = model
                        return
                    }
                }
                
                self?.cities.append(model)
            } catch {
                self?.showNotificationAlert("Error", withContent: error.localizedDescription)
            }
        }
    }
}
