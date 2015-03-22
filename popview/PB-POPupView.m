//
//  PB-POPupView.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-POPupView.h"
#define KSCREEM_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define KSCREEM_WIDTH      [UIScreen mainScreen].bounds.size.width

@implementation PB_POPupView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)getView:(PopUpViewStyle)style{

    // 第一个button电话
    self.firstButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 15, 65, 65)];
    [self addSubview:self.firstButton];
    //第二个button评论
    self.secondButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 115, 65, 65)];
    [self addSubview:self.secondButton];
    //第三个button 取消
    self.cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(40,210 , 65, 65)];
    [self.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.cancelButton];
    if (style==KPhoneCall) {
    [self.firstButton setImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateNormal];
    [self.firstButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondButton setImage:[UIImage imageNamed:@"find.png"] forState:UIControlStateNormal];
    [self.secondButton addTarget:self action:@selector(find:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];

    [self.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(style==KShare){
    
    [self.firstButton addTarget:self action:@selector(shareWeChat:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondButton addTarget:self action:@selector(shareWeBo:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
}
- (void)drawRect:(CGRect)rect {
//    如果style是电话
    if (self.firstButton==nil) {
        
    
    if (self.style==KPhoneCall) {
// 添加个电话的方法 并且弹出
        [self getView:KPhoneCall];
        
        [self PopView];
        }
    else if(self.style==KShare){
// 第一个button电话
        [self getView:KShare];
        [self PopView];
       }

    }
}
-(id)initPopUpViewStyle:(PopUpViewStyle)style withASpeed:(ASpeed)speed{
    self=[super init];
    if (self!=nil) {
        self.speed=speed;
        self.style=style;
        self.frame=CGRectMake(-KSCREEM_WIDTH/3,KSCREEM_HEIGHT/2-160, KSCREEM_WIDTH/4, 300);
        self.backgroundColor=[UIColor clearColor];
    }


    return self;

}
-(void)PopView{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0,KSCREEM_HEIGHT/2-160, KSCREEM_WIDTH/3, 300);
        
    } completion:^(BOOL finished) {
        
    }];


}
-(void)PopBackView{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(-KSCREEM_WIDTH/3,KSCREEM_HEIGHT/2-160, KSCREEM_WIDTH/3, 300);
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];


}

#define buttonMethod
-(void)cancel:(UIButton *)sender{
// 当取消的时候  弹回视图 并且把背景暗下来的图片 移除 让代理的手势恢复
    [self PopBackView];
    [UIView animateWithDuration:0.3 animations:^{
    self.lightView.alpha=0;
    } completion:^(BOOL finished) {
    [self.lightView removeFromSuperview];
    [self.delegate recoverUserEnabled];

    }];


    
}
-(void)callPhone:(UIButton *)sender{
    [self PopBackView];
    [self.delegate PB_callPhone:self.phoneNumber];
    [UIView animateWithDuration:0.3 animations:^{
    self.lightView.alpha=0;
    } completion:^(BOOL finished) {
    [self.lightView removeFromSuperview];
    [self.delegate recoverUserEnabled];
    }];


}
-(void)find:(UIButton *)sender{




}
-(void)shareWeChat:(UIButton *)sender{


}
-(void)shareWeBo:(UIButton *)sender{
    
    
}

@end
