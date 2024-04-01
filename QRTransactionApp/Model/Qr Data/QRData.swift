//
//  TransactionModel.swift
//  TestProjectScanQr
//
//  Created by Afi Permana on 18/11/23.
//

import Foundation

class QRData: Codable {
   let bank: String
   let transactionId: String
   let merchantName: String
   let nominalTransaction: Double
   
   init(bank: String, transactionId: String, merchantName: String, nominalTransaction: Double) {
      self.bank = bank
      self.transactionId = transactionId
      self.merchantName = merchantName
      self.nominalTransaction = nominalTransaction
   }
}
