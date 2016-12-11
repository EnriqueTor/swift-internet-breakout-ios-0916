//
//  infoAPI.swift
//  niftyFlatironWeather
//
//  Created by Enrique Torrendell on 11/4/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

class infoAPI {
    
    // MARK: - Properties
    
    var time: Double
    var summary: String
    var icon: String
    var nearestStormDistance: Double?
    var nearestStormBearing: Double?
    var precipIntensity: Double
    var precipProbability: Double
    var temperature: Double
    var apparentTemperature: Double
    var dewPoint: Double
    var humidity: Double
    var windSpeed: Double
    var windBearing: Double
    var visibility: Double
    var cloudCover: Double
    var pressure: Double
    var ozone: Double
    
    // MARK: - Initializers 
    
    init(dictionary: [String:Any]) {
        
        self.time = dictionary["time"] as! Double
        self.summary = dictionary["summary"] as! String
        self.icon = dictionary["icon"] as! String
//        self.nearestStormDistance = dictionary["nearestStormDistance"] as! Double
//        self.nearestStormBearing = dictionary["nearestStormBearing"] as! Double
        self.precipIntensity = dictionary["precipIntensity"] as! Double
        self.precipProbability = dictionary["precipProbability"] as! Double
        self.temperature = dictionary["temperature"] as! Double
        self.apparentTemperature = dictionary["apparentTemperature"] as! Double
        self.dewPoint = dictionary["dewPoint"] as! Double
        self.humidity = dictionary["humidity"] as! Double
        self.windSpeed = dictionary["windSpeed"] as! Double
        self.windBearing = dictionary["windBearing"] as! Double
        self.visibility = dictionary["visibility"] as! Double
        self.cloudCover = dictionary["cloudCover"] as! Double
        self.pressure = dictionary["pressure"] as! Double
        self.ozone = dictionary["ozone"] as! Double
        
    }

}

    
