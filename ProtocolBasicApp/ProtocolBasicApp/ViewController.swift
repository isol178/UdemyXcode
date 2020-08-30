//
//  ViewController.swift
//  ProtocolBasicApp
//
//  Created by 稲葉陽樹 on 2020/08/23.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CatchProtocol {

    @IBOutlet weak var label: UILabel!
    var count = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func catchData(count: Int) {
        label.text = String(count)
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! NextViewController
        nextVC.delegate = self
    }
}

