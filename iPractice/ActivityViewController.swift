//
//  ActivityViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 11/22/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation
import Charts

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView! {
        didSet {
            updateChart()
        }
    }
    var months: [String]!
    
    var dataSet: BarChartDataSet!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateChart()
    }

    func updateChart() {
        
        var values = [Int]()
        
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
//        let chartData = BarChartData(xVals: months, dataSet: dataSet)
//        barChartView.data = chartData
        
        // initialize month data to 12 zeros
        for _ in 0..<12 {
            values.append(0)
        }
        
        // read completion dates of tasks and update the values at the correct month
        for task in AllTasks.shared.list {
            for complDate in task.completionDates {
                let month = Int(complDate.month) - 1
                values[month] = values[month] + 1
            }
        }

        // convert data for the Chart
        var entries: [ChartDataEntry] = Array()
        
        for (i, value) in values.enumerated() {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(value)))
        }
        
        dataSet = BarChartDataSet(values: entries, label: "One completed task")
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.backgroundColor = UIColor.red
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.rightAxis.axisMinimum = 0.0
        barChartView.data = data
    }
    
}

