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
        fetchApiData()
    }
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    fileprivate var appResults = [Result]()
    
    

    func fetchApiData(){
        
        Service.shared.fetchApps { searchResult, error in
            
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
