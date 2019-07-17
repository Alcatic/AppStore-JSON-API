//
//  SearchCell.swift
//  AppStore JSON API
//
//  Created by Di_Nerd on 7/16/19.
//  Copyright © 2019 Di_Nerd. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    var appResult: Result!{
        didSet{
            //Convert URL to image
            let appImageUrl = URL(string: appResult.artworkUrl100)
            self.appImage.sd_setImage(with: appImageUrl, completed: nil)
            self.firstPreviewImage.sd_setImage(with: URL(string: appResult.screenshotUrls[0]), completed: nil)
            
            //Amount of Previews are different
            if appResult.screenshotUrls.count > 1{
                self.secondPreviewImage.sd_setImage(with: URL(string: appResult.screenshotUrls[1]), completed: nil)
            }
            
            if appResult.screenshotUrls.count > 2{
                self.secondPreviewImage.sd_setImage(with: URL(string: appResult.screenshotUrls[2]), completed: nil)
            }
            
            //Post Text from API Response
            self.appName.text = appResult.trackName
            self.appSubtitle.text = appResult.primaryGenreName
            self.appRating.text = "\(appResult.averageUserRating ?? 0)"
            
        }
    }
    
    @IBOutlet weak var appImage: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appSubtitle: UILabel!
    @IBOutlet weak var appRating: UILabel!
    
    
    @IBOutlet weak var firstPreviewImage: UIImageView!
    
    @IBOutlet weak var secondPreviewImage: UIImageView!
    
    @IBOutlet weak var thirdPreviewImage: UIImageView!
    
    
}
