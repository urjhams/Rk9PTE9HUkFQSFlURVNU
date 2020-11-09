//
//  AddCityViewController.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

class AddCityViewController: BaseViewController {
    
    let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var delegate: AddCityDelegate?
    
    override func loadView() {
        super.loadView()
        setupNavigationBar()
    }
}

//MARK: - UI components setup
extension AddCityViewController {
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(cancelClick))
        
        let finishItem = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(finishClick))
        
        let barItem = UINavigationItem(title: "")
        
        barItem.leftBarButtonItem = cancelItem
        barItem.rightBarButtonItem = finishItem
        
        navigationBar.setItems([barItem], animated: false)
    }
    
    @objc private func cancelClick(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc private func finishClick(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    private func setupViews() {
        
    }
}
