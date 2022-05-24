//
//  HomeVC.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit

class HomeVC: UIViewController {
   // @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addEventBtn: UIBarButtonItem!
    
  override func viewDidLoad()
    {
        super.viewDidLoad()
   //     self.tableView.delegate = self
     //   self.tableView.dataSource = self

    }
    

    @IBAction func addEventClicking(_ sender: Any) {
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let createEvent = Events.instantiateViewController(withIdentifier: "createEventVC")
        //as! createEventVC
        createEvent.modalPresentationStyle = .fullScreen
        self.show(createEvent, sender: self)
        
    }
    
}
//extension HomeVC :UITableViewDelegate,UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! eventTableViewCell
//        return cell
//    }
//
    
    

