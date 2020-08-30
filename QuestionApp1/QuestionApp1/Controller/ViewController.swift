//
//  ViewController.swift
//  QuestionApp1
//
//  Created by 稲葉陽樹 on 2020/08/30.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NowScoreDelegate {
    
    let imagesList = ImagesList()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maxScoreLabel: UILabel!
    var correctCount = 0
    var wrongCount = 0
    var maxCount = 0
    var questionNumber = 0
    //IBActionで検知した正答がどちらなのかを取得する変数
    var pickedAnswer = false
    var soundFile = SoundFile()
    var changeColor = ChangeColor()
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = changeColor.changeColor(topR: 0.07, topG: 0.13, topB: 0.26, topAlpha: 1.0, bottomR: 0.54, bottomG: 0.74, bottomB: 0.74, bottomAlpha: 1.0)
        gradientLayer.frame = view.bounds //view.boundsとは全体のこと
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        //角を丸くする
        imageView.layer.cornerRadius = 20.0
    }
    
    //Modalで戻ってきたときの処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        correctCount = 0
        wrongCount = 0
        questionNumber = 0
        
        imageView.image = UIImage(named: imagesList.list[0].imageText)
        
        if UserDefaults.standard.object(forKey: "beforeCount") != nil {
            maxCount = UserDefaults.standard.object(forKey: "beforeCount") as! Int
        }
        
        maxScoreLabel.text = String(maxCount)
    }
    
    @IBAction func answer(_ sender: Any) {
        if (sender as AnyObject).tag == 1{
            //丸ボタンが押された時
            pickedAnswer = true
            //ユーザーが押したボタンが丸ボタンだった
            
            //丸ボタンの音声を流す
            soundFile.playSound(filename: "maruSound", extensionName: "mp3")
            
        }else if (sender as AnyObject).tag == 2{
            //×ボタンが押された時
            pickedAnswer = false
            //ユーザーが押したボタンが×ボタンだった
            
            //×ボタンの音声を流す
            soundFile.playSound(filename: "batsuSound", extensionName: "mp3")
        }
        
        //チェック回答があっているか(pickedAnswer と ImagesList の correctOrNot の値が一致しているかどうか)
        check()
        nextQuestions()
    }
    
    func check(){
        let correctAnswer = imagesList.list[questionNumber].answer
        if correctAnswer == pickedAnswer{
            print("正解")
            correctCount += 1
        }else{
            print("間違い")
            wrongCount += 1
        }
    }
    
    func nextQuestions(){
        if questionNumber <= 9{
            questionNumber += 1
            imageView.image = UIImage(named: imagesList.list[questionNumber].imageText)
        }else{
            print("問題終了")
            //画面遷移
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.correctedCount = correctCount
            nextVC.wrongCount = wrongCount
            nextVC.delegate = self
        }
    }
    
    func nowScore(score: Int) {
        soundFile.playSound(filename: "sound", extensionName: "mp3")
        maxScoreLabel.text = String(score)
    }
    
    
}

