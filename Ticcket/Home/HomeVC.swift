//
//  HomeVC.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var addEventBtn: UIBarButtonItem!
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    var homearr = [HomeData]()
    var home1 : HomeBase?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.indicator.isHidden=true
        print("enter hena ya azez \(UserDefaults.standard.string(forKey: "authorization") ?? "")")
        getAllEvent()
    }
    

    @IBAction func addEventClicking(_ sender: Any) {
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let createEvent = Events.instantiateViewController(withIdentifier: "createEventVC") as! createEventVC
        createEvent.modalPresentationStyle = .fullScreen
        self.show(createEvent, sender: self)
        
    }
    
    @IBAction func bookClicking(_ sender: Any) {
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let QRCode = Events.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
        QRCode.modalPresentationStyle = .fullScreen
        self.show(QRCode, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homearr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! homeTableViewCell
        cell.titleLBL.text = homearr[indexPath.row].title
        cell.descriptionLBL.text = homearr[indexPath.row].description
        let imageUrl=URL(string: homearr[indexPath.row].logo ?? "")
        cell.logoImg.kf.indicatorType = .activity
        cell.logoImg.kf.setImage(with: imageUrl)
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let Event = Events.instantiateViewController(withIdentifier: "eventVC") as! eventVC
        Event.homeEvent = self.homearr[indexPath.row]
        Event.modalPresentationStyle  = .fullScreen
        self.show(Event, sender: self)
    }
    
}
extension HomeVC{
    func getAllEvent(){
        self.indicator.isHidden=false
        self.indicator.startAnimating()
        let headers : HTTPHeaders = ["Accept-Language":"en","Accept":"application/json","Authorization":"Bearer \(UserDefaults.standard.string(forKey: "authorization") ?? "")"]

        AF.request( "http://178.62.201.95/api/events", method: .get, headers: headers).responseJSON{response in
            self.indicator.stopAnimating()
            self.indicator.isHidden=true
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                    let HomeResponse  = Mapper<HomeBase>().map(JSONObject: value)
                    self.homearr = HomeResponse?.data ?? []
                    self.homeTableView.reloadData()
                 
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
