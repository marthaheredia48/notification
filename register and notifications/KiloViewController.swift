//
//  KiloViewController.swift
//  register and notifications
//
//  Created by Martha Heredia Andrade on 04/10/24.
//

import UIKit

class KiloViewController: UIViewController {

    @IBOutlet weak var summaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch data from UserDefaults for all weeks in Month 1
        let totalKilogramsMonth1 = calculateTotalYieldForMonth1()

        // Fetch the previous month's yield
        let previousMonthYield = retrievePreviousMonthData()?.yield ?? 0.0

        // Calculate the percentage increase compared to the previous month
        let percentageIncrease = calculatePercentageIncrease(from: previousMonthYield, to: totalKilogramsMonth1)

        // Display the results
        summaryLabel.text = """
        Total Yield in Month 1: \(totalKilogramsMonth1) kg
        That's a \(percentageIncrease)% increase in your performance compared to the previous month! 📈✨
        """
        
        // Clear previous records only after calculation
        //clearPreviousData()
    }
    

    // Function to clear previous records in UserDefaults
    func clearPreviousData() {
        
        UserDefaults.standard.removeObject(forKey: "week1IrrigationRecords")
        UserDefaults.standard.removeObject(forKey: "week2IrrigationRecords")
        UserDefaults.standard.removeObject(forKey: "week3IrrigationRecords")
        UserDefaults.standard.removeObject(forKey: "week4IrrigationRecords") // Ensure the key matches
        UserDefaults.standard.removeObject(forKey: "previousMonthRecords")
    }

    // Function to calculate the total yield for Month 1
    func calculateTotalYieldForMonth1() -> Double {
        var totalYield: Double = 0.0

        // Retrieve Week 1 data
        if let week1Records = UserDefaults.standard.dictionary(forKey: "week1IrrigationRecords") as? [String: [String: Any]] {
            let week1Yield = extractTotalYield(from: week1Records)
            print("Yield for week1IrrigationRecords: \(week1Yield) kg")
            totalYield += week1Yield
        }

        // Retrieve Week 2 data
        if let week2Records = UserDefaults.standard.dictionary(forKey: "week2IrrigationRecords") as? [String: [String: Any]] {
            let week2Yield = extractTotalYield(from: week2Records)
            print("Yield for week2IrrigationRecords: \(week2Yield) kg")
            totalYield += week2Yield
        }

        // Retrieve Week 3 data
        if let week3Records = UserDefaults.standard.dictionary(forKey: "week3IrrigationRecords") as? [String: [String: Any]] {
            let week3Yield = extractTotalYield(from: week3Records)
            print("Yield for week3IrrigationRecords: \(week3Yield) kg")
            totalYield += week3Yield
        }

        // Retrieve Week 4 data
        if let week4Records = UserDefaults.standard.dictionary(forKey: "week4IrrigationRecords") as? [String: [String: Any]] {
            let week4Yield = extractTotalYield(from: week4Records)
            print("Yield for week4IrrigationRecords: \(week4Yield) kg")
            totalYield += week4Yield
        }

        print("Total Yield for Month 1: \(totalYield) kg") // Log total yield
        return totalYield
    }

    // Function to calculate percentage increase
    func calculatePercentageIncrease(from previousMonth: Double, to currentMonth: Double) -> Double {
        guard previousMonth > 0 else {
            return 100.0 // If previous month yield is zero, treat it as a 100% increase
        }
        return ((currentMonth - previousMonth) / previousMonth) * 100
    }

    // Function to extract the total yield from weekly records
    func extractTotalYield(from records: [String: [String: Any]]) -> Double {
        var totalYield = 0.0
        for (_, data) in records {
            if let yield = data["yield"] as? Double {
                totalYield += yield
            }
        }
        return totalYield
    }

    // Retrieve previous month's data
    func retrievePreviousMonthData() -> (irrigation: Double, yield: Double)? {
        if let previousMonthRecords = UserDefaults.standard.dictionary(forKey: "previousMonthRecords") as? [String: [String: Any]],
           let previousMonthData = previousMonthRecords["PreviousMonth"],
           let irrigation = previousMonthData["irrigation"] as? Double,
           let yield = previousMonthData["yield"] as? Double {
            return (irrigation, yield)
        }
        return nil
    }

    @IBAction func continueToNextScreen(_ sender: UIButton) {
        // Implement navigation to the next screen
    }
}



