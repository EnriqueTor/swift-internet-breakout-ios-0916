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
    
    // MARK: - Outlets
    
    @IBOutlet weak var pickSegment: UISegmentedControl!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var tableViewHourly: UITableView!
    @IBOutlet weak var weatherView: UIImageView!
    
    // MARK: - Properties
    
    let store = WeatherData.sharedInstance
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickSegment.selectedSegmentIndex = 0
        self.getCurrentData()
        
        
        DispatchQueue.main.async {
            
            self.tableViewHourly.reloadData()
            
        }
        
        
        
        //        setupLocationManager()
        
        
    }
    
    // MARK: - Methods TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyTableViewCell
        
        
        if pickSegment.selectedSegmentIndex == 0 {
            
            store.getHourlyDataFromAPI(completion: { (rawData) in
                
                print(rawData)
                
                cell.backgroundColor = UIColor.clear
                
                let detailData = rawData["data"] as! [[String:Any]]
                
                let detailIndex = detailData[indexPath.row]
                
                DispatchQueue.main.async {
                    
                    let date = (detailIndex["time"] as! Double)
                    
                    let time = self.dateChanged(stringDate: date)
                    
                    cell.timeLabel.text = time
                    
                    cell.tempLabel.text = (String(format: "%.0f",(detailIndex["temperature"] as! Double))) + "º"
                    
                    let weather = (detailIndex["icon"]) as? String
                    
                    guard let unwrappedWeather = weather else { return }
                    
                    cell.emoji.text = self.bringEmoji(iconString: unwrappedWeather)
                    
                    
                }
                
                
            })
        }
            
        else {
            
            
            
            store.getDailyDataFromAPI(completion: { (rawData) in
                
                print(rawData)
                
                cell.backgroundColor = UIColor.clear
                
                let detailData = rawData["data"] as! [[String:Any]]
                
                let detailIndex = detailData[indexPath.row]
                
                DispatchQueue.main.async {
                    
                    let date = (detailIndex["time"] as! Double)
                    
                    let time = self.dateChanged(stringDate: date)
                    
                    cell.timeLabel.text = time
                    
                    let tempMin = (detailIndex["temperatureMin"] as! Double)
                    
                    let tempMax = (detailIndex["temperatureMax"] as! Double)
                    
                    let tempAverage = (tempMin + tempMax) / 2.00
                    
                    cell.tempLabel.text =  (String(format: "%.0f",(tempAverage))) + "º"
                    
                    let weather = (detailIndex["icon"]) as? String
                    
                    guard let unwrappedWeather = weather else { return }
                    
                    cell.emoji.text = self.bringEmoji(iconString: unwrappedWeather)
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            })
        }
        
        
        
        
        return cell
    }
    
    
    @IBAction func pickSegment(_ sender: UISegmentedControl) {
        
        
        DispatchQueue.main.async {
            
            self.tableViewHourly.reloadData()
            
        }
        
    }
    
    // MARK: - Methods
    
    
    
    func getCurrentData() {
        
        print("========> 1")
        
        WeatherAPI.getWeatherInfo { (JSON) in
            print("==========> 2")
            WeatherData.sharedInstance.getCurrentDataFromAPI(completion: { (currentData) in
                DispatchQueue.main.async {
                    self.labelTemp.text = "NOW " + (String(format: "%.0f",infoAPI(dictionary: currentData).temperature)) + "º"
                    
                    var icon = infoAPI(dictionary: currentData).icon
                    
                    if icon == "rain" {
                        
                        self.weatherView.image = UIImage(named: "rain")
                        
                    }
                    
                    if icon == "clear-day" {
                        
                        self.weatherView.image = UIImage(named: "sunny")
                        
                    }
                    
                    if icon == "snow" {
                        
                        self.weatherView.image = UIImage(named: "snow")
                        
                    }
                    
                    if icon == "cloudy" || icon == "partly-cloudy-night" {
                        
                        self.weatherView.image = UIImage(named: "sunny")
                        
                    }
                    
                    if icon == "partly-cloudy-day" {
                        
                        self.weatherView.image = UIImage(named: "partly cloudy")
                    }
                }
            })
        }
    }
    
    func bringEmoji(iconString: String) -> String {
        
        switch iconString {
            
        case "rain":
            return "🌧"
            
        case "clear-day":
            return "☀️"
            
        case "snow":
            return "🌨"
            
        case "clear-night":
            return ""
            
        case "cloudy", "partly-cloudy-night":
            return "☁️"
            
        case "wind":
            return "🌬"
            
        case "partly-cloudy-day":
            return "⛅️"
        default:
            break
        }
        return ""
    }
    
    func dateChanged(stringDate: Double) -> String {
        
        let date = Date(timeIntervalSince1970: stringDate)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        if pickSegment.selectedSegmentIndex == 0 {
            
            formatter.dateFormat = "hh:mm"
            
        } else if pickSegment.selectedSegmentIndex == 1 {
            
            formatter.dateFormat = "MM/DD"
            
        }
        
        
        let string = formatter.string(from: date)
        
        
        return string
        
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
