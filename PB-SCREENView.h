//
//  PB-SCREENView.h
//  PANDA-BANG
//
//  Created by mhand on 15/2/16.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PBSCREENDelegate<NSObject>
-(void)screenChooseNear;
-(void)screenChooseAllC;

@end
@interface PB_SCREENView : UIView<UITableViewDataSource,UITableViewDelegate>

-(id)initWithFrame:(CGRect)frame;
@property(nonatomic,retain)id<PBSCREENDelegate>delegate;
@property(nonatomic,retain)UIImageView *imageV;

@property(nonatomic,retain)UITableView *tableV;

@end
