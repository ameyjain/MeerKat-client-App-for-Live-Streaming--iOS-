//
//  SearchTableViewController.swift
//  Glance Feed
//
//  Created by Amey Jain on 8/13/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class PlayerViewController: UIViewController, UIWebViewDelegate {
    var webView: UIWebView?
    var webViewButton : UIButton?
    let launchimage = UIImage(named: "button.png")
    let launchimage2 = UIImage(named: "button2.pn")
    var hiddenFlag = 0
    var playerHiddenFlag = false
    var hide : UIButton?

    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    var player : AVPlayer
    var playermini1 : AVPlayer
    var playermini2 : AVPlayer
    var playermini3 : AVPlayer

    var playerController : AVPlayerViewController
    var playerController2 : AVPlayerViewController
    var playerController3 : AVPlayerViewController
    var playerController4 : AVPlayerViewController

    required init?(coder aDecoder: NSCoder) {
        playerController = AVPlayerViewController()
        playerController2 = AVPlayerViewController()
        playerController3 = AVPlayerViewController()
        playerController4 = AVPlayerViewController()

        player = AVPlayer()
        playermini1 = AVPlayer()
        playermini2 = AVPlayer()
        playermini3 = AVPlayer()

        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerHiddenFlag = false
        
        
        webView?.delegate = self
        let url = NSURL(string: twitterURLArray[0])
        let req = NSURLRequest(URL:url!)
        webView!.loadRequest(req)
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
            self.webView?.frame = CGRectMake(-self.view.frame.width + 50, 0 , self.view.frame.width - 50, self.view.frame.height)
        }else{
            self.webView?.frame = CGRectMake(-self.view.frame.width / 2, 0, self.view.frame.width / 2, self.view.frame.width)
        }
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)

        
        
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Up:

                if(playerHiddenFlag == true){
                    UIView.animateWithDuration(0.2, delay: 0,
                        options: [ .TransitionCrossDissolve], animations: {
                            self.playerController2.view.center.y -= self.view.frame.height
                            self.playerController3.view.center.y -= self.view.frame.height
                            self.playerController4.view.center.y -= self.view.frame.height

                            self.visualEffectView.center.y -= self.view.frame.height
                        }, completion: nil)
                    
                    playermini1.play()
                    playermini2.play()
                    playermini3.play()
                    playerHiddenFlag = false

                }

            case UISwipeGestureRecognizerDirection.Down:
                if(playerHiddenFlag == false){
                UIView.animateWithDuration(0.2, delay: 0,
                            options: [ .TransitionCrossDissolve], animations: {
                                self.playerController2.view.center.y += self.view.frame.height
                                self.playerController3.view.center.y += self.view.frame.height
                                self.playerController4.view.center.y += self.view.frame.height
                                self.visualEffectView.center.y += self.view.frame.height
                            }, completion: nil)
                playermini1.pause()
                playermini2.pause()
                playermini3.pause()
                playerHiddenFlag = true
                }
                
            case UISwipeGestureRecognizerDirection.Right:
                hiddenFlag = 1
                self.view.addSubview(webView!)

                UIView.animateWithDuration(0.2, delay: 0,
                    options: [ .TransitionCrossDissolve], animations: {
                        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
                            self.webView?.frame = CGRectMake(0, 0 , self.view.frame.width - 50, self.view.frame.height)
                        }else{
                            self.webView?.frame = CGRectMake(0, 0, self.view.frame.width / 2, self.view.frame.width)
                        }
                    }, completion: nil)

                
               

            case UISwipeGestureRecognizerDirection.Left:
                hiddenFlag = 0
                UIView.animateWithDuration(0.2, delay: 0,
                    options: [ .TransitionCrossDissolve], animations: {
                        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
                            self.webView?.frame = CGRectMake(-self.view.frame.width + 50, 0 , self.view.frame.width - 50, self.view.frame.height)
                        }else{
                            self.webView?.frame = CGRectMake(-self.view.frame.width / 2, 0, self.view.frame.width / 2, self.view.frame.width)
                        }
                    }, completion: nil)

            
            default:
                break
            }
        }
    }
    
  
    
    override func viewDidAppear(animated: Bool) {
        
        visualEffectView.alpha = 1
        visualEffectView.frame = CGRectMake(0, self.view.frame.height - 150, self.view.frame.width, 150)
        
        numberOfPlayers()
        hiddenFlag = 0
        self.navigationController?.navigationBarHidden = true
    }
    
    func ShowWebView(sender:UIButton!){
        
           }
    //-------------------------------------------------------------------------------------------
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
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
            webView?.frame = CGRectMake(0, 0, self.view.frame.width - 50, self.view.frame.height)
        }else{
            webView?.frame = CGRectMake(0, 0, self.view.frame.height - 50, self.view.frame.width)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func numberOfPlayers(){
        
        if(videoURLArray.count == 3){
        
            player = AVPlayer(URL: NSURL(string: videoURLArray[0])!)
            playerController = AVPlayerViewController()
            playerController.player = player
            self.addChildViewController(playerController)
            self.view.addSubview(playerController.view)
            playerController.view.frame = self.view.frame //CGRectMake(5, 5, 200, 260)
            player.play()
            self.view.addSubview(visualEffectView)
            
            
            playermini1 = AVPlayer(URL: NSURL(string: videoURLArray[1])!)
            playerController2 = AVPlayerViewController()
            playerController2.player = playermini1
            self.addChildViewController(playerController2)
            self.view.addSubview(playerController2.view)
            playerController2.view.frame = CGRectMake(10, self.view.frame.height - 145, 100, 145) //self.view.frame
            playermini1.play()
            
            playermini2 = AVPlayer(URL: NSURL(string: videoURLArray[2])!)
            playerController3 = AVPlayerViewController()
            playerController3.player = playermini2
            self.addChildViewController(playerController3)
            self.view.addSubview(playerController3.view)
            playerController3.view.frame = CGRectMake(self.view.frame.width - 110, self.view.frame.height - 145, 100, 145) //self.view.frame
            playermini2.play()
        
        }
    
        if(videoURLArray.count == 4){
            
            player = AVPlayer(URL: NSURL(string: videoURLArray[0])!)
            playerController = AVPlayerViewController()
            playerController.player = player
            self.addChildViewController(playerController)
            self.view.addSubview(playerController.view)
            playerController.view.frame = self.view.frame //CGRectMake(5, 5, 200, 260)
            player.play()
            self.view.addSubview(visualEffectView)
          //  player.
        //    playerController.
            
            
            playermini1 = AVPlayer(URL: NSURL(string: videoURLArray[1])!)
            playerController2 = AVPlayerViewController()
            playerController2.player = playermini1
            self.addChildViewController(playerController2)
            self.view.addSubview(playerController2.view)
            playerController2.view.frame = CGRectMake(10, self.view.frame.height - 145, 100, 145) //self.view.frame
            playermini1.play()
            playermini1.muted = true
            
            playermini2 = AVPlayer(URL: NSURL(string: videoURLArray[2])!)
            playerController3 = AVPlayerViewController()
            playerController3.player = playermini2
            self.addChildViewController(playerController3)
            self.view.addSubview(playerController3.view)
            playerController3.view.frame = CGRectMake(self.view.frame.width - 110, self.view.frame.height - 145, 100, 145) //self.view.frame
            playermini2.play()
            playermini2.muted = true
            
            playermini3 = AVPlayer(URL: NSURL(string: videoURLArray[3])!)
            playerController4 = AVPlayerViewController()
            playerController4.player = playermini3
            self.addChildViewController(playerController3)
            self.view.addSubview(playerController4.view)
            playerController4.view.frame = CGRectMake(self.view.center.x - 50, self.view.frame.height - 145, 100, 145) //self.view.frame
            playermini3.play()
            playermini3.muted = true
            
            
        }

        
        
    }
    
}
