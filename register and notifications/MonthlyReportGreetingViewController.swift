//
//  MonthlyReportGreetingViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 02/10/24.
//

import Foundation
import UIKit

class MonthlyReportGreetingViewController: UIViewController {
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch user's name from UserDefaults 
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            greetingLabel.text = "Hi \(userName), this is your monthly report!"
        } else {
            greetingLabel.text = "Hi, this is your monthly report!" // Default text if no name is found
        }
      
        
    }
    @IBAction func continueToNextScreen(_ sender: UIButton) {
    
    }
}


