//
//  WeatherManager.swift
//  Daily Weather
//
//  Created by Ebubechukwu Dimobi on 10.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel )
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        
        //check for spaces
        
        //Constants.apikey is the apikey
        if cityName.contains(" "){
            let array = cityName.components(separatedBy: " ")
            let urlString = "\(Constants.apiKey)&q=\(array[0])%20\(array[1])"
            performRequest(urlString: urlString)
        }else {
            let urlString = "\(Constants.apiKey)&q=\(cityName)"
            performRequest(urlString: urlString)
            
        }
    }
    
    func fetchWeather(latitude:Double, longitude: Double){
        let urlString = "\(Constants.apiKey)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        
        if let url = URL(string: urlString){
            
            //2. create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3.  Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                //firstly check for errors
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                //check if data is not nil and then convert it to readable format
                if let safeData = data{
                    
                    // calls a function that decodes safeData and assigns the decoded data in an object... i used same names not to confuse
                    if let weatherModel = self.parseJSON(weatherData: safeData){
                        
                        self.delegate?.didUpdateWeather(self, weatherModel: weatherModel )
                    }
                }
            }
            //4. Start the task
            task.resume()
            
            
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        
        //create a decoder object to decode
        let decoder = JSONDecoder()
        
        // we decode using the wWatherData struct
        
        do{
            //create an object to catch the decoded data and store in WeatherData Struct
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature =  decodedData.main.temp
            let description = decodedData.weather[0].description
            
            //create a weather object to store decoded data
            
            let weatherModel = WeatherModel(conditionId: conditionId, cityName: cityName, temperature: temperature, description: description)
            
            return weatherModel
            
            
        }catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        
    }
    
    
    
    
}
