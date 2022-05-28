//
//  AccountViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = 20.0

    }
    
    



    let imagePicker = UIImagePickerController()

    @IBAction func profileClicking(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
           
       

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
        profileImg.image = image
    }
    picker.dismiss(animated: true, completion:nil)
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}

}
