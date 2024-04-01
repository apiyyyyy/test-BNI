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
    lazy var user : UserData! = {
        return coreDataManager.getUser(userId: BASEUSERID)
    }()
    
    func confirmTransaction(amount:Double, merchant: String, date:Date, completion: @escaping (Bool) -> ()) {
        coreDataManager.createTransaction(user: user, amount: amount, merchant: merchant, date: date)
        
        if user.balance >= amount {
            user.balance -= amount
            coreDataManager.saveData()
            print("Success")
            completion(true)
        }else {
            print("error saldo kurang")
            completion(false)
        }
     }
}
