//
//  SoundFile.swift
//  QuestionApp1
//
//  Created by 稲葉陽樹 on 2020/08/30.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import Foundation
import AVFoundation

class SoundFile{
    var player: AVAudioPlayer!
    
    func playSound(filename: String, extensionName: String){
        //再生する
        let soundURL = Bundle.main.url(forResource: filename, withExtension: extensionName)
        
        do {
            //効果音を鳴らす
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("エラーです!")
        }
    }
}
