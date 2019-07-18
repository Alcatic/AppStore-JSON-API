//
//  Service.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import Foundation

class Service{
    
    //Create Singleton
    static let shared = Service()
    
    //SearchTerm is the text typed in the searchBar by user
    func fetchApps(searchTerm: String,completion:@escaping ([Result], Error?)->()){
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error{
                print("error in getting data \(error)")
                completion([],nil)
            }
            
            guard let data = data else{return}
            do{
                
                //Convert JSON received based on the Data Model you provide(SearchResult.self)
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                //Do something after being called
                completion(searchResult.results, nil)
                
            }catch{
                //What to pass back if an error here is received
                completion([],error)
                print("in catch block -> \(error)")
            }
            }.resume()
    }
    
    
    func fetchData(completion:@escaping (ApiResponse?,Error?)->() ){
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if err != nil{
                completion(nil, err)
                print(err?.localizedDescription)
            }
            
            guard let data = data else{return}
            
            do{
                let jsonData = try JSONDecoder().decode(ApiResponse.self, from: data)
                completion(jsonData, nil)
            }catch{
                completion(nil, error)
                print("Failed to decode jsonData check a key name or sumn")
            }
            
        }.resume()
    }
}
