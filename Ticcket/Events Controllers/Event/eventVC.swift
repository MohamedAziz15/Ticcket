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
    
    var homeEvent : HomeData?
    var HomeEventDate : eventData?
//    var HomeEventArr = [eventData]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeRequestApi()
        bookTicketBTN.layer.cornerRadius=10.0
        logoEventImg.layer.cornerRadius=10.0
        // hide Scan QrCode from Attendees
        
    }
    @IBAction func bookClicking(_ sender: Any) {
        
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
    


extension eventVC{
    
    func homeRequestApi(){
        //homeEvent
        let headers :HTTPHeaders = ["accept":"application/json","authorization":"Bearer  \(UserDefaults.standard.string(forKey: "authorization") ?? "")"]
        AF.request( "http://178.62.201.95/api/events/\(homeEvent?.id ?? 0)", method: .get, headers: headers).responseJSON{
            response in
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                    let HomeEventResponse  = Mapper<eventHomeBase>().map(JSONObject: value)
//                    self.HomeEventArr = HomeEventResponse?.data ?? []
//                    self.nameOfEventLbl.text = HomeEventArr.
                    self.nameOfEventLbl.text = self.homeEvent?.title
                    self.nameOfEventLbl.text = self.HomeEventDate?.title
                    self.startDateOfEventLBL.text = self.HomeEventDate?.start_at
                    self.endDateOfEventLbl.text = self.HomeEventDate?.end_at
                //    let organizerID = self.HomeEventDate.creator
                    self.descriptionOfEventLbl.text = self.HomeEventDate?.description
                    let imageUrl=URL(string: self.HomeEventDate?.logo ?? "")
                    self.logoEventImg.kf.indicatorType = .activity
                    self.logoEventImg.kf.setImage(with: imageUrl)
                    
                    
//                    print(categoriesResponse?.data?.count)
//                    print(categoriesResponse?.data?.first?.title)
//                    self.categoriesArr = categoriesResponse?.data ?? []
           //         self.collectionView.reloadData()
            //        self.indicator.stopAnimating()
                }else{
                    let HomeError = Mapper<HomeErrorsBase>().map(JSONObject: value)
                    print(HomeError?.message ?? "")

                }
                
            case .failure(let error):
                print(error)
        }
     }
   }
}

