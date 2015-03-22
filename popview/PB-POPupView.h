//
//  PB-POPupView.h
//  PANDA-BANG
//
//  Created by mhand on 15/1/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PBPOPupDelegate<NSObject>

-(void)PB_callPhone:(NSString *)phonenumber;
-(void)recoverUserEnabled;

@end
@interface PB_POPupView : UIView
typedef enum{
   KPhoneCall=0,
   KShare=1,

}PopUpViewStyle;
typedef enum{
    KNice=0,
    KFast=1,
    KSlow=2,
    
}ASpeed;

@property(nonatomic,assign)PopUpViewStyle style;
@property(nonatomic,assign)ASpeed speed;
@property(nonatomic,retain)NSString *phoneNumber;
@property(nonatomic,retain)UIView *lightView;
@property(nonatomic,retain)UIButton *firstButton;
@property(nonatomic,retain)UIButton *secondButton;
@property(nonatomic,retain)UIButton *cancelButton;





@property(nonatomic,retain)id<PBPOPupDelegate>delegate;


-(id)initPopUpViewStyle:(PopUpViewStyle)style withASpeed:(ASpeed)speed;
@end
