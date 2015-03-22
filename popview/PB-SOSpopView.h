//
//  PB-SOSpopView.h
//  PANDA-BANG
//
//  Created by mhand on 15/3/7.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@protocol PBSOSDelegate<NSObject>
-(void)photoFromAlbum:(BOOL)head;
-(void)takePhotopicker:(BOOL)head;
-(void)backView;
-(void)addCell;
@end
@interface PB_SOSpopView : UIView<UIScrollViewDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)id<PBSOSDelegate>delegate;
@property(nonatomic,retain)NSMutableArray * imageCollection;
-(void)addImageV:(UIImage *)image;
-(id)initWithFrame:(CGRect)frame;
@property(nonatomic,retain)NSMutableDictionary *allInfo;
-(void)getHead:(UIImage *)image;
-(void)getAllThings;
@end
