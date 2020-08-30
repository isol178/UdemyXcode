//
//  NextViewController.swift
//  Swift5MapAndProtocol1
//
//  Created by 稲葉陽樹 on 2020/08/23.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import UIKit

protocol SearchLocationDelegate {
    func searchLocation(latValue: String, longValue: String)
}

class NextViewController: UIViewController {

    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    var delegate: SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func okAction(_ sender: Any) {
        //入力された値を取得
        let latValue = latTextField.text!
        let longValue = longTextField.text!
        
        //両方のテキストフィールドが空でなければ戻る
        if latTextField != nil && longTextField != nil{
            //デリゲートメソッドの引数に入れる
            delegate?.searchLocation(latValue: latValue, longValue: longValue)
            dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
