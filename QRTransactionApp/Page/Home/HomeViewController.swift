//
//  HomeViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 12/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    
    let viewModel =  HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserData()
        
        if viewModel.isReload {
            reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUi() {
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }

    func getUserData() {
        viewModel.getUser()
        
        if viewModel.user != nil {
            viewModel.getTransaction(user: viewModel.user!)
        }
        
        let formatter = viewModel.user?.balance.formatted(.currency(code: "IDR"))
        saldoLabel.text = formatter
    }
    
    func reloadData() {
        homeTableView.reloadData()
        viewModel.isReload = false
        print("piy hehe")
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let data = viewModel.transactionHistory[indexPath.row]
        cell.setupCell(data: data)
        
        return cell
    }
}

class HomeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    func setupCell(data: Transaction) {
        nominalLabel.text = data.amount.formatToIDR()
        merchantLabel.text = data.merchant
    }
    
    
}

protocol ConfirmationReloadDataDelegate: AnyObject {
    func reloadData()
}
