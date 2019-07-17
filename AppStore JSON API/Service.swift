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
    
    func fetchApps(completion:@escaping ([Result], Error?)->()){
        
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}
