//
//  WeatherTableViewCell.swift
//  swift-mvvm
//
//  Created by Taylor Guidon on 11/30/16.
//  Copyright © 2016 ISL. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherMainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ viewModel: WeatherViewModel) {
        self.selectionStyle = .none
        
        guard let minTemp = viewModel.minTemp, let maxTemp = viewModel.maxTemp
             else {
                print("ViewModel is invalid")
                return
        }
        weatherMainLabel.text = String(maxTemp)
    }
}
