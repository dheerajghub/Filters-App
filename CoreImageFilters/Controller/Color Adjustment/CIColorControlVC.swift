//
//  CIColorControlVC.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 13/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CIColorControlVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    let saturationLabel:UILabel = {
        let l = UILabel()
        l.text = "Saturation"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let saturationSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 1
        s.value = 1
        s.addTarget(self, action: #selector(changeInSaturation), for: .valueChanged)
        return s
    }()
    
    let brightnessLabel:UILabel = {
        let l = UILabel()
        l.text = "Brightness"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let brightnessSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 1
        s.value = 0
        s.addTarget(self, action: #selector(changeInBrightness), for: .valueChanged)
        return s
    }()
    
    let contrastLabel:UILabel = {
        let l = UILabel()
        l.text = "contrast"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let contrastSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 1
        s.value = 1
        s.addTarget(self, action: #selector(changeInContrast), for: .valueChanged)
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewImage)
        view.backgroundColor = .white
        view.addSubview(pickImage)
        view.addSubview(saturationLabel)
        view.addSubview(saturationSlider)
        view.addSubview(brightnessLabel)
        view.addSubview(brightnessSlider)
        view.addSubview(contrastLabel)
        view.addSubview(contrastSlider)
        setUpConstraints()
        
        self.saturationLabel.text = "Saturation: \(Int(saturationSlider.value))"
        self.contrastLabel.text = "Contrast: \(Int(contrastSlider.value))"
        self.brightnessLabel.text = "Brightness: \(Int(brightnessSlider.value))"
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
            
            saturationSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saturationSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saturationSlider.bottomAnchor.constraint(equalTo: pickImage.topAnchor, constant: -20),
            
            saturationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saturationLabel.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -8),
            
            brightnessSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            brightnessSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            brightnessSlider.bottomAnchor.constraint(equalTo: saturationLabel.topAnchor, constant: -20),
            
            brightnessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brightnessLabel.bottomAnchor.constraint(equalTo: brightnessSlider.topAnchor, constant: -8),
            
            contrastSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contrastSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contrastSlider.bottomAnchor.constraint(equalTo: brightnessLabel.topAnchor, constant: -20),
            
            contrastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contrastLabel.bottomAnchor.constraint(equalTo: contrastSlider.topAnchor, constant: -8)
        ])
    }
    
    func processing(){
        let filter = CIFilter.addColorControls(inputImage: beginImage!, inputBrightness:NSNumber(value: brightnessSlider.value), inputSaturation: NSNumber(value: saturationSlider.value), inputContrast: NSNumber(value: contrastSlider.value))
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
    
    @objc func changeInContrast(){
        self.contrastLabel.text = "Contrast: \(Double(contrastSlider.value).uptoDecimal)"
        processing()
    }
    
    @objc func changeInBrightness(){
        self.brightnessLabel.text = "Brightness: \(Double(brightnessSlider.value).uptoDecimal)"
        processing()
    }
    
    @objc func changeInSaturation(){
        self.saturationLabel.text = "Saturation: \(Double(saturationSlider.value).uptoDecimal)"
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

