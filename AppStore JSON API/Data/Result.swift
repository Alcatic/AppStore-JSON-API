//
//  Result.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit

//FetchData
struct Result: Decodable{
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String //app icon
}

struct SearchResult: Decodable{
    let resultCount: Int
    let results: [Result]
}


//GetData
struct ApiResponse: Decodable{
    
    let feed:Feed
}

struct Feed: Decodable{
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable{
    let name:String
    let artistName: String
    let artworkUrl100: String
    
}
