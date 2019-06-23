//
//  GnosisQRScanner.swift
//  GnosisQR
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class GnosisQRScanner: UIView, AVCaptureMetadataOutputObjectsDelegate {

    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    var delegate: GnosisQRScannerDelegate?
    
     init(frame: CGRect, delegate: GnosisQRScannerDelegate?) {
        super.init(frame: frame)
        self.delegate = delegate
        self.startSession()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startSession()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startSession()
    }
    
    private func startSession() {
        setupCaptureSession()
        
        setupVideoPreviewLayer()
        
        startScanning()
    }
    
    //MARK: - Private Methods
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        setupCaptureInput(for: captureSession!)
        setupCaptureOutput(for: captureSession!)
    }

    private func setupCaptureInput(for session: AVCaptureSession) {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.scanner(self, didFail: GnosisQRScannerError.deviceInitilizationFailed)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do { videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice) }
        catch {
            delegate?.scanner(self, didFail: error)
            return
        }
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            delegate?.scanner(self, didFail: GnosisQRScannerError.videoSupportFailed)
            return
        }
    }
    
    private func setupCaptureOutput(for session: AVCaptureSession) {
        #if targetEnvironment(simulator)
            delegate?.scanner(self, didFail: GnosisQRScannerError.videoSupportFailed)
        #else
        let metadataOutput = AVCaptureMetadataOutput()
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            delegate?.scanner(self, didFail: GnosisQRScannerError.videoSupportFailed)
            return
        }
        #endif
    }
    
    private func setupVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        //videoPreviewLayer!.frame = view.layer.bounds
        videoPreviewLayer!.frame = self.bounds
        videoPreviewLayer!.videoGravity = .resizeAspectFill
        //view.layer.addSublayer(videoPreviewLayer!)
        self.layer.addSublayer(videoPreviewLayer!)
    }
    
    private func startScanning() {
        captureSession!.startRunning()
    }
    
    //MARK: - MetadataObjectsDelegate Methods

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession!.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            
            guard let result = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            delegate?.scanner(self, didScan: result)
        }
    }
}
