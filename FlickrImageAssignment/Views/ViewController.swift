//
//  ViewController.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gridView: UICollectionView!
    
    private var gridViewModel = GridViewModel(albumArray: Observer([AlbumModel]()))
    
    var service = FlickrPaginatedAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridViewModel.albumArray.bind {[unowned self] (_) in
            DispatchQueue.main.async {
                self.gridView.reloadData()
            }
        }
        
        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gridView.collectionViewLayout.invalidateLayout()
    }
    
    func fetch(){
        service.fetch { (result) in
            switch result{
            case .success(let modelArray):
                self.gridViewModel.add(from: modelArray)
            case .failure(let _):
                break
            }
        }
    }

}

extension ViewController : UICollectionViewDelegate{
    
}

extension ViewController :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return gridViewModel.albumArray.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        let albumModel = gridViewModel.albumArray.value[indexPath.row]
        albumCollectionViewCell.albumCellModel = AlbumCellViewModel(albumModel: albumModel)
        return albumCollectionViewCell
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = self.view.frame.size.width
        return CGSize(width: screenWidth/3 - 2, height: screenWidth/3 - 2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

