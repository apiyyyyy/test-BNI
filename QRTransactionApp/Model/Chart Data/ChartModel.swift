//
//  ChartModel.swift
//  QRTransactionApp
//
//  Created by MOHAMMADB on 29/01/24.
//

import Foundation
import SwiftyJSON

struct ChartModel: Codable {
    let type: String
    let data: [ChartDataItem]

    init(json: JSON) {
        self.type = json["type"].stringValue
        let data_ = json["data"].arrayValue
        self.data = data_.map { ChartDataItem(json: $0) }
    }
    
    init(type: String, data: [ChartDataItem]) {
        self.type = type
        self.data = data
    }
}

struct ChartDataItem: Codable {
    let label: String
    let percentage: String
    let data: [TransactionData]

    init(json: JSON) {
        self.label = json["label"].stringValue
        self.percentage = json["percentage"].stringValue
        let data_ = json["data"].arrayValue
        self.data = data_.map { TransactionData(json: $0) }
    }
    
    init(label:String, percentage: String, data: [TransactionData]) {
        self.label = label
        self.percentage = percentage
        self.data = data
    }
}

struct TransactionData: Codable {
    let nominal: Double
    let trx_date: String
    
    init(json: JSON) {
        self.nominal = json["nominal"].double ?? 0
        self.trx_date = json["trx_date"].string ?? ""
    }
    
    init(nominal: Double, trx_date: String) {
        self.nominal = nominal
        self.trx_date = trx_date
    }
}

struct LineChartModel: Codable {
    let data: LineDataItem
    
    init(json: JSON) {
        self.data = LineDataItem.init(json: json)
    }
}

struct LineDataItem : Codable {
    let month: [Int]
    
    init(json: JSON){
        self.month = json["month"].arrayObject as? [Int] ?? []
    }
}



