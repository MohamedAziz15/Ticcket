//
//  TableViewCell.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 15/05/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var logoEventImg: UIImageView!
    @IBOutlet weak var NameEventLbl: UILabel!
    @IBOutlet weak var descriptionEventLbl: UILabel!
    @IBOutlet weak var bookTicketBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
