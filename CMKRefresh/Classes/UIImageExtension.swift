//
//  UIImageExtension.swift
//  Pods
//
//  Created by Gesantung on 2017/5/3.
//
//

import UIKit
import ImageIO

extension UIImage {
    
    class func animatedImgWithSource(_ source: CGImageSource) -> [UIImage] {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
        }
        
        return images.flatMap { (image:CGImage) -> UIImage? in
            return UIImage.init(cgImage: image)
        }
    }
    
    class func gifImgWithName(_ name: String) -> [UIImage] {
        guard let bundleURL = Bundle.init(for: CMRefreshDefultHeader.self).url(forResource: name, withExtension: "gif") else {
            return []
        }
        
        // Validate data
        guard let imageData = try? Data.init(contentsOf: bundleURL) else {
            return []
        }
        
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            return []
        }
        
        return UIImage.animatedImgWithSource(source)
    }
}
