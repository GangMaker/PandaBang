//
//  PB-SOSDetailFCell.m
//  PANDA-BANG
//
//  Created by mhand on 15/2/5.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSDetailFCell.h"

@implementation PB_SOSDetailFCell

- (void)awakeFromNib {
    // Initialization code
   


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;

}

- (IBAction)PBLocationAction:(UIButton *)sender {
}
@end
