//
//  locationInfo.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/26.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface locationInfo : NSObject
{

    CLLocation *_location;
    NSString *_locationlabel;

}
+ (locationInfo *)defaultManager;
-(void)saveLocation:(CLLocation *)location;
-(CLLocation *)getLocation;
-(void)saveLocationLabel:(NSString *)string;
-(NSString *)getLocationLabel;
@end
