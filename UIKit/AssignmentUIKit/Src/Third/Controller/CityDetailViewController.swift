//
//  CityDetailViewController.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

final class CityDetailViewController: BaseTableViewController {
    
    public var delegate: CityDetailDelegate?
    
    private var currentIndex: Int!
    
    private var model: CityWeather? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(model: CityWeather, currentIndex: Int) {
        self.currentIndex = currentIndex
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateDetail()
    }
}

extension CityDetailViewController {
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityDetailMainTableViewCell.self,
                           forCellReuseIdentifier: CityDetailMainTableViewCell.className)
    }
}

//MARK: - UITableView Delegate & Datasource
extension CityDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = model else { return 0 }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: CityDetailMainTableViewCell.self, for: indexPath)
        cell.city = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Network
extension CityDetailViewController {
    internal func updateDetail() {
        guard let id = model?.id else { return }
        let key = API.secrectKey
        let url = API.weatherByCityName + "?id=\(id)&appid=\(key)"
        
        Network.shared.sendPostRequest(to: url) { [weak self] in
            switch $0 {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let data):
                do {
                    let newModel = try JSONDecoder().decode(CityWeather.self, from: data)
                    
                    self?.model = newModel
                    if let index = self?.currentIndex {
                        self?.delegate?.didUpdateCity(newModel, at: index)
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
