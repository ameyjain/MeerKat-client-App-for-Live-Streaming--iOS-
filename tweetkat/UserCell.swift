//
//  InstaCollectionViewCell.swift
//  Glance Feed
//
//  Created by Amey Jain on 8/15/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer



class UserCell: UICollectionViewCell {
    
    
    let imageView: UIImageView!
    let UserDp: UIImageView!
    let username: UILabel!
   // let playerViewController : AVPlayerViewController!
    
    override init(frame: CGRect) {
        
        UserDp = UIImageView(frame: CGRect(x: 5, y: frame.size.width + 5 , width: 50, height: 50))
        username = UILabel(frame: CGRect(x: 65, y: frame.size.width + 5, width: frame.size.width - 5, height: 30))
        
//        playerViewController = AVPlayerViewController()
//        playerViewController.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.width)
//        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        imageView.backgroundColor = UIColor(red: 243/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
        
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(UserDp)
        contentView.addSubview(username)
        
  
        
    }
    
 
    

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
