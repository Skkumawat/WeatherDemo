//
//  LocationTableCell.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import UIKit

class LocationTableCell: UITableViewCell {
    
    @IBOutlet var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
