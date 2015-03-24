//
//  PB-SOSCell.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/20.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSCell.h"

@implementation PB_SOSCell

- (void)awakeFromNib {
//    代理事tabbar 所有cell上按钮的执行都给了代理
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PBACTIONPush:)];
    [tap setNumberOfTouchesRequired:1];
    [tap  setNumberOfTapsRequired:1];
    [ self.imageArrayScrollV addGestureRecognizer:tap];
//    self.PBUserPhoto.layer.cornerRadius=20;
//    self.PBUserPhoto.layer.masksToBounds=YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)PBACTIONPush:(UIPanGestureRecognizer *)pan{

    [self.delegate PBPush:self];


}

- (IBAction)PBACTIONConnect:(UIButton *)sender {
    [self.delegate PBConnect:self];

}

- (IBAction)PBACTIONDisscuss:(UIButton *)sender {
    [self.delegate PBDisscuss:self];
}

- (IBAction)PBACTIONSave:(UIButton *)sender {
}



- (IBAction)PBACTIONShare:(UIButton *)sender {
    [self.delegate PBShare:self];

}
- (IBAction)PBLocationAction:(UIButton *)sender {
}

- (IBAction)IntroPerson:(UIButton *)sender {
    [self.delegate pushToInfo];
}
@end
