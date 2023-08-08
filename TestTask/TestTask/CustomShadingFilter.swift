//
//  CustomShadingFilter.swift
//  TestTask
//
//  Created by Александр on 08.08.2023.
//

import CoreImage

internal class CustomShadingFilter: CIFilter {
    internal var inputImage: CIImage?
    internal var glowIntensity: Double = 0.0
    
    private lazy var kernel: CIKernel? = {
        return CIColorKernel(source:
        """
            kernel vec4 increaseGlow(__sample image, float glowIntensity) {
                vec3 resultColor = image.rgb + vec3(glowIntensity);
                return vec4(resultColor, image.a);
            }
        """
        )
    }()
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage, let kernel = kernel else { return nil }
        return kernel.apply(extent: inputImage.extent, roiCallback: { (_, rect) in rect }, arguments: [inputImage, CGFloat(glowIntensity)])
    }
}

