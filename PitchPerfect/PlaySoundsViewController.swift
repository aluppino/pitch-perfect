//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Luppino, Angelo on 2/15/16.
//  Copyright © 2016 Angelo Luppino. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioAtRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioAtRate(1.5)
    }
    
    func playAudioAtRate(rate: Float) {
        stopAudio(nil)
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playAudioWithEffect(changePitchEffect)
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        let echoEffect = AVAudioUnitDelay()
        echoEffect.delayTime = 0.1
        playAudioWithEffect(echoEffect)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.wetDryMix = 90
        playAudioWithEffect(reverbEffect)
    }
    
    func playAudioWithEffect(effect: AVAudioUnit) {
        stopAudio(nil)
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: AnyObject?) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
