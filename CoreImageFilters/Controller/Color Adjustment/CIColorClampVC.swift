//
//  CIColorClampVC.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 11/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class CIColorClampVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var beginImage:CIImage?
    var context = CIContext(options: [.workingColorSpace: NSNull(), .outputColorSpace: NSNull()])
    var originalImage:UIImage?
    
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
    
    let filterSwitch:UISwitch = {
        let s = UISwitch()
        s.isOn = true
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(self, action: #selector(filterSwitchPressed), for: .touchUpInside)
        return s
    }()
    
    let switchLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "filter ON"
        l.font = UIFont(name: "Avenir-Black", size: 16)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewImage)
        view.backgroundColor = .white
        view.addSubview(pickImage)
        view.addSubview(filterSwitch)
        view.addSubview(switchLabel)
        setUpConstraints()
        
        originalImage = UIImage(named: "demo")
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
            
            filterSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterSwitch.bottomAnchor.constraint(equalTo: switchLabel.topAnchor, constant: -10),
            
            switchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchLabel.bottomAnchor.constraint(equalTo: pickImage.topAnchor, constant: -30)
            
        ])
    }
    
    func processing(){
        let filter = CIFilter.addColorClamp(inputImage: beginImage!)
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
    
    @objc func filterSwitchPressed(){
        if filterSwitch.isOn {
            processing()
            self.switchLabel.text = "filter ON"
        } else {
            self.switchLabel.text = "filter OFF"
            self.previewImage.image = originalImage
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            self.previewImage.image = selectedImage.fixOrientation()
            self.originalImage? = selectedImage.fixOrientation()
            beginImage = CIImage(image: selectedImage)
            processing()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
