//
//  ImageDownloader.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageFetcher{
    
    private var task : URLSessionDataTask?
    
    func cancel(){
        task?.cancel()
    }
    
    func setImage(url : URL, imageView : UIImageView, placeHolder : UIImage? = nil) {
        
        imageView.image = placeHolder
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            imageView.image = cachedImage
            return
        }
        
        task = URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
            
            guard let strongSelf = self else{
                return
            }
            
            if error != nil {
                print("Error while downloading from URL: \(String(describing: error))")
                DispatchQueue.main.async {
                    imageView.image = placeHolder
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                        imageView.image = downloadedImage
                    }
                }
            }
        })
        
        task?.resume()
    }
}
