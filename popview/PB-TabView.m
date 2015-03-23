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
    for (int index=0; index<3; index++) {
        float width;
        float buttonX;
        float heightY;
        
        if (index==1) {
            width=60;
            buttonX=375/2-30;
            heightY=-10;
        }
        else{
            if (index==0) {
                buttonX=0;
            }
            else{
                buttonX=KSCREEM_WIDTH-110;;
            }
            width=110;
            heightY=0;
        }
        //添加3个button
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(buttonX,heightY, width, 50)];
        [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
  
        //给定tag 切换视图的时候用
        if (self.page==0) {
            [button setImage:[imageCommon objectAtIndex:index] forState:UIControlStateNormal];

        }
        else if (self.page==2){
            [button setImage:[imageHighlight objectAtIndex:index] forState:UIControlStateNormal];

        }
        
        
        button.tag=index;
        
        [button addTarget:self action:@selector(changet:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backGroundIV];
        [backGroundIV  addSubview:button];
    }
    
}
-(void)changet:(UIButton *)sender{
    NSLog(@"%@",self.delegate);
    
    [self.delegate changeT:sender];
}


@end
