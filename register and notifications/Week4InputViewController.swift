//
//  Week4InputViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 03/10/24.
//

import Foundation
import UIKit

class Week4InputViewController: UIViewController {

    @IBOutlet weak var irrigationTextField: UITextField!
    @IBOutlet weak var weatherPicker: UIPickerView!
    @IBOutlet weak var yieldTextField: UITextField!

    let weatherOptions = ["Sunny", "Cloudy", "Rainy", "Windy"]
    var selectedWeather: String = "Sunny"

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherPicker.delegate = self
        weatherPicker.dataSource = self
    }

    @IBAction func saveWeeklyData(_ sender: UIButton) {
        // Convert inputs to Double
        guard let irrigationText = irrigationTextField.text,
              let yieldText = yieldTextField.text,
              let irrigation = Double(irrigationText),
              let yield = Double(yieldText) else {
            // Show an alert if the conversion fails
            showAlert(title: "Error", message: "Please enter valid numbers for irrigation and yield.")
            return
        }

        // Generate a unique key
        let uniqueKey = UUID().uuidString
        
        // Create the weekly data dictionary with Double values
        let weeklyData: [String: Any] = ["irrigation": irrigation, "weather": selectedWeather, "yield": yield]

        // Save in UserDefaults
        var weeklyRecords = UserDefaults.standard.dictionary(forKey: "week4IrrigationRecords") as? [String: [String: Any]] ?? [:]
        weeklyRecords[uniqueKey] = weeklyData
        UserDefaults.standard.set(weeklyRecords, forKey: "week4IrrigationRecords")

        // Confirmation alert
        showAlert(title: "Data Saved", message: "Your data for Week 4 has been saved.")
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func continueToNextScreen(_ sender: UIButton) {
        // Implement navigation to the next screen
    }
}

// Extension for UIPickerView
extension Week4InputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weatherOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weatherOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWeather = weatherOptions[row]
    }
}
