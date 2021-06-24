//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by NAMAN GARG on 6/16/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temp: UILabel!
    @IBOutlet var humidity: UILabel!
   
    @IBOutlet var weather: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
