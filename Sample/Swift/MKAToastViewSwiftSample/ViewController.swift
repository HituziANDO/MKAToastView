//
//  ViewController.swift
//  MKAToastViewSwiftSample
//
//  Created by Masaki Ando on 2018/12/28.
//  Copyright © 2018-2019 Hituzi Ando. All rights reserved.
//

import UIKit
import MKAToastView

class ViewController: UIViewController, MKAToastDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets a default configuration.
        let config = MKAToastConfiguration()
        config.width = 200.0;
        config.height = 50.0;
        MKAToast.setDefaultConfiguration(config)
    }

    /// MARK: - IBAction

    @IBAction func helloButtonPressed(_ sender: Any) {
        // Shows the toast using the default configuration's size.
        MKAToast.show(withMessage: "Hello", delegate: self, timeInterval: MKAToastShortTime, identifier: 1)
    }

    @IBAction func goodbyeButtonPressed(_ sender: Any) {
        // Shows the toast using a custom size.
        let toast = MKAToast(message: "Goodbye", width: 300.0, height: 60.0)
        toast.delegate = self
        toast.identifier = 2
        toast.show(withTimeInterval: MKAToastLongTime)
    }

    /// MARK: - MKAToastDelegate

    func toastWillDisappear(_ toast: MKAToast) {
        print("Toast ID: \(toast.identifier) will disappear");
    }

    func toastDidDisappear(_ toast: MKAToast) {
        print("Toast ID: \(toast.identifier) did disappear");
    }
}
