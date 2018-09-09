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
    
    @IBOutlet weak var searchTextField: UITextField!
    
    private var gridViewModel = GridViewModel(albumArray: Observer([AlbumModel]()))
    private var service = FlickrPaginatedAPIService()
    
    // some query by default
    private var searchQuery = "kitten"
    
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let _refreshControl = UIRefreshControl()
        _refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return _refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridView.refreshControl = refreshControl
        
        // Maintaining searchQuery in box
        searchTextField.text = searchQuery
        
        gridViewModel.albumArray.bind {[unowned self] (_) in
            DispatchQueue.main.async {
                self.gridView.reloadData()
            }
        }
        
        fetch()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gridView.collectionViewLayout.invalidateLayout()
    }
    
    func fetch(){
        
        gridView.refreshControl?.beginRefreshing()
        
        service.fetch(searchKeyWord: searchQuery) {[weak self] (result) in
            
            guard let `self` = self else{
                return
            }
            
            switch result{
            case .success(let modelArray):
                self.gridViewModel.add(from: modelArray)
            case .failure(_):
                break
            }
            DispatchQueue.main.async {
                self.gridView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func refresh(){
        gridViewModel.clearAll()
        service = FlickrPaginatedAPIService()
        fetch()
    }
    
    @IBAction func search(_ sender: Any) {
        
        searchTextField.resignFirstResponder()
        
        if let newSearchText = searchTextField.text,
            newSearchText.trimmingCharacters(in: [" "]) != ""{
            searchQuery = newSearchText
            refresh()
        }
        else{
            let alert = UIAlertController(title: "Invalid String", message: "string Cannot be blank", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                self.searchTextField.text = self.searchQuery
            }
            alert.addAction(cancel)
            present(alert, animated: false, completion: nil)

        }
    }
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        if indexPath.row > gridViewModel.albumArray.value.count - 15{
            fetch()
        }
    }
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

