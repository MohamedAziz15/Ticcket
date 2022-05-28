//
//  ScanViewController.swift
//  Ticcket
//
//  Created by Mohamed Aziz on 28/05/2022.
//

import UIKit
import SwiftQRScanner

class ScanViewController: UIViewController, QRScannerCodeDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scanner = QRCodeScannerController()
     //   let scanner1 = QRScannerCodeDelegate()
      //  scanner1.delegate = self
//        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)

    }
    
    func qrCodeScanningDidCompleteWithResult(result: String) {
        print(result)
    }
    
    func qrCodeScanningFailedWithError(error: String) {
        print(error)
    }
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("result:\(result)")
    }

    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }

    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}
