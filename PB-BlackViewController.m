//
//  PB-BlackViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/2/20.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-BlackViewController.h"
#import "PB-FirstSOSViewController.h"

#define K_GETFROM_STORYBOARD(SBNAME,VCNAME)  [[UIStoryboard storyboardWithName:SBNAME bundle:[NSBundle mainBundle]]     instantiateViewControllerWithIdentifier:VCNAME]
@interface PB_BlackViewController ()

@end

@implementation PB_BlackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PB_FirstSOSViewController *sosVC= (PB_FirstSOSViewController *)K_GETFROM_STORYBOARD(@"Main", @"firstSOS");
    self.firstSOSVC=sosVC;
    [self.view addSubview:self.firstSOSVC.view];
    
    [self addChildViewController:self.firstSOSVC];
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
