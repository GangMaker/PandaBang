//
//  locationInfo.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/26.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "locationInfo.h"

@implementation locationInfo


+ (locationInfo *)defaultManager{


    static locationInfo *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
-(void)saveLocation:(CLLocation *)location{

    _location=location;
}
-(CLLocation *)getLocation{
    return _location;

}
-(void)saveLocationLabel:(NSString *)string{

    _locationlabel=string;
    
}
-(NSString *)getLocationLabel{

    return _locationlabel;}


@end
