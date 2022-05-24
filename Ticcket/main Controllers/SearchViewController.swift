//
//  SearchViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var addEventBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func addEventClicking(_ sender: Any) {
        
        let Events = UIStoryboard(name: "Event", bundle:nil)
        let createEvent = Events.instantiateViewController(withIdentifier: "createEventVC")
        createEvent.modalPresentationStyle = .fullScreen
        self.show(createEvent, sender: self)
        
    }
    
}
