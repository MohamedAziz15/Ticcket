//
//  MyEventsViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit

class MyEventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addEventBtn: UIBarButtonItem!
    
    var selected : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource=self
        self.tableView.delegate=self
    }
    

    @IBAction func addEventClicking(_ sender: Any) {
        
        let Events = UIStoryboard(name: "Event", bundle: nil)
        let createEvent = Events.instantiateViewController(withIdentifier: "createEventVC")
        createEvent.modalPresentationStyle  = .fullScreen
        self.show(createEvent, sender: self)
    }
    
}
extension MyEventsViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell
        if indexPath.row == selected{
            let Events = UIStoryboard(name: "Event", bundle: nil)
            let Event = Events.instantiateViewController(withIdentifier: "eventVC")
            Event.modalPresentationStyle  = .fullScreen
            self.show(Event, sender: self)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected == indexPath.row
    }
    
}
