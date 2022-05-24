//
//  eventTableViewCell.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 15/05/2022.
//

import UIKit

class eventTableViewCell: UITableViewCell {
    @IBOutlet weak var logoOfEventImg: UIImageView!
    @IBOutlet weak var nameOfEventLbl: UILabel!
    
    @IBOutlet weak var descriptionOfEventLbl: UILabel!
    @IBOutlet weak var BookEventBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //override func setSelected(_ selected: Bool, animated: Bool) {
      //  super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    //}

}
