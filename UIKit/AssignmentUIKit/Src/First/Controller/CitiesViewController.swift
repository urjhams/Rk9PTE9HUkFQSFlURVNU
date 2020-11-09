//
//  CitiesViewController.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

protocol CityDetailDelegate: AnyObject {
    func didUpdateCity(_ model: CityWeather, at index: Int)
}

protocol AddCityDelegate: AnyObject {
    func didAddNewCity(_ name: String?)
}

final class CitiesViewController: BaseTableViewController {
    
    public var cities = [CityWeather]() {
        didSet {
            tableView.reloadData()
            saveCities()
        }
    }
    
    private let refresher = UIRefreshControl()
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities() {[weak self] in
            self?.gotListCities(from: $0)
        }
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.className)
    }
    
    private func setupRefresher() {
        
    }
}

extension CitiesViewController {
    
    private func gotListCities(from data: Data) {
        do {
            let model = try JSONDecoder().decode(ListCityWeather.self, from: data)
            if let list = model.list {
                cities = list
            }
        } catch {
            showNotificationAlert("Error", withContent: error.localizedDescription)
        }
    }
    
    private func saveCities() {
        let data = cities.map { return CityData(from: $0) }
        AppData.savedCities = data
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

//MARK: - CityDetailDelegate
extension CitiesViewController: CityDetailDelegate {
    func didUpdateCity(_ model: CityWeather, at index: Int) {
        // if index is still inside the array range
        if cities.count > index {
            cities[index] = model
        }
    }
}
