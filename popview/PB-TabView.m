//
//  PB-TabView.m
//  PANDA-BANG
//
//  Created by mhand on 15/3/4.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-TabView.h"

@implementation PB_TabView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        
        
    }
    
    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    NSArray *imageCommon=@[[UIImage imageNamed:@"home_h"],[UIImage imageNamed:@"pan"] ,[UIImage imageNamed:@"account_normal@2x"]];
    NSArray *imageHighlight=@[[UIImage imageNamed:@"home_normal@2x"],[UIImage imageNamed:@"pan"] ,[UIImage imageNamed:@"account_h"]];
    UIImageView *backGroundIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, -5, KSCREEM_WIDTH, 55)];
    backGroundIV.image=  [UIImage imageNamed:@"item_detail_bottom_bar@2x"];
    backGroundIV.userInteractionEnabled=YES;
    
    UIButton *firstPageButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 110, 50)];
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *thirdPageButton=[[UIButton alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH-110,0, 110, 50)];
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
   
    [firstPageButton addTarget:self action:@selector(changet:) forControlEvents:UIControlEventTouchUpInside];
    firstPageButton.tag=1;
    [thirdPageButton addTarget:self action:@selector(changet:) forControlEvents:UIControlEventTouchUpInside];
    thirdPageButton.tag=3;
    
    if (self.page==1) {
        [firstPageButton setImage:[UIImage imageNamed:@"home_h"]forState:UIControlStateNormal];
        [thirdPageButton setImage:[UIImage imageNamed:@"account_normal@2x"] forState:UIControlStateNormal];

    }
    else if (self.page==3){
    
        [firstPageButton setImage:[UIImage imageNamed:@"home_normal@2x"]forState:UIControlStateNormal];
        [thirdPageButton setImage:[UIImage imageNamed:@"account_h"] forState:UIControlStateNormal];

    
    }
    
    [self addSubview:backGroundIV];
    [backGroundIV  addSubview:firstPageButton];
    [backGroundIV addSubview:thirdPageButton];

    
    
}
-(void)changet:(UIButton *)sender{
    NSLog(@"%@",self.delegate);
    
    [self.delegate changeT:sender];
}


@end
