//
//  WeatherViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 04/10/24.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var weatherDetailsLabel: UILabel!

    let weatherOptions = ["Sunny", "Cloudy", "Rainy", "Windy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeatherData()
        
    }
    
    func displayWeatherData() {
        // Retrieve weekly records from UserDefaults for each week
        var weatherCount = [String: Int]()
        
        // Iterate through the weeks (1 to 4)
        for week in 1...4 {
            let weekKey = "week\(week)IrrigationRecords" // Key for week records
            if let weekRecords = UserDefaults.standard.dictionary(forKey: weekKey) as? [String: [String: Any]] {
                // Check if weather data exists for the week
                for record in weekRecords.values {
                    if let weather = record["weather"] as? String {
                        weatherCount[weather, default: 0] += 1
                    }
                }
            }
        }

        // Determine the weather type with the highest count
        let mostFrequentWeather = weatherCount.max(by: { $0.value < $1.value })?.key
        let weeksCount = weatherCount[mostFrequentWeather ?? ""] ?? 0
        
        // Update summary label
        if let weather = mostFrequentWeather {
            weatherSummaryLabel.text = "Weather of the Month: A \(weather) Month!"
            weatherDetailsLabel.text = generateWeatherPhrase(for: weather, weeksCount: weeksCount)
        } else {
            weatherSummaryLabel.text = "No weather data available for this month."
            weatherDetailsLabel.text = ""
        }
    }
    
    func generateWeatherPhrase(for weather: String, weeksCount: Int) -> String {
        let climatePhrase: String
        
        switch weather {
        case "Sunny":
            climatePhrase = "This month, the sun shone brightly! ☀️"
        case "Cloudy":
            climatePhrase = "This month, the clouds brought a gentle shade! ☁️"
        case "Rainy":
            climatePhrase = "This month, the rain didn't stop falling! 🌧️"
        case "Windy":
            climatePhrase = "This month, the winds danced through the fields! 🌬️"
        default:
            climatePhrase = ""
        }
        
        return "You had \(weeksCount) weeks of \(weather.lowercased()) weather, which favored the growth of your crops. \(climatePhrase)"
    }
    
    @IBAction func continueToNextScreen(_ sender: UIButton) {
        // Implement navigation to the next screen if necessary
    }
}

