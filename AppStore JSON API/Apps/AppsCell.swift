//
//  AppsCell.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/17/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit

class AppsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var theInsideCollectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        getData()
    }
    
    //var results: ApiResponse?
    var resultsList = [ApiResponse]()
    
    
    
    func getData(){
        
        Service.shared.fetchMusic { (apiResults,error) in
            
            if error != nil{
                print("error in getData")
            }
            
            guard let apiResults = apiResults else{fatalError("Failed to get API Results")}
            
            //self.results = apiResults
            self.resultsList.append(apiResults)
            DispatchQueue.main.async {
                
                self.theInsideCollectionView.reloadData()
            }
        }
        
        Service.shared.fetchData { (apiResults, error) in
            
            if error != nil{
                print("error in getData")
            }
            
            guard let apiResults = apiResults else{fatalError("Failed to get API Results")}
            
            //self.results = apiResults
            self.resultsList.append(apiResults)
            DispatchQueue.main.async {
                
                self.theInsideCollectionView.reloadData()
            }
        }
    }
     
}

extension AppsCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return resultsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "insideCollectionCell", for: indexPath) as! InsideAppsCollectionCell
        
        let apiGroup = resultsList[indexPath.row]
        var appImageUrlString = apiGroup.feed.results[indexPath.row].artworkUrl100
        cell.appName.text = apiGroup.feed.results[indexPath.row].name
        cell.appImage.sd_setImage(with: URL(string: appImageUrlString ?? ""), completed: nil)
        cell.appCategory.text = apiGroup.feed.results[indexPath.row].artistName
        
        return cell
    }
    
    
}
