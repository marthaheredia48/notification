//
//  PreviousMonthInputViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 03/10/24.
//

import Foundation
import UIKit

class PreviousMonthInputViewController: UIViewController {

    // IBOutlets for the input fields
    @IBOutlet weak var irrigationTextField: UITextField!
    @IBOutlet weak var weatherPicker: UIPickerView!
    @IBOutlet weak var yieldTextField: UITextField!
    
    // Data for the weather picker
    let weatherOptions = ["Sunny", "Cloudy", "Rainy", "Windy"]
    var selectedWeather: String = "Sunny"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the weather picker
        weatherPicker.delegate = self
        weatherPicker.dataSource = self
    }
 
    // Action to save the data for the previous month
    @IBAction func savePreviousMonthData(_ sender: UIButton) {
        guard let irrigationText = irrigationTextField.text,
              let yieldText = yieldTextField.text,
              let irrigation = Double(irrigationText),
              let yield = Double(yieldText) else {
            showAlert(title: "Error", message: "Please enter valid numbers for irrigation and yield.")
            return
        }

        // Retrieve the user’s water rate
        let userWaterRate = UserDefaults.standard.double(forKey: "userWaterRate")

        // Create the dictionary for previous month data with Double values
        let previousMonthData: [String: Any] = ["irrigation": irrigation, "weather": selectedWeather, "yield": yield, "waterRate": userWaterRate]

        // Save in UserDefaults with a separate key for previous month
        var previousMonthRecords = UserDefaults.standard.dictionary(forKey: "previousMonthRecords") as? [String: [String: Any]] ?? [:]
        previousMonthRecords["PreviousMonth"] = previousMonthData
        UserDefaults.standard.set(previousMonthRecords, forKey: "previousMonthRecords")
        
        // Confirmation alert
        showAlert(title: "Data Saved", message: "Your data for the previous month has been saved.")
    }

    // Function to show alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func continueToNextScreen(_ sender: UIButton) {
        // Logic to move to the next screen (Week 1 or any other screen)
    }
}

// Extension to handle UIPickerView
extension PreviousMonthInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
