//
//  PB-TabBarMenuViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class ViewController;


@interface PB_TabBarMenuViewController : UITabBarController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,UITextViewDelegate>
@property(nonatomic,retain)UIImageView *tabView;
@property(nonatomic,retain)ViewController *parentVC;
@property(nonatomic,retain)NSMutableArray *currentLocation;
-(void)changeTabView:(UIButton *)sender;

@end
