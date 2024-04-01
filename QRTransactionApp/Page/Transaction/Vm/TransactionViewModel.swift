//
//  TransactionViewModel.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 21/01/24.
//

import Foundation



class TransactionViewModel {
    
    
    var qrData: QRData! = nil
    let coreDataManager = CoreDataManager.shared
    var user: UserData!
    
    
    func confirmTransaction(user:UserData, amount:Double, merchant: String, date:Date) {
        coreDataManager.createTransaction(user: user, amount: amount, merchant: merchant, date: date)
     }
    
    func getUser() {
       user = coreDataManager.getUser(userId: BASEUSERID)
    }
}
