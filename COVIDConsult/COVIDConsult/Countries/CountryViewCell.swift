//
//  CountryViewCell.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 10/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit

class CountryViewCell: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    func setCountryName(name: String) {
        countryName?.text = name
    }
}
