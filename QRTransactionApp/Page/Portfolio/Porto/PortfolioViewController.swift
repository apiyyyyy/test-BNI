//
//  PortfolioViewController.swift
//  QRTransactionApp
//
//  Created by MOHAMMADB on 29/01/24.
//

import Foundation
import DGCharts
import UIKit

class PortfolioViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var donutChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    
    let viewModel = PortfolioViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let pieEntry = entry as? PieChartDataEntry {
            let label = pieEntry.label
        
            if let destVc = storyboard?.instantiateViewController(withIdentifier: "PortfolioDetailsViewController") as? PortfolioDetailsViewController {
                destVc.viewModel.portoData =  viewModel.setDataDetails(label: label!, data: viewModel.chartDataItem)
                destVc.viewModel.titleLabel = label!
                navigationController?.pushViewController(destVc, animated: true)
            }
        }
    }
    
    func setupUI() {
        donutChart.delegate = self
        lineChart.delegate = self
        viewModel.getChartData()
        
        setupChartDonut(data: viewModel.donutData)
        setupLineChart(data: viewModel.lineData!)
    }
    
    func setupChartDonut(data: [ChartModel]) {
    
        let dataSet = PieChartDataSet(entries: viewModel.setDonutChartData(data: data), label: "Percentage Transaction")
        dataSet.drawIconsEnabled = false
        dataSet.sliceSpace = 2
        
        dataSet.colors = ChartColorTemplates.vordiplom()
        + ChartColorTemplates.joyful()
        + ChartColorTemplates.colorful()
        + ChartColorTemplates.liberty()
        + ChartColorTemplates.pastel()
        + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: dataSet)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = " %"
        formatter.multiplier = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        data.setValueFont(.systemFont(ofSize: 13, weight: .light))
        data.setValueTextColor(.black)
        
        donutChart.data = data
        donutChart.highlightValue(nil)
    }
    
    func setupLineChart(data: LineChartModel) {
        var lineDataSet  = LineChartDataSet(entries: viewModel.setLineChartData(data: viewModel.lineData!), label: "Months")
        
        let data = LineChartData(dataSet: lineDataSet)
        lineChart.data = data
    }
}
