//
//  AppsHeader.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/17/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit

class AppsHeader: UICollectionReusableView {
        
}

extension AppsHeader: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellInsideHeader", for: indexPath) as! CellInsideHeader
        
        return cell
    }
    
    
    
}
