//
//  HomeViewModel.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 22/01/24.
//

import Foundation


class HomeViewModel {
    
    var user : UserData?
    var coreDataManager = CoreDataManager.shared
    var transactionHistory : [Transaction] = []
    var isReload = false
    
    
    func getUser() {
        user = coreDataManager.getUser(userId: BASEUSERID)
    }
    
    func getTransaction(user: UserData){
        transactionHistory.removeAll()
        let transaction = coreDataManager.getTransactions(user: user)
        for i in transaction {
            transactionHistory.append(i)
        }
        print("transaction history = \(transactionHistory)")
        
    }
}
