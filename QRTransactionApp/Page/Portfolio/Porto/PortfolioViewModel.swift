//
//  PortfolioViewModel.swift
//  QRTransactionApp
//
//  Created by MOHAMMADB on 30/01/24.
//

import Foundation
import UIKit
import SwiftyJSON
import DGCharts

class PortfolioViewModel {
    
    var donutData : [ChartModel] = []
    var lineData : LineChartModel?
    var detailsData : [TransactionData] = []
    var chartDataItem : [ChartDataItem] = []
    
    func setDonutChartData(data: [ChartModel]) -> [PieChartDataEntry] {
       let donutData = data.first(where: { $0.type == "donutChart"})!
        
        var dataChart : [PieChartDataEntry] = []
        
        for i in donutData.data {
            if let percentage = Double(i.percentage) {
                dataChart.append(PieChartDataEntry(value: percentage, label: i.label))
                chartDataItem.append(ChartDataItem(label: i.label, percentage: i.percentage, data: i.data))
            }
        }
        
        return dataChart
    }
    
    func setLineChartData(data: LineChartModel) -> [ChartDataEntry] {
        let lineDataChart = lineData!.data
        
        var dataChart : [ChartDataEntry] = []
        
        for (index, value) in lineDataChart.month.enumerated() {
            dataChart.append(ChartDataEntry(x: Double(index), y: Double(value)))
        }
        
        return dataChart
    }
    
    
    
    func setDataDetails(label: String, data: [ChartDataItem]) -> [TransactionData]{
        let data = data.first(where: {$0.label == label})!
        
        for i in data.data {
            detailsData.append(TransactionData(nominal: i.nominal, trx_date: i.trx_date))
        }
        
        return detailsData
    }

    func getChartData(){
        if let fileURL = Bundle.main.url(forResource: "chartData", withExtension: "json"){
            do {
                let jsonData = try! Data(contentsOf: fileURL)
                let chartData = JSON(jsonData)

                for (_, subJson):(String, JSON) in chartData {
                    let type = subJson["type"].stringValue
                    
                    switch type {
                    case "donutChart" :
                        let data = subJson["data"].arrayValue.map {ChartDataItem(json: $0)}
                        donutData.append(ChartModel(type: type, data: data))
                    case "lineChart" :
                        let lineChartData = subJson["data"]
                        self.lineData = LineChartModel.init(json: lineChartData)
                    default:
                        break
                    }
                }
            }
        }else {
            print("error no file found")
        }
    }

}
