//
//  ViewController.swift
//  niftyFlatironWeather
//
//  Created by Johann Kerr on 10/27/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // OUTLETS
    
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var tableViewHourly: UITableView!
    
    // PROPERTIES
    
    let store = WeatherData.sharedInstance
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    // LOADS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentData()
        
        DispatchQueue.main.async {
            
            self.tableViewHourly.reloadData()
            
        }
        //        setupLocationManager()
        
        
    }
    
    // TABLEVIEW METHODS
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyTableViewCell
        
        
        store.getHourlyDataFromAPI(completion: { (rawData) in
            
            print(rawData)
            
            cell.backgroundColor = UIColor.clear
            
            let detailData = rawData["data"] as! [[String:Any]]
            
            let detailIndex = detailData[indexPath.row]
            
            DispatchQueue.main.async {
                
                cell.timeLabel.text = (String(format: "%.0f",(detailIndex["time"] as! Double)))
                
                cell.tempLabel.text = (String(format: "%.0f",(detailIndex["temperature"] as! Double))) + "º"
            }
            
            print(detailIndex["time"] as! Double)
            
        })
        
        return cell
    }
    
    func getCurrentData() {
        
        WeatherAPI.getWeatherInfo { (JSON) in
            WeatherData.sharedInstance.getCurrentDataFromAPI(completion: { (currentData) in
                self.labelTemp.text = (String(format: "%.0f",infoAPI.init(dictionary: currentData).temperature)) + "º"
            })
        }
    }
    
}


//extension ViewController: CLLocationManagerDelegate{
//    func setupLocationManager(){
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//
//        if let unwrappedlatitude = locationManager.location?.coordinate.latitude, let unwrappedLongitude = locationManager.location?.coordinate.longitude{
//            self.latitude = unwrappedlatitude
//            self.longitude = unwrappedLongitude
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}
//
