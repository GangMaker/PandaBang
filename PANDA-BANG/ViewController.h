//
//  ViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/20.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-TabBarMenuViewController.h"
#import "PB-RightViewController.h"
#import "PB-SOSCell.h"
@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backGoundImageView;
@property(nonatomic,retain)PB_TabBarMenuViewController *MainViewController;
@property(nonatomic,retain)UIView *blackVC;

@property(nonatomic,retain)PB_RightViewController *RightViewController;
@property(nonatomic,retain)UIPanGestureRecognizer *panG;
@property(nonatomic,retain)UITapGestureRecognizer *tapG;
@property(nonatomic,assign)BOOL popViewCloseAnimation;
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)BOOL isLogin;

//初始位置
-(void)PB_SetInitialPositionAnimation:(BOOL)YorN;
-(void)PB_EndPanSetInitialP;
@end

