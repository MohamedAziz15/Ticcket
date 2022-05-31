//
//  AccountViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 09/05/2022.
//

import UIKit
import MobileCoreServices

class AccountViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var uploadProfileBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 64.0

    }
    
    @IBAction func uploadClicking(_ sender: Any) {
        actionSheet()


    let imagePicker = UIImagePickerController()
        
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
        imageView.image = image
        
        
   
        
    }
    picker.dismiss(animated: true, completion:nil)
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}

    func actionSheet(){
        
        let alert = UIAlertController(title: "choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: {
            (handler) in self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {
            (handler) in self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: {
            (handler) in
        }))
        self.present(alert, animated: true,completion: nil)
        
    }
    func openCamera(){
        let image = UIImagePickerController()
        image.allowsEditing=true
        image.sourceType = .camera
        image.mediaTypes = [kUTTypeImage as String]
        self.present(image, animated: true,completion: nil)
    }
    
    func openGallery(){
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let image = UIImagePickerController()
                image.allowsEditing=true
                image.delegate = self
                self.present(image, animated: true,completion: nil)
        }
        
        
        
        
    }
    
}
