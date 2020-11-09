//
//  Extensions.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

extension NSObject {
    class var className : String {
        return String(describing: self)
    }
}

extension UITableView {
    /// Dequeues reusable UITableViewCell using class name for indexPath.
    /// - Parameters:
    ///   - type: UITableViewCell type.
    ///   - indexPath: Cell location in collectionView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<Cell>(of type: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? Cell else {
            fatalError("Couldn't find UITableViewCell of class \(type.className)")
        }
        return cell
    }
}

extension UIViewController {
    func hideKeyboardWhenTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    func showNotificationAlert(_ title: String?, withContent content: String?) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showActionAlert(_ title: String?, withContent content: String?, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true)
    }
}
