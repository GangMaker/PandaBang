//
//  ViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/20.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "ViewController.h"
#import "PB-TabBarMenuViewController.h"
#import "PB-RightViewController.h"
#import "PB-FirstSOSViewController.h"
#import "PB-BlackViewController.h"
#import "PB-BlackSViewController.h"
#import "PB-FirstDetailSOSViewController.h"
#import "PB-ThirdGroupDetailViewController.h"
#import "PB-SOSCell.h"
#import "PB-InfoViewController.h"
#import "PB-NavMessageViewController.h"
#import <AVOSCloud/AVOSCloud.h>

#define KSB_NAME @"Main"
//设置View的Frame
#define K_GETFRAME(VIEW,X,Y,W,H)  [VIEW setFrame:CGRectMake(X,Y, W, H)]
//设置View的Center
#define K_GETCENTER(VIEW,XCENTER,YCENTER)  [VIEW setCenter:CGPointMake(XCENTER, YCENTER)]


//获取StoryBoard里的VC
#define K_GETFROM_STORYBOARD(SBNAME,VCNAME)  [[UIStoryboard storyboardWithName:SBNAME bundle:[NSBundle mainBundle]]     instantiateViewControllerWithIdentifier:VCNAME]
//屏幕的高和宽
#define KSCREEM_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define KSCREEM_WIDTH      [UIScreen mainScreen].bounds.size.width
#define KINITIAL           YES
#define KTARGET            NO
#define KCANMOVE           YES
#define KLIMITMOVE         NO
#define KWANNALEFT         YES
#define KWANNARIGHT        NO
@interface ViewController ()

@end

@implementation ViewController
{
    BOOL allowMove;
    BOOL backMove;
    BOOL isMoving;
    BOOL specialMove;
    float criticalX;
//  捕捉最后一个用户点
    float userThink;
// 根据捕捉的和前一个点差值
    float LeftorRight;

}


- (void)viewDidLoad {
    
    //    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    //    [testObject setObject:@"bar" forKey:@"foo"];
    //    [testObject save];

    [super viewDidLoad];
       //   设置状态栏的颜色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//  popviewclose默认的是关闭
    self.popViewCloseAnimation=NO;
    self.backGoundImageView.image=[UIImage imageNamed:@"3.jpg"];
//  添加中间和右边的VC

    PB_TabBarMenuViewController *TabBarMenuVC= (PB_TabBarMenuViewController *)K_GETFROM_STORYBOARD(KSB_NAME, @"TabBarMenu");
    PB_RightViewController *RightVC=(PB_RightViewController *)K_GETFROM_STORYBOARD(KSB_NAME, @"Right");
    self.MainViewController=TabBarMenuVC;
    self.RightViewController=RightVC;
//  添加到本视图上
    [self.view addSubview:self.RightViewController.view];
//  添加为子控制器
    [self addChildViewController:self.RightViewController];
    [self.view addSubview:self.MainViewController.view];
    [self addChildViewController:self.MainViewController];
    [self PB_SetInitialPositionAnimation:NO];
//  添加一个手势在self.view上
    self.panG=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PB_PanAction:)];
    [self.view addGestureRecognizer:self.panG];
//加一个手势在目标位置的时候
    self.tapG=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PB_TapBack:)];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)RightVCPosion:(BOOL)IorT{
    CATransform3D rotationTransformRight = CATransform3DIdentity;
//    设定透视的距离  600.f 距离越近透视度接近无穷 默认为0无透视度
    rotationTransformRight.m34 = -1.0f/600.0f;
    
    if (IorT==KINITIAL) {
//  RightVC设置初始位置
    rotationTransformRight = CATransform3DRotate(rotationTransformRight,45.0f * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
    K_GETFRAME(self.RightViewController.view, 400, KSCREEM_HEIGHT*0.1, KSCREEM_HEIGHT*0.8, KSCREEM_HEIGHT*0.8);
        
    }
    else{
//  RightVC的目标位置
           rotationTransformRight = CATransform3DRotate(rotationTransformRight,0.0f * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
    K_GETFRAME(self.RightViewController.view, 100, 0, KSCREEM_WIDTH, KSCREEM_HEIGHT);

    }
    [self.RightViewController.view.layer setTransform:rotationTransformRight];

}


-(void)MainVCPosion:(BOOL)IorT{
    CATransform3D rotationTransformMain = CATransform3DIdentity;
    rotationTransformMain.m34 = -1.0f/600.0f;
    if (IorT==KINITIAL) {
//  MainVC的位置  初始位置
//  设置主视图的宽高大小
        rotationTransformMain.m11=1;
        rotationTransformMain.m22=1;

    rotationTransformMain = CATransform3DRotate(rotationTransformMain,0.0f * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
    K_GETCENTER(self.MainViewController.view, (KSCREEM_WIDTH/2), (KSCREEM_HEIGHT/2));
    }
    else{
    //  MainVC的目标位置
        rotationTransformMain.m11=0.85;
        rotationTransformMain.m22=0.85;

    rotationTransformMain = CATransform3DRotate(rotationTransformMain,30.0f * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
    K_GETCENTER(self.MainViewController.view, -80, KSCREEM_HEIGHT/2);
//   找到tabbar选中的vc让他原有的手势停用
//    UIViewController *vc= self.MainViewController.selectedViewController;
//     vc.view.userInteractionEnabled=NO;

    [self.MainViewController.view addGestureRecognizer:self.tapG];
    }
    
    [self.MainViewController.view.layer setTransform:rotationTransformMain];
    
}

//  设置初始位置 是否需要动画
-(void)PB_SetInitialPositionAnimation:(BOOL)YorN{
    
    if (YorN==NO)
    {
//  设置RightVc位置
    [self RightVCPosion:KINITIAL];
//  设置MainVc位置
    [self MainVCPosion:KINITIAL];
    }
//  如果有动画
    else{
//
        PB_BlackViewController *blackVC=(PB_BlackViewController *) [self.MainViewController.viewControllers objectAtIndex:0];
        if ([blackVC.childViewControllers count]==2) {
            

            if ([[blackVC.childViewControllers objectAtIndex:1]isKindOfClass:[PB_FirstDetailSOSViewController class] ]) {
//                Class Getclass=[[blackVC.childViewControllers objectAtIndex:1]class];
//                Getclass *detailVC=(Getclass *)[blackVC.childViewControllers objectAtIndex:1];

                PB_FirstDetailSOSViewController *detailVC=(PB_FirstDetailSOSViewController *)[blackVC.childViewControllers objectAtIndex:1];
        
                detailVC.panG.enabled=YES;
                detailVC.tableView.scrollEnabled=YES;
                detailVC.popPan=NO;
                detailVC.MainPan=NO;

            }
            else if ([[blackVC.childViewControllers objectAtIndex:1]isKindOfClass:[PB_InfoViewController class]]){
            
                PB_InfoViewController *infoVC=(PB_InfoViewController *)[blackVC.childViewControllers objectAtIndex:1];
                
                infoVC.panG.enabled=YES;
                infoVC.popPan=NO;
                infoVC.MainPan=NO;

            
            }
            else{
                PB_MessageViewController *messageVC=(PB_MessageViewController *)[[[blackVC.childViewControllers objectAtIndex:1]viewControllers]objectAtIndex:0];
//                
              messageVC.panG.enabled=YES;
                messageVC.tableView.scrollEnabled=YES;
                messageVC.popPan=NO;
                messageVC.MainPan=NO;
//
            
            
            }
                            }
        
        PB_BlackSViewController *blacksVC=(PB_BlackSViewController *) [self.MainViewController.viewControllers objectAtIndex:2];
        if ([blacksVC.childViewControllers count]==2) {
            
            
            PB_ThirdGroupDetailViewController *detailVC=(PB_ThirdGroupDetailViewController *)[blacksVC.childViewControllers objectAtIndex:1];
            detailVC.panG.enabled=YES;
            detailVC.popPan=NO;
            detailVC.MainPan=NO;
        }

    [UIView animateWithDuration:0.3 animations:^{
    [self RightVCPosion:KINITIAL];
    [self MainVCPosion:KINITIAL];


    } completion:^(BOOL finished) {
        
    }];
     
    }
}
-(void)PB_SetTargetLocationAnimation:(BOOL)YorN{
    if (YorN==NO) {
    [self RightVCPosion:KTARGET];
    [self MainVCPosion:KTARGET];
       
    }
    else{
    [UIView animateWithDuration:0.3 animations:^{
    [self RightVCPosion:KTARGET];
    [self MainVCPosion:KTARGET];
    
    } completion:^(BOOL finished) {
        
    }];
    
    
    }
   
}
-(void)PB_SetCurrentLocation:(CGFloat)changeX {
    //
    LeftorRight=userThink-changeX;
    userThink=changeX;
    
    CATransform3D rotationTransformRight = CATransform3DIdentity;
    rotationTransformRight.m34 = -1.0f/600.0f;
    CATransform3D rotationTransformMain = CATransform3DIdentity;
    rotationTransformMain.m34 = -1.0f/600.0f;
//  手指只能滑动300单位的距离
    if(changeX<=-300){
    changeX=-300;
    }
    float RightVCChangeX=400+changeX;
    float RightVCChangeScaleHX=KSCREEM_HEIGHT*(0.1+(0.1*changeX/300));
    rotationTransformMain.m11=1+0.15*changeX/300;
    rotationTransformMain.m22=1+0.15*changeX/300;

    K_GETFRAME(self.RightViewController.view, RightVCChangeX, RightVCChangeScaleHX, KSCREEM_WIDTH*(0.8-0.2*changeX/300),(KSCREEM_HEIGHT-2*RightVCChangeScaleHX));
    rotationTransformRight = CATransform3DRotate(rotationTransformRight,(45.0f+changeX/(300/45.0f)) * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
    [self.RightViewController.view.layer setTransform:rotationTransformRight];
//  从Main的初始的位置到目标位置的距离 用300单位的移动去改变
    float MainVCChangeX=(((KSCREEM_WIDTH/2)+80)/300)*changeX+KSCREEM_WIDTH/2;
    rotationTransformMain = CATransform3DRotate(rotationTransformMain,-(changeX/10) * M_PI / 180.0f , 0.0f, 1.0f, 0.0f);
     
    K_GETCENTER(self.MainViewController.view,MainVCChangeX, KSCREEM_HEIGHT/2);
    [self.MainViewController.view.layer setTransform:rotationTransformMain];
// 是判断哪个位置需要反弹或保持
    criticalX=MainVCChangeX;

    
}


#define GestureRecognizer_PanMethod
-(void)PB_PanAction:(UIPanGestureRecognizer *)pan
{
    
    if (self.popViewCloseAnimation==NO) {
        
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
//当手势Begin
            self.startPoint=[pan translationInView:self.view];
            
            break;
        case UIGestureRecognizerStateChanged:
        {
//当手势的位置在4/5个屏幕右侧点击 触发可以移动的开关
            if ([pan locationInView:self.view].x>KSCREEM_WIDTH*0.8&&backMove==NO) {
            allowMove=KCANMOVE;
            }
            else if ([pan locationInView:self.view].x<KSCREEM_WIDTH*0.2&&backMove==YES){
            allowMove=KCANMOVE;
            }
            else if ([pan locationInView:self.view].x>KSCREEM_WIDTH*0.2&&backMove==YES){
                CGPoint currentPoint=[pan translationInView:self.view];
                CGFloat DeltaX=currentPoint.x-self.startPoint.x;

                LeftorRight=userThink-DeltaX;
                userThink=DeltaX;
                specialMove=YES;
            
            }

//然后根据可出发开关和是否是回弹的状态的判断 来决定是否出发移动
            if (allowMove==KCANMOVE) {
//获取目前移动了多少位置减去刚点击时候移动的位置 获得共移动的位置
            CGPoint currentPoint=[pan translationInView:self.view];
            CGFloat DeltaX=currentPoint.x-self.startPoint.x;
            CGFloat ChangeX;
                if (backMove==NO) {
//当从出发向右移动最大值为0
                 ChangeX=MAX(-DeltaX, 0);
//设置移动变化的值  代入方法 根据view的center设置位置
                  }
                else{
//从300开始减 最大值是300
                CGFloat changeX=MIN(300-DeltaX, 300);
                ChangeX=MAX(changeX, 0);

                }
                
                if (ChangeX!=0&&ChangeX!=300) {
                isMoving=YES;
                }
                

                [self PB_SetCurrentLocation:-ChangeX];
                
           
            }
                       break;
        }
        case UIGestureRecognizerStateEnded:
        {
            BOOL wantMove;
//根据倒数两点的位置判断用户期望的走向
           wantMove=(LeftorRight>=0)?KWANNALEFT:KWANNARIGHT;
//判断是哪个状态  itot or ttoi
//如果是特别的move 让他向右移动 因为当主页面的时候 不合适在除了大于0.8的地方有类似swipe手势
//而当页面在左侧的时候期望有个能不移动页面的地方 swipe效果
            if (specialMove==YES) {
                specialMove=NO;

                if (wantMove==KWANNARIGHT) {
                    [self PB_EndPanSetInitialP];

                }
            }
//普通的情况  当移动运行的情况下 而且图片已经开始移动
            if (allowMove==KCANMOVE) {
            }
            if (((allowMove==KCANMOVE)&&(isMoving==YES))) {
                isMoving=NO;
// 当页面在左侧的时候
            if(backMove){
//如果零界点在55 判断走向 不可逆
                (criticalX>=55)?[self PB_EndPanSetInitialP]:[self PB_EndPanSetTargetL];
            
            }
            else if(backMove==NO){

//如果零界点在5 （大概屏幕左侧1/3的位置）判断走向 此时不可逆的
                    if (criticalX<=5) {
                        [self PB_EndPanSetTargetL];
                    }
//这个情况是可逆的 判断期望走向决定走向
                else{
                    
                    if (wantMove==KWANNARIGHT) {
                        [self PB_EndPanSetInitialP];
                    }
                    else{
                        [self PB_EndPanSetTargetL];
                         }
                    }
                }
            }
                        break;}
        case UIGestureRecognizerStateCancelled:
        {
//取消就还原
            [self PB_EndPanSetInitialP];
        }
            break;
            
        default:
            break;
    }

    }
}
-(void)PB_EndPanSetInitialP{
    
      UIViewController *vc= self.MainViewController.selectedViewController;
    vc.view.userInteractionEnabled=YES;
    allowMove=KLIMITMOVE;
    backMove=NO;
    [self PB_SetInitialPositionAnimation:YES];
  
}
-(void)PB_EndPanSetTargetL{
    UIViewController *vc= self.MainViewController.selectedViewController;
    vc.view.userInteractionEnabled=NO;
    allowMove=KLIMITMOVE;
    
    backMove=YES;
    [self PB_SetTargetLocationAnimation:YES];
}
#define GestureRecognizer_TapMethod
-(void)PB_TapBack:(UITapGestureRecognizer *)tap{
    isMoving=NO;
    [self PB_EndPanSetInitialP];
    [self.MainViewController.view removeGestureRecognizer:self.tapG];

    UIViewController *vc= self.MainViewController.selectedViewController;
    vc.view.userInteractionEnabled=YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
