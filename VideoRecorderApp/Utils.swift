//
//  Utils.swift
//  VideoRecorderApp
//
//  Created by Enst_MB1 on 02/08/20.
//  Copyright © 2020 Enst_MB1. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AudioToolbox

class Utils {
    class func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
        let asset = AVURLAsset(url: url)

        let assetIG = AVAssetImageGenerator(asset: asset)
        assetIG.appliesPreferredTrackTransform = true
        assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

        let cmTime = CMTime(seconds: time, preferredTimescale: 5)
        let thumbnailImageRef: CGImage
        do {
            thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
        } catch let error {
            print("Error: \(error)")
            return nil
        }

        return UIImage(cgImage: thumbnailImageRef)
    }
}

extension UIButton {
    
    func makeRoundCornerButton() {
        layer.cornerRadius = frame.height * 0.5
        layer.masksToBounds = true
        layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.1725490196, blue: 0.1411764706, alpha: 1)
        layer.borderWidth = 2
    }

    func makeRoundCornerButtonWithoutBorder() {
        layer.cornerRadius = frame.height * 0.5
        layer.masksToBounds = true
    }
}

extension UITextField {
    
    func makeRoundCornerTextfield() {
        layer.cornerRadius = 7
        layer.masksToBounds = true
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1
    }
}

extension UIImageView {
    
    func makeRoundCornerImageView() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
