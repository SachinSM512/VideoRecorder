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

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate  {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    @IBOutlet weak var addVideoBtn: UIButton!
    var imagePickerController = UIImagePickerController()

    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBAction func recordVideoBtnAction(_ sender: UIButton) {
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
        let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        if let descDataVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoDescriptionVCID") as? VideoDescriptionVC {
            descDataVC.videoUrl = videoURL
            navigationController?.pushViewController(descDataVC, animated: true)
        }
    }
}

