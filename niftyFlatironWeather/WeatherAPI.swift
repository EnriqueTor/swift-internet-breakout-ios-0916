//
//  WeatherAPI.swift
//  niftyFlatironWeather
//
//  Created by Enrique Torrendell on 11/4/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

class WeatherAPI {
    
    class func getWeatherInfo(with completion: @escaping (([String:Any]) -> Void)) {
        
        let urlString = Secrets.link + Secrets.key
        print("2. We put together the link, getting the data from Secrets")
        
        let url = URL(string: urlString)
        print("3. We transfor the string into an URL")
        
        let session = URLSession.shared
        print("4. We created the URL session that we will use to enter the web")
        
        guard let unwrappedUrl = url else { return }
        print("5. We are taking care of the optional")
        
        let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            print("6. We are creating the constant to get the data from an URL")
            
            guard let unwrappedData = data else { return }
            print("7. We are taking care of the optional")
            
            do {
                
                let JSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                print("8a. We are accessing the raw data")
                
                completion(JSON)
                
                
            } catch {
                
                print("8b. Something failed!!")
            }
            
        }
        task.resume()
        
    }
    
}


