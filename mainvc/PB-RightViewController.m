//
//  PB-RightViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-RightViewController.h"
#define KSCREEM_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define KSCREEM_WIDTH      [UIScreen mainScreen].bounds.size.width
#import "UserDB.h"
#import "UserModal.h"
#import "ViewController.h"
@interface PB_RightViewController ()

@end

@implementation PB_RightViewController{
    UserDB *userDB;

}

- (void)viewDidLoad {
    [super viewDidLoad];
       userDB=[[UserDB alloc]init];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)logOut:(UIButton *)sender {
//    UserModal *modal=[UserModal alloc];
//    modal.userName=@"yang";
//    
//    [userDB deleteUser:modal];
    
    ViewController *mainVC=(ViewController *)self.parentViewController;
    [mainVC PB_EndPanSetInitialP];
    PB_TabBarMenuViewController *tabVC=(PB_TabBarMenuViewController *)mainVC.MainViewController;
    tabVC.selectedIndex=0;
    
    
}
@end
