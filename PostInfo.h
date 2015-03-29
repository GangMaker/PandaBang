//
//  PostInfo.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/28.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostInfo : NSObject
//  用户名字

@property (nonatomic,retain)    NSString *Post_name;
//  用户头像
@property (nonatomic,retain)UIImage *Post_userPhoto;
//    用户名
@property (nonatomic,retain)NSString *Post_userName;
//    用户性别

@property (nonatomic,retain)NSString *Post_sex;
//  用户年龄
@property (nonatomic,retain)NSString *Post_age;
//用户血型

@property (nonatomic,retain)NSString *Post_bloodType;
//    用户血量
@property (nonatomic,retain)NSString *Post_bloodValume;
//   用户详情图片数
@property (nonatomic,retain)NSMutableArray *Post_imageArray;
//   用户详情
@property (nonatomic,retain)NSString *Post_detail;
//    用户位置信息
@property (nonatomic,retain)NSString *Post_locationLabel;
//    用户位置
@property (nonatomic,retain)CLLocation *Post_location;
//    用户标签1
@property (nonatomic,retain)NSString *Post_isPay;
//    用户标签2
@property (nonatomic,retain)NSString *Post_bloodReason;
//  用户电话

@property (nonatomic,retain)NSString *Post_telephoneN1;

@property (nonatomic,retain)NSString *Post_telephoneN2;



+ (PostInfo *)defaultManager;
-(void)clearAllInfo;
@end
