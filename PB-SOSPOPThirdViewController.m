//
//  PB-SOSPOPThirdViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/25.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPThirdViewController.h"

@interface PB_SOSPOPThirdViewController ()

@end

@implementation PB_SOSPOPThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)popVC:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)completeAction:(UIButton *)sender {
    
}
- (IBAction)ifPayAction:(UIButton *)sender {
    UIActionSheet *ifPay=[[UIActionSheet alloc]initWithTitle:@"给予救助者费用报销" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"必须的" otherButtonTitles:@"算了吧", nil];
    ifPay.tag=1;
    [ifPay showInView:self.view];
}

- (IBAction)bloodReason:(UIButton *)sender {
    UIActionSheet *reason=[[UIActionSheet alloc]initWithTitle:@"缺血原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"紧急缺血" otherButtonTitles:@"怀孕备血", nil];
    reason.tag=2;
    [reason showInView:self.view];

}

- (IBAction)backVC:(UIBarButtonItem *)sender
{
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"是否保存下次使用？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:@"不保存", nil];
    [action showInView:self.view];
    

}

    

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIButton *ifPayB=(UIButton *)[self.view viewWithTag:111];
     UIButton *bloodReaB=(UIButton *)[self.view viewWithTag:222];
    if (actionSheet.tag==1) {
        if (buttonIndex==0) {
            [ifPayB setTitle:@"给予报销" forState:UIControlStateNormal];
            
        }
        else if (buttonIndex==1){
            [ifPayB setTitle:@"不给予报销" forState:UIControlStateNormal];

        
        }
    }
    else  if(actionSheet.tag==2){
        if (buttonIndex==0) {
            [bloodReaB setTitle:@"紧急缺血" forState:UIControlStateNormal];
        }
        else if (buttonIndex==1){
            [bloodReaB setTitle:@"怀孕备血" forState:UIControlStateNormal];

            
        }

    
    
    }
    else{
        if (buttonIndex==0) {
            
        }
        else if (buttonIndex==1){
            
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
}
    
    
    


}

@end
