//
//  ScanQrViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 13/12/23.
//

import UIKit
import AVFoundation

class ScanQrViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var previewView: UIView!
    var captureSession : AVCaptureSession!
    var previewLayer : AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        permissionAccess()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
       
    func permissionAccess() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if authStatus == .denied {
            let alert = UIAlertController(title: "Failed", message: "Camera Permission saat ini tidak aktif, silahkan aktifkan camera permission agak bisa melanjutkan scan Qr", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                self.dismiss(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                self.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true)
        }
        setupQr()
    }
    
    func setupQr() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {return}
        let videoInput : AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }else {
            failedMessage()
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metaDataOutput)) {
            captureSession.addOutput(metaDataOutput)
            
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.qr]
        }else {
            failedMessage()
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = self.view.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.cameraView.layer.addSublayer(self.previewLayer)
        }
        
        
    }
    
    func failedMessage() {
        let alert = UIAlertController(title: "Scan Qr not support", message: "Device anda tidak support scan qr", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        captureSession = nil
    }
    
    func scannedDataQR(code: String){
        let scannedQR = code.components(separatedBy: ".")
        let nominal = Double(scannedQR[3])
        
        let qrObjc = QRData.init(bank: scannedQR[0], transactionId: scannedQR[1], merchantName: scannedQR[2], nominalTransaction: nominal!)

        
        //Moved to checkout
        
        moveToCheckout(qrObjc: qrObjc)
    }
    
    func moveToCheckout(qrObjc: QRData) {
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TransactionViewController") as? TransactionViewController {
            destinationVC.viewModel.qrData = qrObjc
            navigationController?.pushViewController(destinationVC, animated: true)
            return
        }
        
    }
}

extension ScanQrViewController: AVCaptureMetadataOutputObjectsDelegate  {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first{
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else {return}
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            scannedDataQR(code: stringValue)
        }
    }
    
}
