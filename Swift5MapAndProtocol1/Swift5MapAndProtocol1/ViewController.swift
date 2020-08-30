//
//  ViewController.swift
//  Swift5MapAndProtocol1
//
//  Created by 稲葉陽樹 on 2020/08/23.
//  Copyright © 2020 Haruki Inaba. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, SearchLocationDelegate {

    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    var locManager: CLLocationManager!
    @IBOutlet weak var addressLabel: UILabel!
    var adressString = ""
    @IBOutlet weak var settingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began{
        //タップを開始した
        }else if sender.state == .ended{
            //タップを終了した
            let tapPoint = sender.location(in: view)
            //タップした位置(CGPoint)を指定して、MKMap上の緯度と経度を取得する
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let long = center.longitude
            //緯度経度から住所に変換する
            convert(lat: lat, long: long)
        }
    }
    
    func convert(lat: CLLocationDegrees, long: CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        
        //クロージャー
        geocoder.reverseGeocodeLocation(location){(placeMark, error) in
            if let placeMark = placeMark{
                if let pm = placeMark.first{
                    if pm.administrativeArea != nil && pm.locality != nil{
                        self.adressString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        self.adressString = pm.name!
                    }
                    self.addressLabel.text = self.adressString
                }
            }
            
        }
        
    }
    
    @IBAction func goToSearchVC(_ sender: Any) {
        //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
    
    //任されたデリゲートメソッド
    func searchLocation(latValue: String, longValue: String) {
        if !latValue.isEmpty && !longValue.isEmpty{
            let latString = latValue
            let longString = longValue
            
            //緯度経度からコーディネート
            let cordinate = CLLocationCoordinate2DMake(Double(latString)!, Double(longString)!)
            
            //表示する範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            //領域を指定
            let region = MKCoordinateRegion(center: cordinate, span: span)
            
            //領域をmapViewに設定
            mapView.setRegion(region, animated: true)
            
            //緯度経度から住所に変換する
            convert(lat: Double(latString)!, long: Double(longString)!)
            
            //ラベルに表示する
            addressLabel.text = adressString
        }else{
            addressLabel.text = "表示できません"
        }
    }
    
}

