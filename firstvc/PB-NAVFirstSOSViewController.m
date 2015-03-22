//
//  PB-NAVFirstSOSViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-NAVFirstSOSViewController.h"

@interface PB_NAVFirstSOSViewController ()

@end

@implementation PB_NAVFirstSOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    颜色设置为白色
   self.navigationBar.tintColor=[UIColor blackColor];
    //   去掉原来的毛玻璃效果
   [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault ];
    self.navigationBar.shadowImage=[UIImage new];
//    添加黑色的图片
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"blacknav.png"] forBarMetrics:UIBarMetricsDefault ];

       // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
