//
//  CityTableViewCell.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    
    public var city: CityWeather? {
        didSet {
            cityNameLabel.text = city?.name
            cityTemperatureLabel.text = String(city?.main?.temp ?? 0)
        }
    }
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        label.text = "City Name"
        return label
    }()
    
    private let cityTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "55"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .gray
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CityTableViewCell {
    private func setupLayout() {
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupViews() {
        let aligment: CGFloat = 24
        let verticalAligment: CGFloat = 12
        let maxTempWidth = (UIScreen.main.bounds.width - aligment * 2) / 4
        let maxNameWidth: CGFloat = maxTempWidth * 3
        
        contentView.addSubview(cityTemperatureLabel)
        cityTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -aligment).isActive = true
        cityTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalAligment).isActive = true
        cityTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalAligment).isActive = true
        cityTemperatureLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxTempWidth).isActive = true
        
        contentView.addSubview(cityNameLabel)
        cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: aligment).isActive = true
        cityNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxNameWidth).isActive = true
        cityNameLabel.centerYAnchor.constraint(equalTo: cityTemperatureLabel.centerYAnchor).isActive = true
    }
}
