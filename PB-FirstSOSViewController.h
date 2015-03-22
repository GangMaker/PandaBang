//
//  PB-FirstSOSViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-SOSCell.h"
#import "PB-POPupView.h"
#import "PB-SCREENView.h"
#import "PB-FirstDetailSOSViewController.h"
#import "PB-MessageViewController.h"
#import "PB-NavMessageViewController.h"
#import "PB-TabBarMenuViewController.h"
#import "PB-InfoViewController.h"
#import "MJRefresh.h"
#import "PB-TabView.h"

@class PB_FirstDetailSOSViewController;
@class PB_MessageViewController;
@class PB_InfoViewController;

typedef void (^completeblock)(void);

@interface PB_FirstSOSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PBSOSCellDelegate,PBPOPupDelegate,UIScrollViewDelegate,PBSCREENDelegate,PBTabViewDelegate>

@property(nonatomic,retain)UIControl *lightView;
@property(nonatomic,assign)int cellCount;
@property(nonatomic,assign)int checkMarkPostion;

@property(nonatomic,retain)PB_FirstDetailSOSViewController *mydetailSOSVC;

@property(nonatomic,retain)PB_InfoViewController *myinfoVC;

@property(nonatomic,retain)PB_NavMessageViewController *mymessageVC;

@property(nonatomic,retain)PB_TabBarMenuViewController *myTabBarVC;
@property(nonatomic,retain)PB_SCREENView* screenView;
@property(nonatomic,retain)PB_POPupView *myPopView;
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)ViewController *mainVC;
@property(nonatomic,assign)completeblock completeBlock;
@property(nonatomic,retain)UIScrollView *firstDetailSV;
//从数据库请求的图片字典
@property(nonatomic,retain)NSMutableDictionary *allData;

//从数据库请求的图片组
@property(nonatomic,retain)NSMutableArray *imageArray;
//请求的用户名
@property(nonatomic,retain)NSString *sosUserName;

//请求的头像
@property(nonatomic,retain)UIImage *sosUserImage;
//请求的血型(string类型)
@property(nonatomic,retain)NSString *sosUserBloodType;
//请求的血量
@property(nonatomic,retain)NSString *sosUserBloodAccount;
//请求的时间
@property(nonatomic,retain)NSString *sosTimer;
//请求的详情
@property(nonatomic,retain)NSString *sosDetail;
//请求的位置Label
@property(nonatomic,retain)NSString *sosLocationLabel;
//请求的位置坐标
@property(nonatomic,assign)CLLocationCoordinate2D locationcoordinate;
//请求的评论
@property(nonatomic,retain)NSMutableArray *disscussArray;
//请求的电话
@property(nonatomic,retain)NSString *sosTeleN;
- (IBAction)chooseRange:(UIButton *)sender;
- (IBAction)pushMessageVC:(UIButton *)sender;
-(void)letshowView:(NSString *)phoneNum type:(PopUpViewStyle)style;
-(void)insertCell;
-(void)headerrefresh:(int)range;
@end
