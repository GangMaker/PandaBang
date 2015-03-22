//
//  PB-SOSCell.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/20.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PB_SOSCell;
//设置代理 让代理执行方法
@protocol PBSOSCellDelegate<NSObject>
-(void)PBConnect:(PB_SOSCell *)cell;
-(void)PBShare:(PB_SOSCell *)cell;
-(void)PBDisscuss:(PB_SOSCell *)cell;
-(void)PBPush:(PB_SOSCell *)cell;
-(void)pushToInfo;


@end
@interface PB_SOSCell : UITableViewCell
@property(nonatomic,retain)id<PBSOSCellDelegate>delegate;
//属性用来展示cell
//放置图片的滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *imageArrayScrollV;
//放置头像
@property (weak, nonatomic) IBOutlet UIButton *PBUserPhoto;
- (IBAction)IntroPerson:(UIButton *)sender;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *PBUserName;
//求助时间
@property (weak, nonatomic) IBOutlet UILabel *PBTimeLabel;
//求助详情
@property (weak, nonatomic) IBOutlet UITextView *PBSOSDetail;
//求助方法
@property (weak, nonatomic) IBOutlet UILabel *PBBloodVolume;
- (IBAction)PBLocationAction:(UIButton *)sender;
//
- (IBAction)PBACTIONConnect:(UIButton *)sender;

- (IBAction)PBACTIONDisscuss:(UIButton *)sender;
- (IBAction)PBACTIONSave:(UIButton *)sender;

- (IBAction)PBACTIONShare:(UIButton *)sender;
@end
