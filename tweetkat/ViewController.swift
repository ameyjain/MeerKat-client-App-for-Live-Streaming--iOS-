//
//  SearchTableViewController.swift
//  TweetKat
//
//  Created by Amey Jain on 8/13/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIWebViewDelegate, UIDocumentInteractionControllerDelegate {
    
    var webView: UIWebView?
    let launchimage = UIImage(named: "button.png")
    var searchButton : UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width - 90, y: self.view.frame.height / 1.30 + 40), size: CGSize(width: 50, height: 50)))
        self.searchButton!.setBackgroundImage(launchimage, forState: UIControlState.Normal)
        self.navigationController?.view.addSubview(searchButton!)
        self.tableView.backgroundColor = UIColor(red: 243/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
        self.searchButton!.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

    
        
        let url = NSURL(string:"https://twitter.com/geeksonly")
        let req = NSURLRequest(URL:url!)
        webView?.delegate = self
        webView!.loadRequest(req)
        webView?.frame = CGRectMake(0, 0, self.view.frame.width - 50, self.view.frame.height)
        //self.view.addSubview(webView!)
        

    }
    
        func buttonAction(sender:UIButton!)
        {
            
            if(videoURLArray.isEmpty){
                let alert = UIAlertController(title: "Alert!!", message: "Please select atleast 1 Video", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                self.performSegueWithIdentifier("PlayerViewSegue", sender: self)
            }
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "PlayerViewSegue") {
            _ = segue.destinationViewController as! PlayerViewController;
            self.navigationController?.view.sendSubviewToBack(searchButton!)

        }
    }
    
    //-------------------------------WEB VIEW-----------------------------------------------------------
    override func loadView() {
        super.loadView()
        self.webView = UIWebView()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView1: UIWebView) {
    }
    //-------------------------------------------------------------------------------------------

    
        

    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 1){
            return 40.0
        }
         else if(indexPath.row == 0){
            return 350
        	}
        else{
            return 400
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("CellItem", forIndexPath: indexPath) as! ItemViewCell
            cell.backgroundColor =  UIColor(red: 243/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            
            return cell
            
        }
            
        else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)// as! UITableViewCell
            
            cell.textLabel?.text = "Selected Items"
            cell.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            cell.backgroundColor =  UIColor(red: 243/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)

            return cell
        }
        else{
            return UITableViewCell()
        }
        
    }
    
}
