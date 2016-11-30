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
        
        var maxValue = 0
        
        for task in AllTasks.shared.list {
            
            var values = [Int]()
            
            // initialize month data to 12 zeros
            for _ in 0..<12 {
                values.append(0)
            }
            
            // read completion dates of tasks and update the values at the correct month
            for complDate in task.completionDates {
                let month = Int(complDate.month) - 1
                values[month] = values[month] + 1
                if values[month] > maxValue {
                    maxValue = values[month]
                }
            }
            
            // convert data for the Chart
            var entries: [ChartDataEntry] = Array()
            
            for (i, value) in values.enumerated() {
                entries.append(BarChartDataEntry(x: Double(i), y: Double(value)))
            }
            
            let charDataSet = BarChartDataSet(values: entries, label: task.name)
            charDataSet.colors = [UIColor.randomColor(seed: task.name).withAlphaComponent(0.4)]
            dataSets.append(charDataSet)
        }
        
        let data = BarChartData(dataSets: dataSets)
        
        
        //        data.groupWidth(groupSpace: barChartView.xAxis.axisMaximum / 12.0, barSpace: 0.03)
        //        data.barWidth = 0.167
        //        data.groupBars(fromX: 0, groupSpace: 0.2, barSpace: 0.03)
        
        //        barChartView.backgroundColor = UIColor(red: 0.1765, green: 0.3412, blue: 0.7686, alpha: 1.0)
        
        barChartView.data = data
        
        //        barChartView.groupBars(fromX: 0, groupSpace: data.groupWidth(groupSpace: barChartView.xAxis.axisMaximum / 12.0, barSpace: 0.03), barSpace: 0.03)
        //        barChartView.rightAxis.drawGridLinesEnabled = false
        //        barChartView.xAxis.decimals = 0
        
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
    
    //    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
    //        print("\(entry.description)")
    //    }
    
}

