//
//  VideoDescriptionVC.swift
//  VideoRecorderApp
//
//  Created by Enst_MB1 on 02/08/20.
//  Copyright © 2020 Test_MB1. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AudioToolbox

protocol VideoDetailsDelegate {
    func videoDetails(videoData: VideoData)
}


class VideoDescriptionVC: UIViewController, UITextFieldDelegate, AVPlayerViewControllerDelegate {
    @IBOutlet weak var videoPreviewImageView: UIImageView!
    @IBOutlet weak var videoTitleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var addTagsTF: UITextField!
    
    @IBOutlet weak var tagBtn1: UIButton!
    @IBOutlet weak var tagBtn2: UIButton!
    @IBOutlet weak var tagBtn3: UIButton!
    @IBOutlet weak var tagBtn4: UIButton!
    var delegate : VideoDetailsDelegate?
    var videoUrl: URL?
    var tagText = ""
    var videoTitle: String = ""
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "UPLOAD VIDEO"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- UI Configure 

    private func configureUI() {
        videoTitleTF.makeRoundCornerTextfield()
        descriptionTF.makeRoundCornerTextfield()
        addTagsTF.makeRoundCornerTextfield()
        
        // buttons
        tagBtn1.makeRoundCornerButtonWithoutBorder()
        tagBtn2.makeRoundCornerButtonWithoutBorder()
        tagBtn3.makeRoundCornerButtonWithoutBorder()
        tagBtn4.makeRoundCornerButtonWithoutBorder()
        
        if let url = videoUrl, let previwImage = Utils.imageFromVideo(url: url, at: 5) {
        videoPreviewImageView.image = previwImage
            videoPreviewImageView.layer.cornerRadius = 10
            videoPreviewImageView.layer.masksToBounds = true
        }
    }

    //MARK:- UITextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        videoTitle = videoTitleTF.text!
        self.view.endEditing(true)
        return true
    }

    //MARK:- UIButton Action

    @IBAction func doneButtonAction(_ sender: UIButton) {
        
//        let alert = UIAlertController(title: "Title", message: "Video Added Succesfully", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
         let videoDetails = VideoData()
        videoDetails.title = videoTitle
        videoDetails.videoUrl = videoUrl
        delegate?.videoDetails(videoData: videoDetails)
        navigationController?.popToRootViewController(animated: true)

        //let imageData = Data(contentsOf: videoUrl!) // video data for uploading to server
    }
    
    @IBAction func tag1btn(_ sender: UIButton) {
        sender.isEnabled = !sender.isEnabled
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.isEnabled = true
        }
        tagText +=  (sender.currentTitle ?? "") + ", "
        addTagsTF.text = tagText
    }

    @IBAction func videoPreviwButtonAction(_ sender: UIButton) {
        playVideo()
    }
    
    //MARK:- Video Play Action

       private func playVideo() {
           if let url  = videoUrl {
               let player = AVPlayer(url: url)
               let playervc = AVPlayerViewController()
               playervc.delegate = self
               playervc.player = player
               present(playervc, animated: true) {
                   playervc.player!.play()
               }
           }
       }
}

