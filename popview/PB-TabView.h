//
//  PB-TabView.h
//  PANDA-BANG
//
//  Created by mhand on 15/3/4.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PBTabViewDelegate<NSObject>
-(void)changeT:(UIButton *)sender;
@end

@interface PB_TabView : UIView
@property (nonatomic,retain)id<PBTabViewDelegate>delegate;
@property(nonatomic,assign)int page;

-(id)initWithFrame:(CGRect)frame;

@end
