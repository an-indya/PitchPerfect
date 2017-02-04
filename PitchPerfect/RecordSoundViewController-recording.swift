//
//  RecordSoundViewController-recording.swift
//  PitchPerfect
//
//  Created by Anindya Sengupta on 2/4/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    enum RecordingState { case recording, notRecording }
    
    //MARK: - AVAudioRecorderDelegate methods
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: segueIdentifier, sender: audioRecorder.url)
        }
        else {
            Common().showAlert(Alerts.AudioRecordingError, message: Alerts.RecordingFailedMessage, in: self)
        }
    }
    
    //MARK: - Recording related methods
    
    func stopRecord () {
        recordingLabel.text = Labels.BeginRecording
        stopRecordingButton.isEnabled = false
        recordingButton.isEnabled = true
        recordingButton.layer.removeAllAnimations()
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func getRecordedFilePath () -> URL {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = self.recordedFileName
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))!
        return filePath
    }
    
    func beginRecording() {
        let filePath = getRecordedFilePath()
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        try! self.audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        self.audioRecorder.delegate = self
        self.audioRecorder.isMeteringEnabled = true
        self.audioRecorder.prepareToRecord()
        self.audioRecorder.record()
    }
    
    // MARK: - UI Functions
    
    
    /// Configures UI elements based on different states of recording e.g. recording, not recording etc.
    ///
    /// - Parameter recordingState: Current state of recording e.g. recording, not recording etc.
    func configureUI(_ recordingState: RecordingState) {
        switch(recordingState) {
        case .recording:
            recordingButton.isEnabled = false
            stopRecordingButton.isEnabled = true
            recordingLabel.text = Labels.RecordingInProgress
        case .notRecording:
            recordingButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = Labels.BeginRecording
        }
    }
    
    
    /// Adds a pulsing animation which gives a visual indication to the user that recording is in progress
    ///
    /// - Parameter button: The button to which the animation would be applied
    func addRecordingIndicatorAnimation (to button: UIButton) {
        DispatchQueue.main.async {
            let pulseAnimation = CABasicAnimation(keyPath: Keys.kKeyPathOpacity)
            pulseAnimation.duration = 0.5
            pulseAnimation.fromValue = 0.3
            pulseAnimation.toValue = 1
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = FLT_MAX
            button.layer.add(pulseAnimation, forKey: Keys.kAnimationOpacity)
        }
    }
}
