//
//  PB-BlackSViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/3/3.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-BlackSViewController.h"

@interface PB_BlackSViewController ()

@end

@implementation PB_BlackSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#define K_GETFROM_STORYBOARD(SBNAME,VCNAME)  [[UIStoryboard storyboardWithName:SBNAME bundle:[NSBundle mainBundle]]     instantiateViewControllerWithIdentifier:VCNAME]
    PB_ThirdGroupViewController *sosVC= (PB_ThirdGroupViewController *)K_GETFROM_STORYBOARD(@"Main", @"thirdGroup");
    self.thirdGroupVC=sosVC;
    [self.view addSubview:self.thirdGroupVC.view];
    
    [self addChildViewController:self.thirdGroupVC];

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
