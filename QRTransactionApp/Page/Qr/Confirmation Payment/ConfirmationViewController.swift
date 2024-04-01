//
//  ConfirmationViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 21/01/24.
//

import UIKit

class ConfirmationViewController: UIViewController{
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    
    var vm = ConfirmationViewModel()
    var delegate : ConfirmationReloadDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        merchantNameLabel.text = vm.merchantString
        nominalLabel.text = vm.nominalString
        
    }
    
    @IBAction func returnHomeAction(_ sender: UIButton) {
        if let homeViewController = navigationController?.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
            NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
            homeViewController.viewModel.isReload = true
            navigationController?.popToViewController(homeViewController, animated: true)
        }
    }
}

