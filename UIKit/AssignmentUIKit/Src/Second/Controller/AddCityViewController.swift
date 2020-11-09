//
//  AddCityViewController.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

final class AddCityViewController: BaseViewController {
    
    private let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "City name (e.g: London)"
        field.borderStyle = .roundedRect
        field.delegate = self
        return field
    }()
    
    private let finishItem = UIBarButtonItem(barButtonSystemItem: .save,
                                             target: self,
                                             action: #selector(finishClick))
    
    var delegate: AddCityDelegate?
    
    override func loadView() {
        super.loadView()
        hideKeyboardWhenTapAround()
        setupNavigationBar()
        setupViews()
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
        
        finishItem.isEnabled = false
        
        let barItem = UINavigationItem(title: "")
        
        barItem.leftBarButtonItem = cancelItem
        barItem.rightBarButtonItem = finishItem
        
        navigationBar.setItems([barItem], animated: false)
    }
    
    @objc private func cancelClick(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc private func finishClick(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didAddNewCity(self?.nameTextField.text)
        }
    }
    
    private func setupViews() {
        view.addSubview(nameTextField)
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             constant: -32).isActive = true
        nameTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                           constant: 32).isActive = true
    }
}

extension AddCityViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameTextField {
            finishItem.isEnabled = (textField.text?.count ?? 0 > 0)
        }
    }
}
