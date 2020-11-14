//
//  DataViewController.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 09/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    var categories:[Categories]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = [
            Categories(title: "Blur", numberOfCategories: "7", subComponents: [
                SubCategoryFilter(title: "CIBoxBlur", description: "Blurs an image using a box-shaped convolution kernel.", navigateTo: CIBoxBlurVC()),
                SubCategoryFilter(title: "CIDiscBlur", description: "Blurs an image using a disc-shaped convolution kernel.", navigateTo: CIDiscBlurVC()),
                SubCategoryFilter(title: "CIGuassianBlur", description: "Spreads source pixels by an amount specified by a Gaussian distribution.", navigateTo: CIGaussianBlurVC()),
                SubCategoryFilter(title: "CIMedianFilter", description: "It reduce the noise from input image.", navigateTo: CIMedianFilterVC()),
                SubCategoryFilter(title: "CIMotionBlur", description: "Blurs an image to simulate the effect of using a camera that moves a specified angle and distance while capturing the image.", navigateTo: CIMotionBlurVC()),
                SubCategoryFilter(title: "CINoiseReduction", description: "Reduce noise by chaging luminance of small scale and treat noise by adding local blur.", navigateTo: CINoiseReductionVC()),
                SubCategoryFilter(title: "CIZoomBlur", description: "Simulates the effect of zooming the camera while capturing the image.", navigateTo: CIZoomBlurVC())
            ]),
            Categories(title: "Color Adjustment", numberOfCategories: "5", subComponents: [
                SubCategoryFilter(title: "CIColorClamp", description: "This filter modifies the color values and keep them in specific range.", navigateTo: CIColorClampVC()),
                SubCategoryFilter(title: "CIColorControl", description: "Adjusts saturation, brightness, and contrast values.", navigateTo: CIColorControlVC()),
                SubCategoryFilter(title: "CIColorPolynomial", description: "Modifies the pixel values in an image by applying a set of cubic polynomials.", navigateTo: CIColorPolynomialVC()),
                SubCategoryFilter(title: "CIExposureAdjust", description: "Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.", navigateTo: CIExposureAdjustVC()),
                SubCategoryFilter(title: "CIGammaAdjust", description: "It adjusts midtone brightness.", navigateTo: CIGammaAdjustVC()),
                SubCategoryFilter(title: "CIHueAdjust", description: "Changes the overall hue, or tint, of the source pixels.", navigateTo: CIHueAdjustVC()),
                SubCategoryFilter(title: "CILinearToSRGBToneCurve", description: "Maps color intensity from a linear gamma curve to the sRGB color space.", navigateTo: CILinearToSRGBToneCurveVC()),
                SubCategoryFilter(title: "CIVibrance", description: "Adjusts the saturation of an image while keeping pleasing skin tones.", navigateTo: CIVibranceVC())
            ])
        ]
    }

}
