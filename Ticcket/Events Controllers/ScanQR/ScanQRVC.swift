//
//  ScanQRVC.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 28/05/2022.
//

import UIKit
import MercariQRScanner
import AVFoundation
import SwiftMessages


class ScanQRVC: UIViewController, QRScannerViewDelegate {
 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScanner()

    }
    

        private func setupQRScanner() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setupQRScannerView()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async { [weak self] in
                            self?.setupQRScannerView()
                        }
                    }
                }
            default:
                showAlert()
            }
        }
    
        private func setupQRScannerView() {
            let qrScannerView = QRScannerView(frame: view.bounds)
            view.addSubview(qrScannerView)
            qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
            qrScannerView.startRunning()
        }
    
        private func showAlert() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
        func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
    
        }
    
        func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.button?.isHidden = true

            // Theme message elements with the warning style.
            view.configureTheme(.success)

            // Add a drop shadow.
            view.configureDropShadow()

            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["✅"].randomElement()!
            view.configureContent(title: "QR code Scanned", body: "success")

            // Increase the external margin around the card. In general, the effect of this setting
            // depends on how the given layout is constrained to the layout margins.
            view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

            // Reduce the corner radius (applicable to layouts featuring rounded corners).
            (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

            // Show the message.
            SwiftMessages.show(view: view)

    
        }
}
