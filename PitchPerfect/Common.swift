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
    
    enum State { case inProgress, stopped }
    
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
    
    /// Configures UI elements based on different states of recording e.g. recording, not recording etc.
    ///
    /// - Parameter recordingState: Current state of recording e.g. recording, not recording etc.
    func configureUI(_ state: State, sender: UIViewController) {
        if let vc = sender as? RecordSoundsViewController {
            switch(state) {
            case .inProgress:
                vc.recordingButton.isEnabled = false
                vc.stopRecordingButton.isEnabled = true
                vc.recordingLabel.text = Labels.RecordingInProgress
            case .stopped:
                vc.recordingButton.isEnabled = true
                vc.stopRecordingButton.isEnabled = false
                vc.recordingLabel.text = Labels.BeginRecording
            }
        }
        else if let vc = sender as? PlaySoundsViewController {
            switch(state) {
            case .inProgress:
                vc.setPlayButtonsEnabled(false)
                vc.stopButton.isEnabled = true
            case .stopped:
                vc.setPlayButtonsEnabled(true)
                vc.stopButton.isEnabled = false
            }
        }
        
    }
}
