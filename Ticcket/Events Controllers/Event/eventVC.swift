//
//  eventVC.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 17/05/2022.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class eventVC: UIViewController{
    
    @IBOutlet weak var logoEventImg: UIImageView!
    @IBOutlet weak var nameOfEventLbl: UILabel!
    @IBOutlet weak var startDateOfEventLBL: UILabel!
    @IBOutlet weak var endDateOfEventLbl: UILabel!
    @IBOutlet weak var organizersLBL: UILabel!
    @IBOutlet weak var descriptionOfEventLbl: UILabel!
    @IBOutlet weak var scanAttendeeBtn: UIButton!
    @IBOutlet weak var bookTicketBTN: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    var homeEvent : HomeData?
    var HomeEventDate : eventData?
//    var HomeEventArr = [eventData]()
    var QRCodeArr = [QRCodeTicketData]()
    var qrCode : QRCodeTicketData?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   homeRequestApi()
        bookTicketBTN.layer.cornerRadius=10.0
        logoEventImg.layer.cornerRadius=10.0
        self.indicator.isHidden=true
        // hide Scan QrCode from Attendees
        print("id" + "\(homeEvent?.title ?? "")")
        nameOfEventLbl.text = homeEvent?.title!
        startDateOfEventLBL.text = homeEvent?.start_at!
        endDateOfEventLbl.text = homeEvent?.end_at!
//        organizersLBL.text = homeEvent.
    //    let organizerID = self.HomeEventDate.creator
        descriptionOfEventLbl.text = homeEvent?.description
        let imageUrl=URL(string: "http://178.62.201.95/"+"\(homeEvent?.logo! ?? "")" )
        self.logoEventImg.kf.indicatorType = .activity
        self.logoEventImg.kf.setImage(with: imageUrl)
        organizersLBL.isHidden=true
        
       // print("yarab"+(qrCode?.url ?? ""))
   //     print("yarab QR" + (qrCode?.url ?? "" ))
        UserDefaults.standard.set(homeEvent?.id, forKey: "eventID")
        print("-------------------------------------------------------------------")
        print("eventID  \(UserDefaults.standard.string(forKey: "eventID")!)")
        print("-------------------------------------------------------------------")

//        print("QRCode"+(QrCodeResponse?.data?.url ?? ""))

        //print("qr code "+(QRCodeArr[1].url ?? "")   )
//        print("qr code "+(QRCodeArr[u].url ?? "")   )
              
              
    }
    
    
    @IBAction func bookClicking(_ sender: Any) {
        
        self.indicator.isHidden=false
        self.indicator.startAnimating()
        self.bookTicketBTN.setTitle("", for: .normal)
        let headers : HTTPHeaders = ["Accept-Language":"en","Accept":"application/json","Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"]
        let params = ["user_id": "\(UserDefaults.standard.string(forKey:"userID") ?? "") ",
                      "event_id": "\(homeEvent?.id ?? 0)"]
        AF.request( "http://178.62.201.95/api/tickets/", method: .post, parameters: params, headers: headers).responseJSON{response in
            self.indicator.stopAnimating()
            self.indicator.isHidden=true
            self.bookTicketBTN.setTitle("Book", for: .normal)
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                      let QrCodeResponse  = Mapper<QRcodeBase>().map(JSONObject: value)
        //              print("QRCode"+(QrCodeResponse?.data?.url ?? ""))
               //       self.qrCode?.url = QrCodeResponse?.data?.url
                    //UserDefaults.standard.set(self.homeEvent?.id , forKey: "eventID")
//                    self.QRCodeArr = QrCodeResponse?.data ?? []
                    //  self.qrCode = QrCodeResponse?.data
                  //  self.QRCodeArr = QrCodeResponse?.data ?? []
                    
                    
                    
                    
                    
                }else{
              //      let HomeError = Mapper<HomeErrorsBase>().map(JSONObject: value)
                //    print(HomeError?.message ?? "")
               }
            case .failure(let error):
                print(error)
            }
        }
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let QRCode = Events.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
        QRCode.modalPresentationStyle = .fullScreen
        self.show(QRCode, sender: self)
    }
    
    @IBAction func scanClicking(_ sender: Any) {
        
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let scanQRCode = Events.instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC
        scanQRCode.modalPresentationStyle = .fullScreen
        self.show(scanQRCode, sender: self)
    }
    
}
//}
    


//extension eventVC{
    
//    func homeRequestApi(){
//        //homeEvent
//        let headers :HTTPHeaders = ["accept":"application/json","authorization":"Bearer  \(UserDefaults.standard.string(forKey: "authorization") ?? "")"]
//        AF.request( "http://178.62.201.95/api/events/\(homeEvent?.id ?? 0)", method: .get, headers: headers).responseJSON{
//            response in
//            print(response.response?.statusCode ?? "")
//            switch response.result{
//            case .success(let value):
//                print(value)
//                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
//                    let HomeEventResponse  = Mapper<eventHomeBase>().map(JSONObject: value)
////                    self.HomeEventArr = HomeEventResponse?.data ?? []
////                    self.nameOfEventLbl.text = HomeEventArr.
//                    self.nameOfEventLbl.text = self.homeEvent?.title
//                    self.nameOfEventLbl.text = self.HomeEventDate?.title
//                    self.startDateOfEventLBL.text = self.HomeEventDate?.start_at
//                    self.endDateOfEventLbl.text = self.HomeEventDate?.end_at
//                //    let organizerID = self.HomeEventDate.creator
//                    self.descriptionOfEventLbl.text = self.HomeEventDate?.description
//                    let imageUrl=URL(string: self.HomeEventDate?.logo ?? "")
//                    self.logoEventImg.kf.indicatorType = .activity
//                    self.logoEventImg.kf.setImage(with: imageUrl)
//
//
////                    print(categoriesResponse?.data?.count)
////                    print(categoriesResponse?.data?.first?.title)
////                    self.categoriesArr = categoriesResponse?.data ?? []
//           //         self.collectionView.reloadData()
//            //        self.indicator.stopAnimating()
//                }else{
//                    let HomeError = Mapper<HomeErrorsBase>().map(JSONObject: value)
//                    print(HomeError?.message ?? "")
//
//                }
//
//            case .failure(let error):
//                print(error)
//        }
//     }
//   }
//}
//
