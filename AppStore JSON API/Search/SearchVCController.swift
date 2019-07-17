//
//  FirstViewController.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchApiData()
    }
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    fileprivate var appResults = [Result]()
    
    

    func fetchApiData(){
        
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            if let error = error{
                print("error in getting data \(error)")
            }
            guard let data = data else{return}
            
            do{
                
                //Convert JSON received based on the Data Model you provide(SearchResult.self)
            let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
            self.appResults = searchResult.results
                DispatchQueue.main.async {
                   //Reload CollectionView because user internet may be slow
                    self.searchCollectionView.reloadData()
                }
            }catch{
                print("in catch block -> \(error)")
            }
        }.resume()
    }
}




extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
