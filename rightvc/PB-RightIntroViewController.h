//
//  PB-RightIntroViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/2/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PB_RightIntroViewController : UIViewController
- (IBAction)Introduce:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)history:(UIButton *)sender;
- (IBAction)dissmissVC:(UIButton *)sender;
- (IBAction)safe:(UIButton *)sender;

@end
