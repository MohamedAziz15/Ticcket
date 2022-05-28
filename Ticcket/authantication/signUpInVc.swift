//
//  signUpInVc.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 05/05/2022.
//

import UIKit
import SwiftUI
import Alamofire
import ObjectMapper
import SwiftMessages



class signUpInVc: UIViewController {
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var repasswordView: UIView!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var createAccountShadowView: UIView!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var logInShadowView: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var repasswordTF: UITextField!
    
    var api_key = "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCIsImFwcCI6InRpY2NrZXQiLCJjcmVhdG9yIjoia2FyZWVtIEVsLUdpdXNoeSJ9"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountBtn.tintColor = .blue
        createAccountShadowView.backgroundColor = .blue
        self.indicator.isHidden=true
        confirmBtn.layer.cornerRadius=10.0
       
    }
    @IBAction func createAccountClicking(_ sender: Any) {
        createAccountBtn.tintColor = .blue
        createAccountShadowView.backgroundColor = .blue
        fullNameView.isHidden=false
        repasswordView.isHidden=false
        confirmBtn.setTitle("Register", for: .normal)
        logInBtn.tintColor = .gray
        logInShadowView.backgroundColor = .gray
    
    }
    
    @IBAction func logInClicking(_ sender: Any) {
        
        logInBtn.tintColor = .blue
        logInShadowView.backgroundColor = .blue
        fullNameView.isHidden=true
        repasswordView.isHidden=true
        confirmBtn.setTitle("Login", for:.normal)
        createAccountBtn.tintColor = .gray
        createAccountShadowView.backgroundColor = .gray

    }
    @IBAction func registerClicking(_ sender: Any) {
        if confirmBtn.titleLabel?.text == "Login"{
            loginApi()
        }else{
            signUpApi()
        }
     
    }
    
//}
//
//extension HomeVC{
    func signUpApi(){
        confirmBtn.setTitle("", for:.normal)
        self.indicator.isHidden=false
        self.indicator.startAnimating()


        let headers :HTTPHeaders = ["Accept":"application/json"]
        let parameter = ["name":"\(usernameTF.text!)",
                      "email":"\(emailTF.text!)",
                      "password":"\(passwordTF.text!)",
                      "re_password":"\(repasswordTF.text!)",
                      "api_key":"eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCIsImFwcCI6InRpY2NrZXQiLCJjcmVhdG9yIjoia2FyZWVtIEVsLUdpdXNoeSJ9"]
        AF.request( "http://178.62.201.95/api/register", method: .post, parameters: parameter,headers: headers).responseJSON{
            response in
            print(response.response?.statusCode)
            print(response.result)
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                    let registerResponse  = Mapper<signUpBase>().map(JSONObject: value)
                    self.indicator.stopAnimating()
                    self.indicator.isHidden=true
                    let Main = UIStoryboard(name: "Main", bundle: nil)
                    let home = Main.instantiateViewController(withIdentifier: "HomeVC")
                    home.modalPresentationStyle = .fullScreen
                    self.show(home, sender: self)
//                    let registerDataResponse = Mapper<signUpData>().map(JSONObject: value)
                    print("enter h step 0")
                    UserDefaults.standard.set(registerResponse?.data?.token, forKey: "authorization")
                    print("enter h step 1")
                    print("enter h step \(UserDefaults.standard.string(forKey: "authorization") ?? "")")
                
                }else{
                    let signUpError = Mapper<errorSignUpBase>().map(JSONObject: value)
                    print(signUpError?.message ?? "")
                    // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
                    // files in the main bundle first, so you can easily copy them into your project and make changes.
                    let view = MessageView.viewFromNib(layout: .cardView)
                    view.button?.isHidden = true

                    // Theme message elements with the warning style.
                    view.configureTheme(.warning)

                    // Add a drop shadow.
                    view.configureDropShadow()

                    // Set message title, body, and icon. Here, we're overriding the default warning
                    // image with an emoji character.
                    let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
                    view.configureContent(title: "Warning", body: signUpError?.message ?? "", iconText: iconText)

                    // Increase the external margin around the card. In general, the effect of this setting
                    // depends on how the given layout is constrained to the layout margins.
                    view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

                    // Reduce the corner radius (applicable to layouts featuring rounded corners).
                    (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

                    // Show the message.
                    SwiftMessages.show(view: view)

                }
            case .failure(let error):
                print(error)
            }
      
        }
    }
        
    func loginApi(){
        /////
        
    }
    
    
}

