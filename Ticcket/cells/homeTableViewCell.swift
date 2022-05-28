//
//  homeTableViewCell.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 27/05/2022.
//

import UIKit

class homeTableViewCell: UITableViewCell {
    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var titleLBL: UILabel!
    @IBOutlet var descriptionLBL: UILabel!
    @IBOutlet var BookBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BookBTN.layer.cornerRadius=10.0
        logoImg.layer.cornerRadius=10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
