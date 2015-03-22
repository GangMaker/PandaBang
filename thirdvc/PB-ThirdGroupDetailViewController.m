//
//  PB-ThirdGroupDetailViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/3/3.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-ThirdGroupDetailViewController.h"
#import "PB-ThirdGroupViewController.h"
#import "ViewController.h"
@interface PB_ThirdGroupDetailViewController ()
{
    CGFloat ChangeX;
}
@end

@implementation PB_ThirdGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panG=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    self.panG.delegate=self;
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
-(void)panAction:(UIPanGestureRecognizer *)pan{
    ViewController *vc= (ViewController *)self.tabBarController.parentViewController;

    self.thirdVC=(PB_ThirdGroupViewController *)[self.parentViewController.childViewControllers objectAtIndex:0];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.startPoint=[pan translationInView:self.view];
            
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint=[pan translationInView:self.view];
            CGFloat DeltaX=currentPoint.x-self.startPoint.x;
            
            ChangeX=MIN(DeltaX, 375);
            
            if (DeltaX>0&&[pan locationInView:self.view].x<KSCREEM_WIDTH*0.8&&self.MainPan==NO) {
                self.popPan=YES;
                vc.panG.enabled=NO;
                
            }
            if ([pan locationInView:self.view].x>KSCREEM_WIDTH*0.8&&DeltaX<0&&self.popPan==NO) {
                self.MainPan=YES;
                self.panG.enabled=NO;
            }
            if (self.popPan==YES&&DeltaX>0) {
                [self.view setFrame:CGRectMake(ChangeX, 0, 375, 677)];
                [self.thirdVC.view  setTransform:CGAffineTransformScale(self. view.transform, 0.95+0.5*ChangeX/3750, 0.95+0.5*ChangeX/3750)];
            }
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            
            
            
            if (ChangeX>60&&self.popPan==YES) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view setFrame:CGRectMake(375, 0, 375, 677)];
                    [self.thirdVC.view  setTransform:CGAffineTransformScale(self.view.transform, 1, 1)];
                    
                    vc.panG.enabled=YES;
                    
                } completion:^(BOOL finished) {
                    [self.view removeFromSuperview];
                    [self removeFromParentViewController];
                    
                    
                }];
                
            }
            else if(ChangeX<=60&&self.popPan==YES){
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view setFrame:CGRectMake(0, 0, 375, 677)];
                    [self.thirdVC.view  setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
                    self.popPan=NO;
                    self.MainPan=NO;
                    vc.panG.enabled=YES;
                    self.panG.enabled=YES;
                    
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                
                
            }
            
            
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.view setFrame:CGRectMake(0, 0, 375, 677)];
                [self.thirdVC.view  setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
            } completion:^(BOOL finished) {
                
                
            }];}
            
        default:
            break;
    }
    
    
}

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

@end
