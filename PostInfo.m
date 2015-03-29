
//
//  PostInfo.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/28.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PostInfo.h"

@implementation PostInfo
+ (PostInfo *)defaultManager{
    
    
    static PostInfo *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
-(void)setOriganlUserName:(NSString *)username UserImage:(UIImage *)userImage{
    _Post_userName=username;
    _Post_userPhoto=userImage;
}
-(void)clearAllInfo{
    _Post_name=nil;
    _Post_age=nil;
    _Post_sex=nil;
    _Post_bloodType=nil;
    _Post_location=nil;
    _Post_locationLabel=nil;
    
    _Post_telephoneN1=nil;
    _Post_telephoneN2=nil;
    _Post_bloodValume=nil;
    _Post_imageArray=nil;
    _Post_isPay=nil;
    _Post_bloodReason=nil;
    _Post_detail=nil;


}



@end
