//
//  Extensions.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import Foundation

extension Double {
    
    func fromKevinToCelsius() -> Double {
        let result = self - 273.5
        return Double(Int(result * 10.0)) / 10.0
    }
}
