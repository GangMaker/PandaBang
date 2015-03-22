//
//  PB-ThirdGroupViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/2/3.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-TabView.h"
@class PB_ThirdGroupDetailViewController;
@interface PB_ThirdGroupViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PBTabViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)UIView  *THeaderView;
@property(nonatomic,retain)UIView  *zhanWeiView;

@property(nonatomic,retain)UIButton  *headImage;
@property(nonatomic,assign)int cellCount;
@property(nonatomic,retain)UIButton  *detailInformation;
@property(nonatomic,retain)PB_ThirdGroupDetailViewController *mydetailVC;

@end
