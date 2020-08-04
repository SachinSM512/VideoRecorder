//
//  ViewController.swift
//  VideoRecorderApp
//
//  Created by Test_MB1 on 01/08/20.
//  Copyright © 2020 Test_MB1. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import AVFoundation
import MediaPlayer
import AudioToolbox

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, AVPlayerViewControllerDelegate  {

    @IBOutlet weak var videoColectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var videoDataList: [VideoData] = []
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // dummy data
        videoDataList.append(VideoData())
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func configureUI() {
        editProfileBtn.makeRoundCornerButton()
        messageBtn.makeRoundCornerButton()
        scheduleBtn.makeRoundCornerButton()
    }
    
    //MARK:- Record Button Action

    func recordVideoBtnAction() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            print("Camera Available")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera UnAvaialable")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        if let descDataVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoDescriptionVCID") as? VideoDescriptionVC {
            descDataVC.videoUrl = videoURL
            descDataVC.delegate = self
            navigationController?.pushViewController(descDataVC, animated: true)
        }
    }

    //MARK:- Video Play Action

    private func playVideo(videoData: VideoData) {
        if let url  = videoData.videoUrl {
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

extension ViewController: VideoDetailsDelegate {
    
    func videoDetails(videoData: VideoData) {
        videoDataList.append(videoData)
        videoColectionView.reloadData()
    }
}

//MARK:- collection view delegate and datasouce methods

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
        let data = videoDataList[indexPath.item]
        cell.configureCellData(videoData: data, indexPath: indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = videoDataList[indexPath.item]
        if indexPath.item == 0 {
            recordVideoBtnAction()
        } else {
            playVideo(videoData: data)
        }
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 3
        print("cell width : \(width)")
        return CGSize(width: width, height: width + 10)
    }
}
