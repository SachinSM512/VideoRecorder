//
//  CollectionViewCell.swift
//  VideoRecorderApp
//
//  Created by Enst_MB1 on 04/08/20.
//  Copyright © 2020 Enst_MB1. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!

    func configureCellData(videoData: VideoData, indexPath: IndexPath) {
        if indexPath.item == 0 { // for add button cell
            titleLabel.isHidden = true
            videoImageView.image = #imageLiteral(resourceName: "upload_video-50")
            videoImageView.contentMode = .center
        } else {
            titleLabel.isHidden = false
            titleLabel.text = videoData.title
            if let url = videoData.videoUrl, let previwImage = Utils.imageFromVideo(url: url, at: 5) {
            videoImageView.image = previwImage
                videoImageView.contentMode = .scaleAspectFit
            }
        }
        videoImageView.makeRoundCornerImageView()
    }
}
