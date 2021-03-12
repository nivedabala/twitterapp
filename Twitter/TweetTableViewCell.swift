//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Niveda Balananthan on 2021-03-07.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favouriteTweet(_ sender: Any) {
        
        let toBeFavourited = !favourited
        
        if (toBeFavourited) {
            
            TwitterAPICaller.client?.favouriteTweet(tweetId: tweetId, success: {
                
                self.setFavourite(true)
                
            }, failure: { (error) in
                print("favourite did not succeed :\(error)")
            })
        } else {
            
            TwitterAPICaller.client?.unfavouriteTweet(tweetId: tweetId, success: {
                
                self.setFavourite(false)
                
            }, failure: { (error) in
                print("unfavourite did not succeed :\(error)")
            })
            
            
        }
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            
            self.setRetweeted(true)
            
        }, failure: {(error) in
            
            print("Error is retweeting: \(error)")
            
        })
        
        
    }
    
    var favourited:Bool = false
    
    //initially a neg number, know it's not set
    var tweetId:Int = -1
    
    
    func setFavourite(_ isFavourited:Bool){
        favourited = isFavourited
        if(favourited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        
        if(isRetweeted){
            
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        } else {
            
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
        
    }
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
