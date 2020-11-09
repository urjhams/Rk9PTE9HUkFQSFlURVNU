//
//  API.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import Foundation

public class API {
    public static let secrectKey = "5ffcd8f8e469ee48581072a95ff9360f"
    private static let domain = "https://api.openweathermap.org"
    public static let weatherByCityName = "\(domain)/data/2.5/weather"
    public static let weatherByCities = "\(domain)/data/2.5/group"
    public static let weatherByCityId = "\(domain)/data/2.5/weather"
}
