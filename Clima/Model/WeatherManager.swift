//
//  WeatherManager.swift
//  Clima
//
//  Created by Lukas Adomavicius on 1/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e285e3c75192dff2ef27068e5b9904bd&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Create a URL
        
        if let url = URL(string: urlString) {
            // Create a URLSession
            
            let session = URLSession(configuration: .default)
            // Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error ) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            //Start the task
            
            task.resume()
        }
    }
    func parseJSON (_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temperature = decodedData.main.temp
            let responseId = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(cityName: name, responseId: responseId, temperature: temperature)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
