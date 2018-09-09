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
    
    func display() {
        guard let url = albumCellModel.url else{
            return
        }
        
        imgView.setImage(from: url, placeHolder: #imageLiteral(resourceName: "noImageFound.jpg"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
    }
}
