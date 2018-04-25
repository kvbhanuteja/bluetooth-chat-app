//
//  BarCodeScannerViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 30/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit
import AVFoundation

class BarCodeScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    let session         : AVCaptureSession = AVCaptureSession()
    var previewLayer    : AVCaptureVideoPreviewLayer!
    var highlightView   : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow the view to resize freely
        self.highlightView.autoresizingMask =   [UIViewAutoresizing.flexibleBottomMargin , UIViewAutoresizing.flexibleHeight , UIViewAutoresizing.flexibleLeftMargin , UIViewAutoresizing.flexibleRightMargin , UIViewAutoresizing.flexibleTopMargin , UIViewAutoresizing.flexibleWidth]
        
        // Select the color you want for the completed scan reticle
//        self.highlightView.layer.borderColor = UIColor.green as? CGColor
        self.highlightView.layer.borderWidth = 3
        
        // Add it to our controller's view as a subview.
        self.view.addSubview(self.highlightView)
        
        
        // For the sake of discussion this is the camera
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        // Create a nilable NSError to hand off to the next method.
        // Make sure to use the "var" keyword and not "let"
        
        var input : AVCaptureDeviceInput? = nil
        do {
            input  = try AVCaptureDeviceInput(device: device)
        }catch {
            
        }
        
        // If our input is not nil then add it to the session, otherwise we're kind of done!
        if input != nil {
            session.addInput(input)
        }
        else {
            // This is fine for a demo, do something real with this in your app. :)
            
        }
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = self.view.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(previewLayer)
        
        // Start the scanner. You'll have to end it yourself later.
        session.startRunning()
        
    }
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
  
        var highlightViewRect = CGRect.zero
        
        var barCodeObject : AVMetadataObject!
        
        var detectionString : String!
        
        let barCodeTypes = [AVMetadataObjectTypeUPCECode,
                            AVMetadataObjectTypeCode39Code,
                            AVMetadataObjectTypeCode39Mod43Code,
                            AVMetadataObjectTypeCode93Code,
                            AVMetadataObjectTypeCode128Code,
                            AVMetadataObjectTypeEAN8Code,
                            AVMetadataObjectTypeEAN13Code,
                            AVMetadataObjectTypeAztecCode,
                            AVMetadataObjectTypePDF417Code,
                            AVMetadataObjectTypeQRCode        ]
        
        
        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan.
        for metadata in metadataObjects {
            
            for barcodeType in barCodeTypes {
                
                if (metadata as AnyObject).type == barcodeType {
                    barCodeObject = self.previewLayer.transformedMetadataObject(for: metadata as! AVMetadataMachineReadableCodeObject)
                    
                    highlightViewRect = barCodeObject.bounds
                    
                    detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                    
                    self.session.stopRunning()
                    
                    self.alert(Code: detectionString)
                    break
                }
                
            }
        }
        
        
        self.highlightView.frame = highlightViewRect
        self.view.bringSubview(toFront: self.highlightView)
        
    }
    
    
    
    func alert(Code: String){
        let url = URL(string: Code)!
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.navigationController?.popViewController(animated: true);
            }
        }else{
                let actionSheet:UIAlertController = UIAlertController(title: "Barcode", message: "\(Code)", preferredStyle: UIAlertControllerStyle.alert)
        
        // for alert add .Alert instead of .Action Sheet
        
        // start copy
        
        let firstAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            
            
            {
                (alertAction:UIAlertAction!) in
                // action when pressed
                
                self.session.startRunning()
                
        })
        
        actionSheet.addAction(firstAlertAction)
        
        // end copy
              self.present(actionSheet, animated: true, completion: nil)
//
        }
    }
}
