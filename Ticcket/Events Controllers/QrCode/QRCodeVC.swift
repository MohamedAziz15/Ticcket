//
//  ViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 21/05/2022.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class QRCodeVC: UIViewController {

    @IBOutlet var ThanksLBL: UILabel!
    @IBOutlet var QrCodeIMG: UIImageView!
    @IBOutlet var SavePhotoBTN: UIButton!
    
    var qr : QRCodeTicketData?
    var user: loginData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SavePhotoBTN.layer.cornerRadius = 10.0
        
     //   print("usrID  \(user?.id ?? 0)")
        print("usrID  \(UserDefaults.standard.string(forKey: "eventID ") ?? "")")
        print("eventID  \(UserDefaults.standard.string(forKey: "userID") ?? "")")
        
        let headers : HTTPHeaders = ["Accept":"application/json",
                                     "Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"]
        let params = ["event_id": UserDefaults.standard.string(forKey: "eventID")!,
                      "user_id": UserDefaults.standard.string(forKey: "userID")] as [String : AnyObject]
//        let params = ["event_id":"4",
//                      "user_id":"1"] as [String : AnyObject]

        
        AF.request("http://178.62.201.95/api/tickets", method: .post, parameters: params,headers: headers).responseJSON{response in
           // self.indicator.stopAnimating()
       //     self.indicator.isHidden=true
       //     self.bookTicketBTN.setTitle("Book", for: .normal)
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                      let QrCodeResponse  = Mapper<QRcodeBase>().map(JSONObject: value)
                      print("QRCode"+(QrCodeResponse?.data?.url ?? ""))
//                      self.qrCode?.url = QrCodeResponse?.data?.url
                      self.qr = QrCodeResponse?.data
                      let imageUrl=URL(string: "\(self.qr?.url ?? "")" )
                      self.QrCodeIMG.kf.indicatorType = .activity
                      self.QrCodeIMG.kf.setImage(with: imageUrl)
    }
            case .failure(let error):
                print(error)
            }
        
    }
}
    
    @IBAction func saveclicking(_ sender: Any) {
        let imageData = QrCodeIMG.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
        
    }
}
