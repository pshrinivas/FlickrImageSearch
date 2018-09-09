//
//  AlbumCollectionViewCell.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import UIKit
import Foundation

class AlbumCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    
    var albumCellModel : AlbumCellViewModel!{
        didSet{
            display()
        }
    }
    
    var fetcher : ImageFetcher!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fetcher = ImageFetcher()
    }
    
    func display() {
        guard let url = albumCellModel.url else{
            return
        }
        
        fetcher.setImage(url: url, imageView: imgView, placeHolder: #imageLiteral(resourceName: "placeholder.png"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
        fetcher.cancel()
        fetcher = ImageFetcher()
    }
}
