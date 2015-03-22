//
//  PB-SOSDetailFCell.h
//  PANDA-BANG
//
//  Created by mhand on 15/2/5.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PB_SOSDetailFCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PBUserPhoto;
@property (weak, nonatomic) IBOutlet UILabel *PBUserBloodType;
@property (weak, nonatomic) IBOutlet UILabel *PBUserName;
@property (weak, nonatomic) IBOutlet UILabel *PBTimeLabel;
- (IBAction)PBLocationAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *PBBloodVolume;

@property (weak, nonatomic) IBOutlet UILabel *PBConnectionTime;
@property (weak, nonatomic) IBOutlet UITextView *PBSOSDetail;
@end
