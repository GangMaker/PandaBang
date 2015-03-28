//
//  PB-TabBarMenuViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ViewController;


@interface PB_TabBarMenuViewController : UITabBarController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property(nonatomic,retain)UIImageView *tabView;
@property(nonatomic,retain)ViewController *parentVC;
-(void)changeTabView:(UIButton *)sender;

@end
