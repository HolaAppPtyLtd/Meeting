//
//  ViewController.swift
//  Meeting
//
//  Created by YING CHEN on 1/11/18.
//  Copyright © 2018 YING CHEN. All rights reserved.
//

import UIKit

// [START import_vision]
import Firebase
// [END import_vision]

class ViewController: UIViewController {

    /// Firebase vision instance.
    // [START init_vision]
    lazy var vision = Vision.vision()
    // [END init_vision]
    
    /// A string holding current results from detection.
    var resultsText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detectBarcodes(image: #imageLiteral(resourceName: "barcode_128.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// Detects barcodes on the specified image and draws a frame around the detected barcodes using
    /// On-Device barcode API.
    ///
    /// - Parameter image: The image.
    func detectBarcodes(image: UIImage?) {
        guard let image = image else { return }
        
        // Define the options for a barcode detector.
        // [START config_barcode]
        let format = VisionBarcodeFormat.all
        let barcodeOptions = VisionBarcodeDetectorOptions(formats: format)
        // [END config_barcode]
        // Create a barcode detector.
        // [START init_barcode]
        let barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
        // [END init_barcode]
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START detect_barcodes]
        barcodeDetector.detect(in: visionImage) { features, error in
            guard error == nil, let features = features, !features.isEmpty else {
                // [START_EXCLUDE]
                print(error ?? "Error")
                return
            }
            
            // [START_EXCLUDE]
            self.resultsText = features.map { feature in
                    return "\(feature.displayValue ?? "")"
                }.joined(separator: "\n")
            // [END_EXCLUDE]

            print(self.resultsText )
            
        }
        // [END detect_barcodes]
    }
}

