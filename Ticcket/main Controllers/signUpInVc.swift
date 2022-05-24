//
//  signUpInVc.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 05/05/2022.
//

import UIKit

class signUpInVc: UIViewController {
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var repasswordView: UIView!
    
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var createAccountShadowView: UIView!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var logInShadowView: UIView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountClicking(_ sender: Any) {
        createAccountBtn.tintColor = .blue
        createAccountShadowView.backgroundColor = .blue
        fullNameView.isHidden=false
        repasswordView.isHidden=false
        confirmBtn.setTitle("Register", for: .normal)
        
        
        
    }
    
    @IBAction func logInClicking(_ sender: Any) {
        
        logInBtn.tintColor = .blue
        logInShadowView.backgroundColor = .blue
        fullNameView.isHidden=true
        repasswordView.isHidden=true
        confirmBtn.setTitle("Log IN", for:.normal)
        
        
    }
    


}
