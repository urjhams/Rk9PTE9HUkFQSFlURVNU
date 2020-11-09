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
        setupRefresher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities() { [weak self] in
            self?.getListCitiesHandle(from: $0)
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
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc private func longPressHandler(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == UIGestureRecognizer.State.began else { return }
        let touchPoint = sender.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        handleDeleteCity(at: indexPath.row)
    }
    
    private func setupRefresher() {
        refresher.tintColor = .systemGray
        refresher.addTarget(self, action: #selector(reloadListCities), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    @objc private func reloadListCities() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loadCities() {
                self?.getListCitiesHandle(from: $0)
                self?.refresher.endRefreshing()
            }
        }
    }
}

extension CitiesViewController {
    
    private func handleDeleteCity(at index: Int) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alert = UIAlertController(title: "Delete this city",
                                      message: "Are you sure?",
                                      preferredStyle: .actionSheet)
        
        let acceptAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.cities.remove(at: index)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    private func getListCitiesHandle(from data: Data) {
        do {
            let model = try JSONDecoder().decode(ListCityWeather.self, from: data)
            if let list = model.list { cities = list }
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
