//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Anindya Sengupta on 2/1/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    let recordedFileName = "recordedVoice.wav"
    let segueIdentifier = "stopRecording"
    var audioRecorder: AVAudioRecorder!
    let common = Common()
    
    //MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        common.configureUI(.stopped, sender: self)
    }
    
    //MARK: - Button Events
    @IBAction func recordAudio(_ sender: Any) {
        common.configureUI(.inProgress, sender: self)
        
        DispatchQueue.global().async {
            self.beginRecording()
            self.addRecordingIndicatorAnimation(to: self.recordingButton)
        }
    }

    @IBAction func stopRecording(_ sender: Any) {
        stopRecord()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

