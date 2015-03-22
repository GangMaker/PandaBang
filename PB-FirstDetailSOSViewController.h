//
//  PB-FirstDetailSOSViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/28.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class PB_FirstSOSViewController;
@interface PB_FirstDetailSOSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
- (IBAction)backVc:(UIButton *)sender;
@property(nonatomic,assign)BOOL  popPan;
@property(nonatomic,assign)BOOL MainPan;;


@property(nonatomic,retain)PB_FirstSOSViewController *sosVC;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//传值得到的路径的行
@property (nonatomic,assign)NSInteger indexPathRow;
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
//回复人的label
//@property
//存放图片组的滚动视图
@property(nonatomic,assign)BOOL isDisscussView;
@property (weak, nonatomic) IBOutlet UIView *buttonCollectionV;
- (IBAction)discussAction:(UIButton *)sender;
- (IBAction)connectAction:(UIButton *)sender;
- (IBAction)shareAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *discussInputV;
@property (weak, nonatomic) IBOutlet UIControl *lightView;
@property(nonatomic,retain)UIPanGestureRecognizer *panG;
@property(nonatomic,assign)CGPoint startPoint;

- (IBAction)sendImage:(UIButton *)sender;
- (IBAction)saveAction:(UIButton *)sender;

- (IBAction)resignKeyBoard:(UIControl *)sender;
@end
