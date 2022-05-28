//
//  createEventVC.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftMessages

class createEventVC: UIViewController {

    @IBOutlet var logoTF: UITextField!
    @IBOutlet var createEventBTN: UIButton!
    @IBOutlet var eventNameLBL: UITextField!
    @IBOutlet var descriptionLBL: UITextField!
    @IBOutlet var organizersLBL: UITextField!
    @IBOutlet var startDateLBL: UITextField!
    @IBOutlet var EndAtLBL: UITextField!
    @IBOutlet var TicketsLBL: UITextField!
    @IBOutlet var AnnouncementsLBL: UITextField!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createEventBTN.layer.cornerRadius = 10.0
        createEventApi()
        self.indicator.isHidden=true

    }
    func createEventApi(){
        self.indicator.isHidden=false
        self.indicator.startAnimating()
        let headers : HTTPHeaders = ["Accept-Language":"en","Accept":"application/json","Authorization":"Bearer \(UserDefaults.standard.string(forKey: "authorization") ?? "")"]
        let params = ["title":self.eventNameLBL.text!,
                      "description":self.descriptionLBL.text!,
                      "start_at":self.startDateLBL!,
                      "end_at":self.EndAtLBL!,
                      "logo":self.logoTF.text!] as [String : AnyObject]

        AF.request( "http://178.62.201.95/api/events", method: .post,parameters: params, headers: headers).responseJSON{response in
            self.indicator.stopAnimating()
            self.indicator.isHidden=true
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                    let createResponse  = Mapper<createBase>().map(JSONObject: value)
                   print( createResponse?.message ?? "")
                    // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
                    // files in the main bundle first, so you can easily copy them into your project and make changes.
                    let view = MessageView.viewFromNib(layout: .cardView)
                    view.button?.isHidden = true

                    // Theme message elements with the warning style.
                    view.configureTheme(.success)

                    // Add a drop shadow.
                    view.configureDropShadow()

                    // Set message title, body, and icon. Here, we're overriding the default warning
                    // image with an emoji character.
                    let iconText = ["✅","😍","😎"].randomElement()!
                    view.configureContent(title: "Done", body : createResponse?.message ?? "", iconText: iconText)

                    // Increase the external margin around the card. In general, the effect of this setting
                    // depends on how the given layout is constrained to the layout margins.
                    view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

                    // Reduce the corner radius (applicable to layouts featuring rounded corners).
                    (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

                    // Show the message.
                    SwiftMessages.show(view: view)

                //    self.homearr = HomeResponse?.data ?? []
                  //  self.homeTableView.reloadData()
                    
                    
                    
                    
                }else{
                    let createError = Mapper<createErrorBase>().map(JSONObject: value)
                    print(createError?.message ?? "")
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
                    view.configureContent(title: "Warning", body: createError?.message ?? "", iconText: iconText)

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

  
}
