//
//  FirstViewController.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit
import SDWebImage

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .always
        setupSearchBar()
        fetchApiData()
    }
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    fileprivate var appResults = [Result]()
    var timer: Timer?
    let searchBarController = UISearchController(searchResultsController: nil)
    
    func setupSearchBar(){
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    }
    
    
    func fetchApiData(){
        
        Service.shared.fetchApps(searchTerm: "Jamaica") { searchResult, error in
            
            if error != nil{
                print("error")
            }
            self.appResults = searchResult
            DispatchQueue.main.async {
                //Reload CollectionView because user internet may be slow
                self.searchCollectionView.reloadData()
            }
        }
    }
}


//MARK: CollectionView Delegate Methods
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        return cell
    }
}


//MARK: SearchBar Delegate Methods
extension SearchVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //timer?.invalidate()//holds off on calling api for a bit
        
        //Add Timer to wait for the user to type more in searchbar text area
       // timer = Timer.init(timeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchApps(searchTerm: searchText) { (results, err) in
                self.appResults = results
                DispatchQueue.main.async {
                    self.searchCollectionView.reloadData()
                }
            }
        //})
    }
}
