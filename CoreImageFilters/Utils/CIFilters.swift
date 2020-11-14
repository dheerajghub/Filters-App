//
//  CIFilters.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 11/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

extension CIFilter  {
    
    static func addBoxBlur(inputImage:CIImage, inputRadius:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIBoxBlur") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputRadius, forKey: kCIInputRadiusKey)
        return filter
    }
    
    static func addDiscBlur(inputImage:CIImage, inputRadius:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIDiscBlur") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputRadius, forKey: kCIInputRadiusKey)
        return filter
    }
    
    static func addGaussianBlur(inputImage:CIImage, inputRadius:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputRadius, forKey: kCIInputRadiusKey)
        return filter
    }
    
    static func addMedianFilter(inputImage:CIImage) -> CIFilter?{
        guard let filter = CIFilter(name: "CIMedianFilter") else {
            return nil
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        return filter
    }
    
    static func addMotionBlur(inputImage:CIImage, inputRadius:NSNumber, inputAngle:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIMotionBlur") else {
            return nil
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputRadius, forKey: kCIInputRadiusKey)
        filter.setValue(inputAngle, forKey: kCIInputAngleKey)
        return filter
    }
    
    static func addNoiseReduction(inputImage:CIImage, inputNoiseLevel:NSNumber = 0.02, inputSharpness:NSNumber = 0.4) -> CIFilter? {
        guard let filter = CIFilter(name: "CINoiseReduction") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputNoiseLevel, forKey: "inputNoiseLevel")
        filter.setValue(inputSharpness, forKey: kCIInputSharpnessKey)
        return filter
    }
    
    static func addZoomBlur(inputImage:CIImage, inputAmount:NSNumber = 20.0, inputCenter:CIVector = CIVector(x: 150.0, y: 150.0)) -> CIFilter? {
        guard let filter = CIFilter(name: "CIZoomBlur") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputCenter, forKey: kCIInputCenterKey)
        filter.setValue(inputAmount, forKey: "inputAmount")
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        return filter
    }
    
    static func addColorClamp(inputImage:CIImage, inputMinComponents:CIVector = CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), inputMaxComponents:CIVector = CIVector(x: 1.0, y: 1.0, z: 1.0, w: 1.0)) -> CIFilter? {
        guard let filter = CIFilter(name: "CIColorClamp") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputMinComponents, forKey: "inputMinComponents")
        filter.setValue(inputMaxComponents, forKey: "inputMaxComponents")
        return filter
    }
    
    static func addColorControls(inputImage:CIImage, inputBrightness:NSNumber = 0, inputSaturation:NSNumber = 1, inputContrast:NSNumber = 1) -> CIFilter? {
        guard let filter = CIFilter(name: "CIColorControls") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputContrast, forKey: kCIInputContrastKey)
        filter.setValue(inputBrightness, forKey: kCIInputBrightnessKey)
        filter.setValue(inputSaturation, forKey: "inputSaturation")
        return filter
    }
    
    static func addColorPolynomial(inputImage:CIImage, inputRedCoefficients:CIVector = CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.4), inputGreenCoefficients:CIVector = CIVector(x: 0.0, y: 0.0, z: 0.5, w: 0.8), inputBlueCoefficients:CIVector = CIVector(x: 0.0, y: 0.0, z: 0.5, w: 1.0), inputAlphaCoefficients:CIVector = CIVector(x: 0.0, y: 1.0, z: 1.0, w: 1.0)) -> CIFilter? {
        guard let filter = CIFilter(name: "CIColorPolynomial") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputRedCoefficients, forKey: "inputRedCoefficients")
        filter.setValue(inputGreenCoefficients, forKey: "inputGreenCoefficients")
        filter.setValue(inputBlueCoefficients, forKey: "inputBlueCoefficients")
        filter.setValue(inputAlphaCoefficients, forKey: "inputAlphaCoefficients")
        return filter
    }
    
    static func addExposureAdjust(inputImage:CIImage, inputEV:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIExposureAdjust") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputEV, forKey: kCIInputEVKey)
        return filter
    }
    
    static func addGammaAdjust(inputImage:CIImage, inputPower:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIGammaAdjust") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputPower, forKey: "inputPower")
        return filter
    }
    
    static func addHueAdjust(inputImage:CIImage, inputAngle:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIHueAdjust") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputAngle, forKey: "inputAngle")
        return filter
    }
    
    static func addLinearToSRGBToneCurve(inputImage:CIImage) -> CIFilter? {
        guard let filter = CIFilter(name: "CILinearToSRGBToneCurve") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        return filter
    }
    
    static func addVibrance(inputImage:CIImage, inputAmount:NSNumber) -> CIFilter? {
        guard let filter = CIFilter(name: "CIVibrance") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(inputAmount, forKey: kCIInputAmountKey)
        return filter
    }
}
