//
//  searchTableViewCell.swift
//  TweetKat
//
//  Created by Amey Jain on 8/13/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer



var videoURLArray = [String]()
var twitterURLArray = [String]()

class ItemViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, NSURLConnectionDelegate {
    var result:[JSON]? = []
    var numberCells = 0
    var data = NSMutableData()
    var jsonResult: NSArray! = []
    var test : NSDictionary!
    var URLIndex = 0
    var arrayImageView = [UIImage]()
    var arrayUserDp = [UIImage]()
    var i = 0
    var labelsample : UILabel!
    let vC = ViewController()

    @IBOutlet var mycollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //loadData()
        startConnection()
        videoURLArray = []
        twitterURLArray = []
        URLIndex = 0
        
        labelsample = UILabel(frame: CGRect(origin: CGPoint(x: vC.view.frame.width - 90, y: vC.view.frame.height / 1.30 + 40), size: CGSize(width: 50, height: 50)))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        
        mycollectionView.frame = self.bounds
        mycollectionView.frame = CGRectMake(1, 0, self.frame.size.width - 1, self.frame.size.height)
        mycollectionView!.dataSource = self
        mycollectionView!.delegate = self
        mycollectionView!.registerClass(UserCell.self, forCellWithReuseIdentifier: "Cell")
        mycollectionView!.backgroundColor = UIColor(red: 243/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return jsonResult.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UserCell
        let currentUserData = jsonResult[indexPath.row]
        
        if(cell.selected){
            cell.layer.borderColor = UIColor.blueColor().CGColor
            cell.layer.borderWidth = 5
        }
        
        
        cell.imageView.image = self.arrayImageView[indexPath.row]
        cell.UserDp.image = self.arrayImageView[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor.whiteColor()
        cell.username.text = (currentUserData["broadcaster"] as! NSDictionary)["name"]! as? String
        cell.username.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        cell.username.textColor = UIColor.blueColor()
        cell.UserDp.layer.cornerRadius = 25
        cell.UserDp.layer.borderColor = UIColor.grayColor().CGColor
        cell.UserDp.layer.borderWidth = 1
        cell.UserDp.clipsToBounds = true
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        return cell
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UserCell
        let currentUserData = jsonResult[indexPath.row]
        
        if(URLIndex < 4){
            videoURLArray.insert(currentUserData["manifest"] as! String,atIndex: URLIndex)
            twitterURLArray.insert(currentUserData["userTwitterUrl"] as! String,atIndex: URLIndex)
            URLIndex = URLIndex + 1
            self.labelsample.text = "Items Selected:"
            print(twitterURLArray)
        }
        else{
            let alert = UIAlertController(title: "Alert!!", message: "Opps! Sorry only 4 Videos can be selected at a time", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            //        viewController(alert, animated: true, completion: nil)
            
            UIApplication .sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            //          [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:(alert, animated: true, completion: nil) animated:YES completion:nil]
            
        }
        
        vC.navigationController?.view.addSubview(labelsample)

        
        //        let player = AVPlayer(URL: NSURL(string: "http://cdn.meerkatapp.co/broadcast/a1e9a90a-0859-4c15-91dc-bebf5c0b03a7/live.m3u8")!)
        //        let playerController = AVPlayerViewController()
        //        playerController.player = player
        //        cell.contentView.addSubview(playerController.view)
        //        cell.contentView.sendSubviewToBack(cell.imageView)
        //        playerController.view.frame = CGRectMake(0, 0, cell.frame.width, cell.frame.width) //self.view.frame
        //        player.play()
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        //videoURLArray.removeLast()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 240, height: 300);
        
    }
    
    
    func startConnection(){
        let urlPath: String = "http://54.176.57.27:8085//api/meerkat/streams"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var i = 0
        
        // throwing an error on the line below (can't figure out where the error message is)
        do{
            self.jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers
                ) as! NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                while(i < self.jsonResult.count){
                    var urlpic = NSURL(string: ((self.jsonResult[i]["broadcaster"] as! NSDictionary)["image"]! as? String)!)
                    if let data = NSData(contentsOfURL: urlpic!){
                        self.arrayImageView.insert(UIImage(data: data)!, atIndex: i)
                    }
                    urlpic = NSURL(string: (self.jsonResult[i]["coverImage"] as? String)!)
                    if let data = NSData(contentsOfURL: urlpic!){
                 //       self.arrayUserDp.insert(UIImage(data: data)!, atIndex: i)
                    }
                    i = i + 1
                    self.mycollectionView.reloadData()

                }

            })

            
        }
        catch{
            print("error")
        }
    }
}


