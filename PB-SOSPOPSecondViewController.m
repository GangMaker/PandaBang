//
//  PB-SOSPOPSecondViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPSecondViewController.h"
#import "MBProgressHUD.h"
#import <unistd.h>
#import "NSString+Valid.h"
@interface PB_SOSPOPSecondViewController ()

@end

@implementation PB_SOSPOPSecondViewController{
 UIImagePickerController *myPickerController;
    NSMutableArray *imageCollection;
    BOOL allowMove;
    CGPoint lastPoint;
    CGPoint recordMove;
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageCollection=[NSMutableArray arrayWithCapacity:3];
    self.textView.layer.borderColor=[UIColor blackColor].CGColor;
    self.textView.layer.borderWidth=1.0f;
    UIButton *addImageButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 20, 90, 90)];
    addImageButton.tag=304;
    addImageButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [addImageButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBackView addSubview:addImageButton];

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



- (IBAction)publishS:(UIBarButtonItem *)sender {
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"注意" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    
}

-(IBAction)recoverKeyboard:(UIControl *)sender {
     [self.textView resignFirstResponder];
}
- (void)addImage:(UIButton *)sender {
    UIActionSheet *choosePhotoType=[[UIActionSheet alloc]initWithTitle:@"获取情况照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
 [choosePhotoType showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self  takePhotopicker];
    }
    else if (buttonIndex==1){
        [self photoFromAlbum];
        
    }
}

-(void)createMyPickerController:(UIImagePickerControllerSourceType )sourceType{
    if (myPickerController==nil) {
        
        
        myPickerController=[[UIImagePickerController alloc]init];
        
        myPickerController.delegate=self;
        //    能否允许编辑
        myPickerController.allowsEditing = YES;
        myPickerController.sourceType=sourceType;
        
    }
    
}


//拍照
-(void)takePhotopicker{
    [self createMyPickerController:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:myPickerController animated:YES completion:^{ }];
    
}
//照片库取照片
-(void)photoFromAlbum{
    
    //    能否允许编
    [self createMyPickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    
    
    [self presentViewController:myPickerController animated:YES completion:^{ }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    [self addImageV:image];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)addImageV:(UIImage *)image{
    
    float imageCount=[imageCollection count];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(20+100*imageCount, 20, 90, 90)];
    imageV.image=image;
    imageV.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *longImage=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
    [longImage setMinimumPressDuration:0.8f];
    [longImage setAllowableMovement:50.0];
    [imageV addGestureRecognizer:longImage];
    [self.imageBackView addSubview:imageV];
    imageV.tag=301+imageCount;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *addImageB=(UIButton *)[self.imageBackView viewWithTag:304];
        if (imageCount<2) {
            
            [addImageB setFrame:CGRectMake(20+100*(imageCount+1), 20, 90, 90)];
        }
        else{
           addImageB.hidden=YES;
            
            
        }
    } completion:^(BOOL finished) {
        
    }];
    [imageCollection addObject:image];
    
}


-(void)longAction:(UILongPressGestureRecognizer *)longG{
    CGPoint firstImageP=CGPointMake(65, 65);
    CGPoint  secondImageP=CGPointMake(165, 65);
    CGPoint  thirdImageP=CGPointMake(265, 65);
    UIImageView *imageS=(UIImageView *)[self.imageBackView viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.imageBackView viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.imageBackView viewWithTag:301];
    
    
    if (allowMove==NO) {
        UIImageView *wasteBasket=[[UIImageView alloc]initWithFrame:CGRectMake(-66, 45, 66, 40)];
        
        wasteBasket.backgroundColor=[UIColor redColor];
        wasteBasket.tag=300;
        [self.imageBackView addSubview:wasteBasket];
        
        [UIView animateWithDuration:0.3 animations:^{
            [longG.view setBounds:CGRectMake(longG.view.bounds.origin.x, longG.view.bounds.origin.y, longG.view.bounds.size.width*1.2, longG.view.bounds.size.height*1.2)];
            [self.imageBackView bringSubviewToFront:longG.view];
            recordMove=[longG locationInView:self.imageBackView];
            recordMove=CGPointMake(recordMove.x-longG.view.center.x,recordMove.y-longG.view.center.y);
            
            allowMove=YES;
            
            [wasteBasket setFrame:CGRectMake(0, 45, 66, 40)];
        } completion:^(BOOL finished) {
            
            
            
        }];
    }
    else if(allowMove){
        
        float imageCount=[imageCollection count];
        
        lastPoint=[longG locationInView:self.imageBackView];
        longG.view.center=CGPointMake(lastPoint.x-recordMove.x, lastPoint.y-recordMove.y);
        UIImageView *wasteBasket=(UIImageView *)[self.imageBackView viewWithTag:300];
        
        if (longG.view.tag==301) {
            
            if (lastPoint.x>150&&lastPoint.x<250) {
                if(imageCount!=1) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageS setCenter:firstImageP];
                    }];
                    
                    
                }
            }
            else if (lastPoint.x>250){
                if (imageCount==2) {
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        [imageS setCenter:firstImageP];
                    }];
                    
                }
                else if (imageCount==3){
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        [imageS setCenter:firstImageP];
                        [imageT setCenter:secondImageP];
                    }];
                    
                    
                }
            }
            
            else if (lastPoint.x<80) {
                
                if(imageCount==2){
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        [imageS setCenter:secondImageP];
                    }];
                    
                    
                }
                else if (imageCount==3){
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageS setCenter:secondImageP];
                    }];
                    
                }
            }
            
            else if (lastPoint.x>=80&&lastPoint.x<180){
                
                if (imageCount==3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageT setCenter:thirdImageP];
                    }];
                    
                }
                
            }
            
            
        }
        else if (longG.view.tag==302){
            
            if (lastPoint.x>250) {
                if (imageCount==3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageF setCenter:firstImageP];
                        [imageT setCenter:secondImageP];
                        
                    }];
                    
                }
            }
            else if (lastPoint.x>150&&lastPoint.x<250){
                
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:firstImageP];
                    [imageT setCenter:thirdImageP];
                }];
                
                
                
            }
            else if (lastPoint.x<80){
                
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:secondImageP];
                    [imageT setCenter:thirdImageP];
                }];
            }
            
            else if (lastPoint.x>=80&&lastPoint.x<180){
                
                
                if (imageCount==3) {
                    [imageT setCenter:thirdImageP];
                }
            }
            
            
        }
        else if(longG.view.tag==303){
            if (lastPoint.x>250) {
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:firstImageP];
                    [imageS setCenter:secondImageP];
                    
                }];
                
                
            }
            else if (lastPoint.x>150&&lastPoint.x<250){
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [imageF setCenter:firstImageP];
                    [imageS setCenter:secondImageP];
                }];
                
                
            }
            else if (lastPoint.x<80){
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [imageF setCenter:secondImageP];
                    [imageS setCenter:thirdImageP];
                }];
                
                
                
            }
            else if (lastPoint.x>=80&&lastPoint.x<180){
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [imageF setCenter:firstImageP];
                    [imageS setCenter:thirdImageP];
                }];
                
                
            }
            
        }
        
        if (lastPoint.x<66&&lastPoint.x>0) {
            if (lastPoint.y<85&&lastPoint.y>45) {
                longG.view.alpha=0.7;
                
                wasteBasket.alpha=0.7;
                [UIView animateWithDuration:0.2 animations:^{
                    [wasteBasket setBounds:CGRectMake(wasteBasket.bounds.origin.x, wasteBasket.bounds.origin.y,80, 50)];
                }];
            }
            
            
            else{
                longG.view.alpha=1;
                wasteBasket.alpha=1;
                [UIView animateWithDuration:0.2 animations:^{
                    [wasteBasket setBounds:CGRectMake(wasteBasket.bounds.origin.x, wasteBasket.bounds.origin.y, 66,44)];
                }];
                
                
            }
        }
    }
    
    if (longG.state==UIGestureRecognizerStateEnded) {
        if (lastPoint.x<66&&lastPoint.x>0) {
            
            [self performSelector:@selector(delayDeleteMove:) withObject:longG.view afterDelay:0.5];
            
        }
        else{
            [self performSelector:@selector(delayEndMove:) withObject:longG.view afterDelay:0.5];
            
        }
        
    }
    
    
}
-(void)delayDeleteMove:(UIImageView *)longV{
    CGPoint firstImageP=CGPointMake(65, 65);
    CGPoint  secondImageP=CGPointMake(165, 65);
    //    CGPoint  thirdImageP=CGPointMake(265+self.frame.size.width, 175);
    UIButton *addImageButton=(UIButton *)[self.imageBackView viewWithTag:304];
    UIImageView *imageS=(UIImageView *)[self.imageBackView  viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.imageBackView  viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.imageBackView  viewWithTag:301];
    
    float imageCount=[imageCollection count];
    
    if (longV.tag==301) {
        if (imageCount==1) {
            
            [UIView animateWithDuration:0.2 animations:^{
                [addImageButton setCenter:firstImageP];
            }];
        }
        else if (imageCount==2){
            [UIView animateWithDuration:0.2 animations:^{
                [imageS setCenter:firstImageP];
                [addImageButton setCenter:secondImageP];
                imageS.tag=301;
                
                
            }];
            
        }
        else if (imageCount==3){
            [UIView animateWithDuration:0.2 animations:^{
                [imageS setCenter:firstImageP];
                [imageT setCenter:secondImageP];
                addImageButton.hidden=NO;
                imageS.tag=301;
                imageT.tag=302;
                
                
            }];
            
        }
        
        
    }
    else if (longV.tag==302){
        if (imageCount==2){
            
            [UIView animateWithDuration:0.2 animations:^{
                [imageF setCenter:firstImageP];
                [addImageButton setCenter:secondImageP];
                
            }];
            
        }
        else if (imageCount==3){
            [UIView animateWithDuration:0.2 animations:^{
                [imageF setCenter:firstImageP];
                
                [imageT setCenter:secondImageP];
                addImageButton.hidden=NO;
                imageT.tag=302;
                
                
            }];
            
        }
        
    }
    else if (longV.tag==303){
        if (imageCount==3){
            
            [UIView animateWithDuration:0.2 animations:^{
                [imageF setCenter:firstImageP];
                
                [imageS setCenter:secondImageP];
                
                addImageButton.hidden=NO;
                
            }];
            
        }
        
        
    }
    UIImageView *wasteBasket=(UIImageView *)[self.imageBackView  viewWithTag:300];
    
    [UIView animateWithDuration:0.2 animations:^{
        [wasteBasket setFrame: CGRectMake(-66, 45, 66, 40)];
        [longV removeFromSuperview];
        [imageCollection removeObjectAtIndex:longV.tag-301];
        
        
    } completion:^(BOOL finished) {
        [wasteBasket removeFromSuperview];
    }];
    
    
    allowMove=NO;
    
    
    
}
-(void)delayEndMove:(UIImageView *)longV{
    NSString *firstImagex=[NSString stringWithFormat:@"%f",65.0f ];
    NSString *secondImagex=[NSString stringWithFormat:@"%f",165.0f ];
    NSString *thirdImagex=[NSString stringWithFormat:@"%f",265.0f ];
    
    
    UIImageView *imageS=(UIImageView *)[self.imageBackView  viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.imageBackView  viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.imageBackView  viewWithTag:301];
    float imageCount=[imageCollection count];
    
    //    CGPoint firstImageP=CGPointMake(65+self.frame.size.width, 175);
    //    CGPoint  secondImageP=CGPointMake(165+self.frame.size.width, 175);
    //    CGPoint  thirdImageP=CGPointMake(265+self.frame.size.width, 175);
    if (longV.tag==301) {
        
        if (imageCount==3) {
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex,thirdImagex, nil];
            
            
            NSString * secondImageX=[NSString stringWithFormat:@"%f",imageS.center.x
                                     ];
            imageS.tag=[numberArray indexOfObject:secondImageX]+301;
            NSString * thirdImageX=[NSString stringWithFormat:@"%f",imageT.center.x
                                    ];
            imageT.tag=[numberArray indexOfObject:thirdImageX]+301;
            
            longV.tag=906-imageS.tag-imageT.tag;
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 65)];
                
            }];
            
        }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * secondImageX=[NSString stringWithFormat:@"%f",imageS.center.x
                                     ];
            imageS.tag=[numberArray indexOfObject:secondImageX]+301;
            longV.tag=603-imageS.tag;
            
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 65)];
                
            }];
            
            
        }
        else if (imageCount==1){
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake(65, 65)];
                
            }];
            
            
        }
        
    }
    
    
    else if (longV.tag==302){
        if (imageCount==3) {
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex,thirdImagex, nil];
            
            
            NSString * firstImageX=[NSString stringWithFormat:@"%f",imageF.center.x ];
            imageF.tag=[numberArray indexOfObject:firstImageX]+301;
            NSString * thirdImageX=[NSString stringWithFormat:@"%f",imageT.center.x
                                    ];
            imageT.tag=[numberArray indexOfObject:thirdImageX]+301;
          
            
            longV.tag=906-imageF.tag-imageT.tag;
            [UIView animateWithDuration:0.2 animations:^{
             [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 65)];
                
            }];
            
            
            
            
        }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * firstImageX=[NSString stringWithFormat:@"%f",imageF.center.x
                                    ];
            imageF.tag=[numberArray indexOfObject:firstImageX]+301;
            longV.tag=603-imageF.tag;
            
            [UIView animateWithDuration:0.2 animations:^{
               [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 65)];
                
            }];
            
        }
    }
    
    else if (longV.tag==303){
        
        NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex,thirdImagex, nil];
        
        
        NSString * firstImageX=[NSString stringWithFormat:@"%f",imageF.center.x
                                ];
        imageF.tag=[numberArray indexOfObject:firstImageX]+301;
        NSString * secondImageX=[NSString stringWithFormat:@"%f",imageS.center.x
                                 ];
        imageS.tag=[numberArray indexOfObject:secondImageX]+301;
        
        longV.tag=906-imageF.tag-imageS.tag;
        [UIView animateWithDuration:0.2 animations:^{
            [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 65)];
            
        }];
        
        
        
        
        
        
        
    }
    UIImageView *wasteBasket=(UIImageView *)[self.imageBackView  viewWithTag:300];
    
    [UIView animateWithDuration:0.2 animations:^{
        [wasteBasket setFrame: CGRectMake(-66, 45, 66, 40)];
        longV.alpha=1;
        [longV setBounds:CGRectMake(longV.bounds.origin.x, longV.bounds.origin.y, 90, 90)];
        [self.imageBackView  sendSubviewToBack:longV];
        
    } completion:^(BOOL finished) {
        [wasteBasket removeFromSuperview];
    }];
    
    
    allowMove=NO;
    
}

- (void)showWithLabelMixed {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate=self;
    //    HUD.labelText = @"Connecting";
    //    HUD.minSize = CGSizeMake(135.f, 135.f);
    
    [HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}
- (void)myMixedTask {
    // Indeterminate mode
    //    sleep(2);
    // Switch to determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        
        //        这里返回上传时间
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
    // Back to indeterminate mode
    // UIImageView is a UIKit class, we have to initialize it on the main thread
    __block UIImageView *imageView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
    });
    HUD.customView = imageView ;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"提交成功";
    sleep(2);
   }



@end
