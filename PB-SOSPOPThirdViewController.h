//
//  PB-SOSPOPThirdViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/25.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PB_SOSPOPThirdViewController : UIViewController<UIActionSheetDelegate>
- (IBAction)popVC:(UIButton *)sender;
- (IBAction)completeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)ifPayAction:(UIButton *)sender;
- (IBAction)bloodReason:(UIButton *)sender;

@end
