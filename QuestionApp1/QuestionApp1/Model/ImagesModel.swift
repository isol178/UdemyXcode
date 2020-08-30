//
//  ImagesModel.swift
//  QuestionApp1
//
//  Created by 稲葉陽樹 on 2020/08/30.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import Foundation

class ImagesModel{
    //画像名を取得して、画像名が人間かそうでないかをフラグによって判定するための機能
    
    let imageText:String
    let answer: Bool
    
    init(imageName:String, correctOrNot: Bool){
        imageText = imageName
        answer = correctOrNot
    }
}
