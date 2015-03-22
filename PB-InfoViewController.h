//
//  PB-InfoViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-FirstSOSViewController.h"

@interface PB_InfoViewController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,retain)UIPanGestureRecognizer *panG;
@property(nonatomic,retain)PB_FirstSOSViewController *sosVC;
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)BOOL  popPan;
@property(nonatomic,assign)BOOL MainPan;;
@end
