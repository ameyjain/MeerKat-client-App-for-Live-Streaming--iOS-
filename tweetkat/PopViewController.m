//
//  PopViewController.m
//  Glance Feed
//
//  Created by Amey Jain on 8/10/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    self.view.frame = [UIScreen mainScreen].bounds;

    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.4];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.gopro.layer.cornerRadius = 20;
   
    [self.gopro addTarget:self action:@selector(premiumpressed) forControlEvents:UIControlEventTouchUpInside];
    self.gopro.hidden = false;
    [self.view addSubview:self.gopro];
    
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aView addSubview:self.view];
        if (animated) {
            [self showAnimate];
        }
    });
}

- (void)premiumpressed {
    [self removeAnimate];
   
}

//- (IBAction)goPremium:(UIButton *)sender {
//    
//    
//    NSLog(@"Go Premium pressed");
//    [PFPurchase buyProduct:@"com.davincilabs.premium" block:^(NSError *error){
//        
//        if(!error){
//            UIAlertView *purchased = [[UIAlertView  alloc]initWithTitle:@"Purchase Done" message:@"Congratulations! You are now a Premium user. Enjoy downloading and sharing." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [purchased show];
//        }
//        else{
//            UIAlertView *error = [[UIAlertView alloc]
//                                  initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [error show];
//        }
//        
//    }];
//
//}
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

