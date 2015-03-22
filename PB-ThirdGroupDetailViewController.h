//
//  PB-ThirdGroupDetailViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/3/3.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-ThirdGroupViewController.h"

@interface PB_ThirdGroupDetailViewController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,retain)PB_ThirdGroupViewController *thirdVC;
@property(nonatomic,retain)UIPanGestureRecognizer *panG;
@property(nonatomic,assign)CGPoint startPoint;
//传值得到的路径的行
@property (nonatomic,assign)NSInteger indexPathRow;
@property(nonatomic,assign)BOOL  popPan;
@property(nonatomic,assign)BOOL MainPan;;
@end
