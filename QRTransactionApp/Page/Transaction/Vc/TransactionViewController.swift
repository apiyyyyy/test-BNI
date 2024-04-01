//
//  TransactionViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 21/01/24.
//

import UIKit

class TransactionViewController: UIViewController {

    
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var confirmButton: UIButton!
    
    let viewModel = TransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUser()
    }
    
    func setupUI() {
        activityIndicator.isHidden = true
        merchantLabel.text = viewModel.qrData.merchantName
        nominalLabel.text = "\(viewModel.qrData.nominalTransaction)"
    }
    
    
    @IBAction func confirmPaymentAction(_ sender: UIButton) {
        viewModel.confirmTransaction(user: viewModel.user, amount: viewModel.qrData.nominalTransaction, merchant: viewModel.qrData.merchantName, date: Date())
        
        confirmButton.titleLabel?.text = ""
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            navigationController?.pushViewController(ConfirmationViewController(), animated: true)
            activityIndicator.stopAnimating()
        }
        
    }
    

}
