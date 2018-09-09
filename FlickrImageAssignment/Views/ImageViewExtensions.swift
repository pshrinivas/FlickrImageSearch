//
//  ImageViewExtensions.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImage(from url: URL, placeHolder: UIImage?) {
        
        self.image = placeHolder
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
                
                if error != nil {
                    print("Error while downloading from URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self?.image = placeHolder
                    }
                    return
                }
            
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                            self?.image = downloadedImage
                        }
                    }
                }
            }).resume()
    }
}
