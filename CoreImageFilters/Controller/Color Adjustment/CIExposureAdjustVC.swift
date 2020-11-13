//
//  CIExposureAdjustVC.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 13/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CIExposureAdjustVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
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
    
    let EVLabel:UILabel = {
        let l = UILabel()
        l.text = "EV"
        l.font = UIFont(name: "Avenir-Black", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let EVSlider:UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor(red: 51/255, green: 145/255, blue: 212/255, alpha: 1)
        s.minimumValue = 0
        s.maximumValue = 1
        s.value = 0.50
        s.addTarget(self, action: #selector(changeInEV), for: .valueChanged)
        return s
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewImage)
        view.backgroundColor = .white
        view.addSubview(EVSlider)
        view.addSubview(EVLabel)
        view.addSubview(pickImage)
        setUpConstraints()
        
        /// Setting radius slider to default value
        EVSlider.value = 10.0
        EVLabel.text = "Exposure Value: \(Int(EVSlider.value))"
        beginImage = CIImage(image: previewImage.image!)
        processing()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: view.frame.width * (4/5)),
            
            EVSlider.bottomAnchor.constraint(equalTo: pickImage.topAnchor, constant: -20),
            EVSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            EVSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            EVLabel.bottomAnchor.constraint(equalTo:    EVSlider.topAnchor, constant: -20),
            EVLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pickImage.widthAnchor.constraint(equalToConstant: 120),
            pickImage.heightAnchor.constraint(equalToConstant: 50),
            pickImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func processing(){
        let filter = CIFilter.addExposureAdjust(inputImage: beginImage!, inputEV: NSNumber(value:EVSlider.value))
        let output = filter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processImage = UIImage(cgImage: cgimg!)
        previewImage.image = processImage
    }
    
    
    /// On changin the value of slider input radius of filter changes
    @objc func changeInEV(_ :UISlider){
        EVLabel.text = "Exposure Value: \(Double(EVSlider.value).uptoDecimal)"
        processing()
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
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            self.previewImage.image = selectedImage
            beginImage = CIImage(image: selectedImage)
            processing()
            EVSlider.value = 0
        }
        dismiss(animated: true, completion: nil)
    }

}
