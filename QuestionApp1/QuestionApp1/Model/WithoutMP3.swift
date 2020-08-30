//
//  WithoutMP3.swift
//  QuestionApp1
//
//  Created by 稲葉陽樹 on 2020/08/30.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import Foundation

class WithoutMP3: SoundFile{
    override func playSound(filename: String, extensionName: String) {
        if extensionName == "mp3"{
            print("このファイルは再生できません")
        }
        player?.stop()
    }
}
