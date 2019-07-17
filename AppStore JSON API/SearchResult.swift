//
//  SearchResult.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

struct SearchResult: Decodable{
    let resultCount: Int
    let results: [Result]
}
