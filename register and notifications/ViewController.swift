//
//  ViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 01/10/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var litersTextField: UITextField!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        let userName = nameTextField.text ?? ""
        
        // Convert litersTextField input to Double
        if let userWater = Double(litersTextField.text ?? "") {
            // Check if name is empty
            if userName.isEmpty {
                showAlert(title: "Error", message: "Please fill in all the fields.")
            } else {
                print("User's name: \(userName)")
                print("Water usage per hour: \(userWater) liters/hour")
                
                // Save user data to UserDefaults
                UserDefaults.standard.set(userWater, forKey: "userWaterRate")
                UserDefaults.standard.set(userName, forKey: "userName")
                
                showAlert(title: "Registration Successful", message: "Welcome, \(userName)! You have registered \(userWater) liters/hour for irrigation.")
               
            }
        } else {
            // Handle the case where input is not a valid number
            showAlert(title: "Error", message: "Please enter a valid number for water usage per hour.")
        }
    }

    @IBAction func continueToNextScreen(_ sender: UIButton) {
       
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
