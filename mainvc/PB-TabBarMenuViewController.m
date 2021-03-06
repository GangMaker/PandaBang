//
//  PB-TabBarMenuViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-TabBarMenuViewController.h"
#import "ViewController.h"
#import "PB-NAVLoginViewController.h"
#import "PB-FirstSOSViewController.h"
#import "PB-NAVSOSPViewController.h"
#import "UserDB.h"
#import "UserModal.h"


#define K_GETFROM_STORYBOARD(SBNAME,VCNAME)  [[UIStoryboard storyboardWithName:SBNAME bundle:[NSBundle mainBundle]]     instantiateViewControllerWithIdentifier:VCNAME]

@interface PB_TabBarMenuViewController ()

@end

@implementation PB_TabBarMenuViewController{
UIImagePickerController *myPickerController;
    UIImagePickerController *myPickerControllerHead;
   NSMutableArray *currentLocation;


    UserDB *userDB;
    //   是否已经登入
    UIView *lightView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
//  首页的tabbarvc
    userDB=[[UserDB alloc]init];
    [userDB creatTable];
    UserModal *modal=[[UserModal alloc]init];
    modal.userName=@"yang";
    modal.age=@"20";
    modal.password=@"123456";
    [userDB addUser:modal];
  
//隐藏原来的tabbar
   currentLocation=[NSMutableArray array];

    self.tabBar.hidden=YES;
//自定义一个tabbar
   
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//切换页面的时候调用
-(void)changeTabView:(UIButton *)sender{
//    如果点击的tag1的button 切换第一个页面
    if (sender.tag==1) {
        
        self.selectedIndex=0;
    
}
//    如果点击的tag3的button 切换第二个页面

    else if (sender.tag==3) {
        NSLog(@"++++++%d",self.parentVC.isLogin);

//    首先弹出的是登入页 如果有登入直接换视图
        if ([[userDB findUsers]count]==1) {
            
            NSLog(@"1");
        PB_NAVLoginViewController *loginVC=K_GETFROM_STORYBOARD(@"Main", @"loginVC");
        
        [self presentViewController:loginVC animated:YES completion:^{
            
            self.selectedIndex=1;

            
        }];
        }
        else{
            self.selectedIndex=1;}

    }
    else{
//        弹出navsosvc
        PB_NAVSOSPViewController *navSOS=K_GETFROM_STORYBOARD(@"Main", @"navSOS");
        [self presentViewController:navSOS animated:YES completion:^{
            
            
            
        }];
//关闭显示右边vc的动画
        self.parentVC=(ViewController *)self.parentViewController;
        self.parentVC.popViewCloseAnimation=YES;
    }
    }



#define take PhoteDelegateMethods

-(void)addCell{
   PB_FirstSOSViewController *firstVC=(PB_FirstSOSViewController *) [[[self.viewControllers objectAtIndex:0]childViewControllers]objectAtIndex:0];
    [firstVC  headerrefresh:1];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
