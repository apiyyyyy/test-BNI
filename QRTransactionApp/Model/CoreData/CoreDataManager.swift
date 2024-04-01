//
//  CoreDataManager.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 19/01/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QRTransactionApp")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Error Container = \(error)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    //MARK: - Save Data
    func saveData() {
        
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let error = error as NSError
                print("Error Save Data \(error)")
            }
        }
    }
    
    //MARK: - User Management
    func createUser(userId: String, initialBalance: Double) {
        let userData = UserData(context: context)
        
        userData.userId = userId
        userData.balance = initialBalance
        saveData()
    }
    
    func getUser(userId: String) -> UserData? {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)

            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    print("User data \(user)")
                    return user
                } else {
                    print("User not found")
                    //create user 
                    createUser(userId: BASEUSERID, initialBalance: 9000000)
                    let user = users.first
                    return user
                }
            } catch {
                print("Error Fetching User \(error)")
                return nil
            }

    }
    
    func createTransaction(user:UserData, amount: Double, merchant: String, date:Date){
        
        let newTransaction = Transaction(context: context)
        newTransaction.transactionId = UUID().uuidString
        newTransaction.amount = amount
        newTransaction.merchant = merchant
        newTransaction.date = date
        newTransaction.userData = user
        saveData()
    }
    
    func getTransactions(user:UserData) -> [Transaction] {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        let sortTransaction = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortTransaction]
        
        do{
            let usersTransaction = try! context.fetch(fetchRequest)
            return usersTransaction
        }catch {
            print("Error Fetching User \(error)")
            return []
        }
    }
}


//MARK: - USERID

let BASEUSERID = "testUser123"
