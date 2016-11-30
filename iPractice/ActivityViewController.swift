//
//  ActivityViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 11/22/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation
import Charts

class ActivityViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView! {
        didSet {
            updateChart()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        navigationItem.titleView?.tintColor = UIColor.red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateChart()
    }
    
    func updateChart() {
        
        barChartView.noDataText = "You haven't finished any tasks"
        
        var dataSets = [BarChartDataSet]()
        
        var maxValue = 0.0
        
        var entries: [ChartDataEntry] = Array()
        
        var labels = [String]()
        var colors = [UIColor]()
        
        // initialize month data and iterate through the saved tasks to create chart
        for i in 0..<12 {
            var values = [Double]()
            for task in AllTasks.shared.list {
                labels.append(task.name)
                colors.append(UIColor.randomColor(seed: task.name))
                var countOfCompletions = 0.0
                for complDate in task.completionDates {
                    let month = Int(complDate.month) - 1
                    if month == i {
                        countOfCompletions += 1
                    }
                }
                values.append(countOfCompletions)
            }
            
            let sum = values.reduce(0, +)
            if (sum > maxValue) {
                maxValue = sum + 1
            }

            let result = BarChartDataEntry(x: Double(i), yValues: values)
            
            entries.append(result)
        }
        
        let charDataSet = BarChartDataSet(values: entries, label: "")
        charDataSet.stackLabels = labels
        charDataSet.colors = colors
        dataSets.append(charDataSet)
        
        
        let data = BarChartData(dataSets: dataSets)
        
        barChartView.data = data
        
        if (maxValue < 6) {
            // workaround for issue where y axis would show float values for low maxValue
            maxValue = 6
        }
        
        // set y axis
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = Double(maxValue)
        barChartView.rightAxis.axisMaximum = Double(maxValue)
        barChartView.leftAxis.labelTextColor = UIColor.barChartMain
        barChartView.rightAxis.labelTextColor = UIColor.barChartMain
        barChartView.leftAxis.axisLineColor = UIColor.barChartMain
        barChartView.rightAxis.axisLineColor = UIColor.barChartMain
        
        // set labels
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = UIColor.barChartMain
        barChartView.barData?.setValueTextColor(UIColor.barChartMain)
        barChartView.tintColor = UIColor.barChartMain
        barChartView.xAxis.axisLineColor = UIColor.barChartMain
        barChartView.xAxis.gridColor = UIColor.barChartMain
        barChartView.gridBackgroundColor = UIColor.barChartMain
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelCount = 12
        
        // hide description
        barChartView.chartDescription?.text = ""
        
        // format values to decimal
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let formatter = DefaultValueFormatter(formatter: format)
        barChartView.barData?.setValueFormatter(formatter)
        
        // format xAxis for month
        barChartView.xAxis.valueFormatter = BarChartFormatter()
        barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        
        
        
    }
    
    public class BarChartFormatter: NSObject, IAxisValueFormatter{
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            
            return months[Int(value)]
        }
    }
    
}

