//
//  BarcodeVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/6/21.
//
/*
import UIKit
import AVFoundation

protocol BarcodeDelegate {
    func barcodeReaded(barcode: String)
}

class BarcodeVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var delegate: BarcodeDelegate?
    private let photoOutput = AVCapturePhotoOutput()
    private var isCapturing = false
    
    
    
    //   var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.default(for: .video)!
    
    
    //   var device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var device = AVCaptureDevice.default(for: .video)
    
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureSession = AVCaptureSession()
    var code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.addOutput(photoOutput)
        
        self.view.backgroundColor = UIColor.clear
        self.setupCamera()
    }
    
    private func setupCamera() {
        
        let input = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        
        print("canAddOutput 0")
        if self.captureSession.canAddInput(input!) {
            print("canAddOutput 1 \(input!)")
            self.captureSession.addInput(input!)
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let videoPreviewLayer = self.previewLayer {
            print("canAddOutput 2")
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = self.view.bounds
            view.layer.addSublayer(videoPreviewLayer)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) {
            
            print("canAddOutput 3 \(metadataOutput)")
            
            self.captureSession.addOutput(metadataOutput)
//            image.ima
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13]
        } else {
            print("Could not add metadata output")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let photoSettings = AVCapturePhotoSettings()
        if !isCapturing {
            isCapturing = true
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // This is the delegate's method that is called when a code is read
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let code = readableObject.stringValue
            
            print("canAddOutput 4")
            self.dismiss(animated: true, completion: nil)
            self.delegate?.barcodeReaded(barcode: code!)
            print(code!)
        }
    }
}


extension BarcodeVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        isCapturing = false
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error while generating image from photo capture data.");
            return
        }
        guard let qrImage = UIImage(data: imageData) else {
            print("Unable to generate UIImage from image data.");
            return
        }
        image.image = qrImage
     }
}

*/


import AVFoundation
import UIKit

class BarcodeVC: BaseVC, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addRightButton()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    
    
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 130, height: 40))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 5, width: 18, height: 30))
        button1.setImage(UIImage(named: "ic-Bag"), for: .normal)

        let lblBadge = UILabel.init(frame: CGRect.init(x: -12, y: 5, width: 15, height: 15))
        lblBadge.backgroundColor = .clear//"202124".color
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = "202124".color
        lblBadge.font = .systemFont(ofSize: 12)
        lblBadge.textAlignment = .center
        lblBadge.text = "12"
        button1.addSubview(lblBadge)
        
        
        button1.addTarget(self, action: #selector(didTapOnTicket), for: .touchUpInside)

     
        //22
        let button2 = UIButton(frame: CGRect(x: 22,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "ic-flash"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnFlash), for: .touchUpInside)
        
        let button3 = UIButton(frame: CGRect(x: 50,y: 8, width: 24, height: 24))
        button3.setImage(UIImage(named: "ic-camera-gray"), for: .normal)
        
   //     button3.addTarget(self, action: #selector(didTapOnList), for: .touchUpInside)
        
        
        let button4 = UIButton(frame: CGRect(x: 78,y: 8, width: 24, height: 24))
        button4.setImage(UIImage(named: "ic-Iconly-Bulk-Filter"), for: .normal)
        
    //    button4.addTarget(self, action: #selector(didTapOnList), for: .touchUpInside)
        
   
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        viewFN.addSubview(button3)
        viewFN.addSubview(button4)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton

   }
    
    
//    @objc func didTapOnList(){
//        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TopListVC") as! TopListVC
//      
//        vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//     
//        self.present(vc, animated: true, completion: nil)
//        
//    }
    
   
  
    
    
    var iconClick = true
    @objc func didTapOnFlash(){
        
        if(iconClick == true) {
            toggleTorch(on: true)
        } else {
            toggleTorch(on: false)
        }
        
        iconClick = !iconClick
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    
 

    
    @objc func didTapOnTicket(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TicketVC") as! TicketVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        self.navigationController?.popViewController(animated: true)

        dismiss(animated: true)
    }

    func found(code: String) {
        print("code \(code)")
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}



