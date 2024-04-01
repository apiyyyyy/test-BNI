//
//  PortfolioDetailsViewController.swift
//  QRTransactionApp
//
//  Created by MOHAMMADB on 31/01/24.
//

import UIKit

class PortfolioDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    let viewModel = PortofolioDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        
        titleLabel.text = viewModel.titleLabel
    }

}

extension PortfolioDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.portoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortofolioDetailsTableViewCell", for: indexPath) as! PortofolioDetailsTableViewCell
        let data = viewModel.portoData[indexPath.row]
        
        cell.setupCell(data: data)
        
        return cell
    }
}

class PortofolioDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    
    func setupCell(data: TransactionData) {
        dateLabel.text = data.trx_date
        nominalLabel.text = data.nominal.formatToIDR()
    }
    

}


