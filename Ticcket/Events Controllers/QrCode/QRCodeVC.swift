//
//  ViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 21/05/2022.
//

import UIKit

class QRCodeVC: UIViewController {

    @IBOutlet var ThanksLBL: UILabel!
    @IBOutlet var QrCodeIMG: UIImageView!
    @IBOutlet var SavePhotoBTN: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SavePhotoBTN.layer.cornerRadius = 10.0
        

        // Do any additional setup after loading the view.
    }
    
}
