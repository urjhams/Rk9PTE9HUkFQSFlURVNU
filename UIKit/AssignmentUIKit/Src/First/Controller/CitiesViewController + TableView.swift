//
//  CitiesViewController + TableView.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

// MARK: - tableView delegate & datasource
extension CitiesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: CityTableViewCell.self, for: indexPath)
        cell.city = cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = CityDetailViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
}

