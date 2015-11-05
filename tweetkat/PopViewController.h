//
//  PopViewController.h
//  Glance Feed
//
//  Created by Amey Jain on 8/10/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UITableView *tablead;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@property (strong, nonatomic) IBOutlet UIButton *gopro;
//- (void)premiumpressed;

@end