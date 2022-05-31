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


class createEventVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var createEventBTN: UIButton!
    @IBOutlet var eventNameLBL: UITextField!
    @IBOutlet var descriptionLBL: UITextField!
    @IBOutlet var organizersLBL: UITextField!
    @IBOutlet var startDateLBL: UITextField!
    @IBOutlet var EndAtLBL: UITextField!
    @IBOutlet var TicketsLBL: UITextField!
    @IBOutlet var AnnouncementsLBL: UITextField!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var ticketsView: UIView!
    @IBOutlet var borderView1: UIView!
    
    @IBOutlet var chooseImgBTN: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var logoUrlTF: UITextField!
    
    
    @IBOutlet var logoView: UIView!
    @IBOutlet var eventNameView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var organizersview: UIView!
    @IBOutlet var startAtView: UIView!
    @IBOutlet var endAtView: UIView!
    
    
    @IBOutlet var organizersBigView: UIView!
    @IBOutlet var border2View: UIView!
    @IBOutlet var announcementsView: UIView!
    
    

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createEventBTN.layer.cornerRadius = 10.0
        self.indicator.isHidden=true
        ticketsView.isHidden = true
        chooseImgBTN.layer.cornerRadius = 10.0
        imageView.layer.cornerRadius = 50.0
        borderView1.layer.isHidden=true
        logoView.layer.cornerRadius=10.0
        eventNameView.layer.cornerRadius=10.0
        descriptionView.layer.cornerRadius=10.0
        organizersview.layer.cornerRadius=10.0
        startAtView.layer.cornerRadius=10.0
        endAtView.layer.cornerRadius=10.0
        organizersBigView.isHidden=true
        border2View.isHidden=true
        announcementsView.isHidden=true
        print("------------------------------------------------------")
        print(imageView.image ?? "")
        print("------------------------------------------------------")


    }
    @IBAction func createEvent(_ sender: Any) {
        createEventApi()
        
    }
    @IBAction func chooseImageClicking(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()


               if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                   print("Button capture")

                   imagePicker.delegate = self
                   imagePicker.sourceType = .savedPhotosAlbum
                   imagePicker.allowsEditing = true

                   present(imagePicker, animated: true, completion: nil)
               }
           }
//    func imageUpload(){
//        let upload_file = imageView.image
//        var parameters = [String:AnyObject]()
//        let URL = "http://178.62.201.95/api/events"
//
//        requestWith(endUrl : URL , imageData:imageView.image!.jpegData(compressionQuality: 1.0),parameters: parameters,onCompletion: { (json) in
//            print(json)
//
//        })
//
//
//
//    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image
            print("image selected \(imageView.image!)")
            print("type image selected \(type(of: imageView.image))")

            //--------------------------------------------------
//            let image1 = UIImage.init(named: "myImage")
//
//            var image1 = UIImage()
//            image1 = UIImage(named: "edit.png")!
//            let imgData = image1.jpegData(compressionQuality: 0.50)
//
//
//            let parameters = ["logo": imageView.image] //Optional for extra parameter
//            AF.upload(multipartFormData: { (multipartFormData) in
//                    multipartFormData.append(imgData!, withName: "file", fileName: "swift_file.png", mimeType: "image/png")
//                    for (key, value) in parameters {
//                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//                    }
//                }, to: "your_url")
//                { (result) in
//                    switch result {
//                    case .success(let upload, _, _):
//
//                        upload.uploadProgress(closure: { (progress) in
//                            //Print progress
//                            print("uploading \(progress)")
//
//                        })
//
//                        upload.responseJSON { response in
//                            //print response.result
//
//                        }
//                    case .failure( _): break
//                        //print encodingError.description
//                    }
//                }
//            }
        //    ------------------------------------------------------------------------------------
//            Alomofire.upload(multipartFormData: { multipartFormData in
//                    multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
//                    for (key, value) in parameters {
//                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                        } //Optional for extra parameters
//                },
//            to:"mysite/upload.php")
//            { result in
//                switch result {
//                case .success(let upload):
//
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//
//                    upload.responseJSON { response in
//                         print(response.result.value)
//                    }
//
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }


            
        }
        picker.dismiss(animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func createEventApi(){
        self.indicator.isHidden=false
        self.indicator.startAnimating()
        createEventBTN.setTitle("", for: .normal)
        let headers : HTTPHeaders = ["Accept-Language":"en",
                                     "Accept":"application/json",
                                     "Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"]
        let params = ["title":self.eventNameLBL.text!,
                      "description":self.descriptionLBL.text!,
                      "start_at":self.startDateLBL.text!,
                      "end_at":self.EndAtLBL.text!,
                      "logo":self.logoUrlTF.text!] as [String : AnyObject]

        AF.request( "http://178.62.201.95/api/events", method: .post,parameters: params, headers: headers).responseJSON{response in
            self.indicator.stopAnimating()
            self.indicator.isHidden=true
            self.createEventBTN.setTitle("Create Event", for: .normal)
            print(response.response?.statusCode ?? "")
            switch response.result{
            case .success(let value):
                print(value)
                if (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0)<=300{
                    let createResponse  = Mapper<createBase>().map(JSONObject: value)
                    print("message "+( createResponse?.message ?? ""))
                    
                    print(createResponse?.data ?? [])
                    
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
