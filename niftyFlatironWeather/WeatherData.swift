//
//  WeatherData.swift
//  niftyFlatironWeather
//
//  Created by Enrique Torrendell on 11/4/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

class WeatherData {
    
    // PROPERTIES 
    
    static let sharedInstance = WeatherData()
    
    // INITIALIZERS
    
    private init() {}
    
    // METHODS
    
    func getCurrentDataFromAPI(completion: @escaping ([String:Any]) -> Void) {
        
        print("We are getting into the Current Data raw information")
        
        var currentData: [String:Any] = [:]
        
        WeatherAPI.getWeatherInfo { (JSON) in
            
            currentData = JSON["currently"] as! [String:Any]
            
            print("9a. We just load the CURRENT DATA")
            
            completion(currentData)
        }
    }
    
    func getHourlyDataFromAPI(completion: @escaping ([String:Any]) -> Void) {
        
        print("We are getting into the Hourly Data raw information")
        
        var hourlyData: [String:Any] = [:]
        
        WeatherAPI.getWeatherInfo { (JSON) in
            
            hourlyData = JSON["hourly"] as! [String:Any]
            
            print("9b. We just load the HOURLY DATA")
            
            completion(hourlyData)
            
        }
    }
    
    func getHourlyDetailDataFromAPI(completion: @escaping ([[String:Any]]) -> Void) {
        
        print("We are getting into the Hourly Data raw information")
        
        var hourlyData: [String:Any] = [:]
        
        var hourlyDetail: [[String:Any]] = [[:]]

        WeatherAPI.getWeatherInfo { (JSON) in
        
            hourlyData = JSON["hourly"] as! [String:Any]
            
            hourlyDetail = [hourlyData["data"] as! [String : Any]]
            
            print("9b. We just load the HOURLY DATA")
            
            completion(hourlyDetail)
            
        }
    }

    
    func getDailyDataFromAPI(completion: @escaping ([String:Any]) -> Void) {
        
        print("We are getting into the Daily Data raw information")
        
        var dailyData: [String:Any] = [:]
        
        WeatherAPI.getWeatherInfo { (JSON) in
            
            dailyData = JSON["daily"] as! [String:Any]
            
            print("9c. We just load the DAILY DATA")
            
            completion(dailyData)
        }
    }
    
    func getDailyDetailDataFromAPI(completion: @escaping ([String:Any]) -> Void) {
        
        print("We are getting into the Daily Data raw information")
        
        var dailyData: [String:Any] = [:]
        
        var dailyDetail: [String:Any] = [:]
        
        WeatherAPI.getWeatherInfo { (JSON) in
            
            dailyData = JSON["daily"] as! [String:Any]
            
            dailyDetail = dailyData["data"] as! [String:Any]
            
            print("9c. We just load the DAILY DATA")
            
            completion(dailyDetail)
        }
    }

    
}
