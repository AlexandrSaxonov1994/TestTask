//
//  ContentView.swift
//  TestTask
//
//  Created by Александр on 08.08.2023.
//

import SwiftUI
import CoreImage

struct ContentView: View {
    @State private var celsius: Double = 0
    private let inputImage = "Photo"
    
    var body: some View {
        VStack {
            if let shadedImage = applyShadingEffect() {
                shadedImage
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Error applying shading effect")
            }
            Text("Intensity \(celsius, specifier: "%.1f")")
            Slider(value: $celsius, in: 0...100)
        }
        .padding()
    }
    
    private func applyShadingEffect() -> Image? {
        let inputImage = UIImage(named: self.inputImage)
        let shadingFilter = CustomShadingFilter()
        shadingFilter.inputImage = CIImage(image: inputImage ?? UIImage())
        shadingFilter.glowIntensity = celsius / 5000
        if let outputImage = shadingFilter.outputImage,
           let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            return Image(uiImage: uiImage)
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
