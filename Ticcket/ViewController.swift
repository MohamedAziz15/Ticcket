//
//  ViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 04/05/2022.
//

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
