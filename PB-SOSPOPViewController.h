//
//  PB-SOSPOPViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PB_SOSPOPViewController : UIViewController<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *bloodButton;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *volume;
@property (weak, nonatomic) IBOutlet UITextField *textTelephone;
@property (weak, nonatomic) IBOutlet UITextField *textTelephoneS;

- (IBAction)chooseHead:(UIButton *)sender;
- (IBAction)chooseSex:(UIButton *)sender;
- (IBAction)chooseBlood:(UIButton *)sender;
- (IBAction)backVC:(UIBarButtonItem *)sender;

- (IBAction)ageChange:(UISlider *)sender;
- (IBAction)volumeChange:(UISlider *)sender;

- (IBAction)nextStepAction:(UIButton *)sender;


@end
