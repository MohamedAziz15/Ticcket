//
//  ViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 04/05/2022.
//

import UIKit

class RatingController: UIStackView {
    var starsRating = 0
    var starsEmptyPicName = "star-3" // change it to your empty star picture name
    var starsFilledPicName = "star-2" // change it to your filled star picture name
    override func draw(_ rect: CGRect) {
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        for button in starButtons {
            if let button = button as? UIButton{
                button.setImage(UIImage(named: starsEmptyPicName), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = starTag
                starTag = starTag + 1
            }
        }
       setStarsRating(rating:starsRating)
    }
    func setStarsRating(rating:Int){
        self.starsRating = rating
        let stackSubViews = self.subviews.filter{$0 is UIButton}
        for subView in stackSubViews {
            if let button = subView as? UIButton{
                if button.tag > starsRating {
                    button.setImage(UIImage(named: starsEmptyPicName), for: .normal)
                }else{
                    button.setImage(UIImage(named: starsFilledPicName), for: .normal)
                }
            }
        }
    }
    @objc func pressed(sender: UIButton) {
        setStarsRating(rating: sender.tag)
    }
}

//import UIKit
//
//import MercariQRScanner
//import AVFoundation
//
//final class viewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupQRScanner()
//    }
//
//    private func setupQRScanner() {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            setupQRScannerView()
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
//                if granted {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.setupQRScannerView()
//                    }
//                }
//            }
//        default:
//            showAlert()
//        }
//    }
//
//    private func setupQRScannerView() {
//        let qrScannerView = QRScannerView(frame: view.bounds)
//        view.addSubview(qrScannerView)
//        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
//        qrScannerView.startRunning()
//    }
//
//    private func showAlert() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
//            alert.addAction(.init(title: "OK", style: .default))
//            self?.present(alert, animated: true)
//        }
//    }
//}
//
//extension viewController: QRScannerViewDelegate {
//    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
//        print(error)
//    }
//
//    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
//        print(code)
//    }
//}
