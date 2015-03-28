
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

@end
