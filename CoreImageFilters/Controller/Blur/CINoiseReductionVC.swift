//
//  CINoiseReductionVC.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 11/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CINoiseReductionVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var beginImage:CIImage?
    var context = CIContext(options:nil)
    
    let previewImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "demo")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let pickImage:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(white: 0, alpha: 0.1)
        btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        btn.layer.cornerRadius = 25
        btn.setTitle("Pick Image", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(pickerImage), for: .touchUpInside)
        return btn
    }()
    
    let noiseLevelLabel:UILabel = {
        let l = UILabel()
        l.text = "NoiseLevel"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let noiseLevelSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 1
        s.addTarget(self, action: #selector(changeInRadius), for: .valueChanged)
        return s
    }()
    
    let sharpnessLabel:UILabel = {
        let l = UILabel()
        l.text = "Sharpness"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let sharpnessSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 100
        s.addTarget(self, action: #selector(changeInAngle), for: .valueChanged)
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewImage)
        view.backgroundColor = .white
        view.addSubview(pickImage)
        view.addSubview(noiseLevelLabel)
        view.addSubview(noiseLevelSlider)
        view.addSubview(sharpnessLabel)
        view.addSubview(sharpnessSlider)
        setUpConstraints()
        
        self.noiseLevelLabel.text = "NoiseLevel: \(Int(noiseLevelSlider.value))"
        self.sharpnessLabel.text = "Sharpness: \(Int(sharpnessSlider.value))"
        beginImage = CIImage(image: previewImage.image!)
        processing()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: view.frame.width * (4/5)),
            
            pickImage.widthAnchor.constraint(equalToConstant: 120),
            pickImage.heightAnchor.constraint(equalToConstant: 50),
            pickImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            noiseLevelSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noiseLevelSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noiseLevelSlider.bottomAnchor.constraint(equalTo: pickImage.topAnchor, constant: -20),
            
            noiseLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noiseLevelLabel.bottomAnchor.constraint(equalTo: noiseLevelSlider.topAnchor, constant: -8),
            
            sharpnessSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sharpnessSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sharpnessSlider.bottomAnchor.constraint(equalTo: noiseLevelLabel.topAnchor, constant: -20),
            
            sharpnessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sharpnessLabel.bottomAnchor.constraint(equalTo: sharpnessSlider.topAnchor, constant: -8)
        ])
    }
    
    func processing(){
        let filter = CIFilter.addNoiseReduction(inputImage: beginImage!, inputNoiseLevel: NSNumber(value: noiseLevelSlider.value), inputSharpness: NSNumber(value:sharpnessSlider.value))
        let output = filter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processImage = UIImage(cgImage: cgimg!)
        previewImage.image = processImage
    }
    
    @objc func pickerImage(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takephoto = UIAlertAction(title: "Take Photo", style: .default , handler: { (action) -> Void in
            let controller = UIImagePickerController()
            controller.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                controller.sourceType = .camera
            } else {
                controller.sourceType = .photoLibrary
            }
            self.present(controller , animated: true , completion: nil)
        })
        
        let Browse = UIAlertAction(title: "Browse", style:.default , handler: { (action) -> Void in
            let controller = UIImagePickerController()
            controller.delegate = self
            self.present(controller , animated: true , completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(takephoto)
        optionMenu.addAction(Browse)
        optionMenu.addAction(cancelAction)
        
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func changeInAngle(){
        self.sharpnessLabel.text = "Sharpness: \(Int(sharpnessSlider.value))"
        processing()
    }
    
    @objc func changeInRadius(){
        self.noiseLevelLabel.text = "NoiseLevel: \(Float(noiseLevelSlider.value))"
        processing()
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            self.previewImage.image = selectedImage.fixOrientation()
            beginImage = CIImage(image: selectedImage)
            processing()
        }
        dismiss(animated: true, completion: nil)
    }
    
}

