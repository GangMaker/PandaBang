//
//  PB-MessageViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/3/6.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-MessageViewController.h"
#import "PB-MessageCell.h"
@interface PB_MessageViewController ()

@end

@implementation PB_MessageViewController
{
    int cellCount;
    CGFloat ChangeX;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    cellCount=10;
    
    self.panG=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:self.panG];


    // Do any additional setup after loading the view.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //    能同时响应多个手势
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"messageCell";
    PB_MessageCell *messageCell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    return messageCell;


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return cellCount;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//电话按钮
-(void)buttonOneAction{

}
//删除按钮
-(void)buttonTwoAction{



}
-(void)panAction:(UIPanGestureRecognizer *)pan{
    ViewController *vc= (ViewController *)self.tabBarController.parentViewController;
    
    self.sosVC=(PB_FirstSOSViewController *)[self.navigationController.parentViewController.childViewControllers objectAtIndex:0];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.startPoint=[pan translationInView:self.navigationController.view];
            
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint=[pan translationInView:self.navigationController.view];
            CGFloat DeltaX=currentPoint.x-self.startPoint.x;
            
            ChangeX=MIN(DeltaX, 375);
            
            if (DeltaX>0&&[pan locationInView:self.navigationController.view].x<KSCREEM_WIDTH*0.8&&self.MainPan==NO) {
                self.popPan=YES;
                vc.panG.enabled=NO;
                self.tableView.scrollEnabled=NO;
                
            }
            if ([pan locationInView:self.navigationController.view].x>KSCREEM_WIDTH*0.8&&DeltaX<0&&self.popPan==NO) {
                self.MainPan=YES;
                self.panG.enabled=NO;
            }
            if (self.popPan==YES&&DeltaX>0) {
                [self.navigationController.view setFrame:CGRectMake(ChangeX, 0, 375, 677)];
                [self.sosVC.view  setTransform:CGAffineTransformScale(self.navigationController.view.transform, 0.95+0.5*ChangeX/3750, 0.95+0.5*ChangeX/3750)];
            }
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            
            if (ChangeX>60&&self.popPan==YES) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self.navigationController.view setFrame:CGRectMake(375, 0, 375, 677)];
                    [self.sosVC.view  setTransform:CGAffineTransformScale(self.navigationController.view.transform, 1, 1)];
                    
                    vc.panG.enabled=YES;
                    
                } completion:^(BOOL finished) {
                    [self.navigationController.view removeFromSuperview];
                    [self.navigationController removeFromParentViewController];
                    
                    
                }];
                
            }
            else if(ChangeX <=60&&self.popPan==YES){
                [UIView animateWithDuration:0.3 animations:^{
                    [self.navigationController.view  setFrame:CGRectMake(0, 0, 375, 677)];
                    [self.sosVC.view  setTransform:CGAffineTransformScale(self.navigationController.view.transform, 0.95, 0.95)];
                    self.popPan=NO;
                    self.MainPan=NO;
                    vc.panG.enabled=YES;
                    self.panG.enabled=YES;
                    self.tableView.scrollEnabled=YES;
                    
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                
                
            }
            
            
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.navigationController.view  setFrame:CGRectMake(0, 0, 375, 677)];
                [self.sosVC.view  setTransform:CGAffineTransformScale(self.navigationController.view.transform, 0.95, 0.95)];
            } completion:^(BOOL finished) {
                
                
            }];}
            
        default:
            break;
    }
    
    
}

#define scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"+++++");
    self.panG.enabled=NO;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.panG.enabled=YES;
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)backVC:(UIBarButtonItem *)sender {
    self.sosVC=(PB_FirstSOSViewController *)[self.navigationController.parentViewController.childViewControllers objectAtIndex:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        //        大小为本视图的1:1大小 不是自身的比例大小
        [self.sosVC.view  setTransform:CGAffineTransformScale(self.navigationController.view .transform, 1, 1)];
        [self.navigationController.view setFrame:CGRectMake(375, 0, 375, 677)];
        
    } completion:^(BOOL finished) {
        [self.navigationController.view removeFromSuperview];
        [self.navigationController removeFromParentViewController];
        
    }];
    

}
@end
