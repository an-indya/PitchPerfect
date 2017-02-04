//
//  Common.swift
//  PitchPerfect
//
//  Created by Anindya Sengupta on 2/4/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class Common: NSObject {
    /// Shows an alert on the current view
    ///
    /// - Parameters:
    ///   - title: Title of the alert view to be presented
    ///   - message: Message of the alert view to be presented
    func showAlert(_ title: String, message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
