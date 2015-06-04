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
#import "PostInfo.h"

@interface PB_SOSPOPSecondViewController ()

@end

@implementation PB_SOSPOPSecondViewController{
 UIImagePickerController *myPickerController;
    NSMutableArray *imageCollection;
    BOOL allowMove;
    CGPoint lastPoint;
    CGPoint recordMove;
    MBProgressHUD *HUD;
    PostInfo *postInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
    imageCollection=[NSMutableArray arrayWithCapacity:3];
//    设置文字框的边框
   
//    设置添加照片的按钮
    UIButton *addImageButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 400, 90, 90)];
    addImageButton.tag=304;
    addImageButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [addImageButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addImageButton];

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



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==666) {
        if (buttonIndex==1) {
//            确定提交 有个风火轮效果后 提交
            [self showWithLabelMixed];
           
        }
        
    }
    
    
    

}



- (IBAction)backVC:(UIBarButtonItem *)sender {
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"是否保存下次使用？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:@"不保存", nil];
    [action showInView:self.view];
    
}

- (IBAction)nextStep:(UIButton *)sender {
    postInfo=[PostInfo defaultManager];
//    [postInfo saveInfoSTelephoneN:self.telepN1.text  Telep2:self.telepN2.text BloodVolume:self.bloodVolume.text ImageArray:imageCollection];
    [self performSegueWithIdentifier:@"nextStep2" sender:nil];
}

-(IBAction)recoverKeyboard:(UIControl *)sender {
    }

- (IBAction)popVC:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//添加图片选择
- (void)addImage:(UIButton *)sender {
    UIActionSheet *choosePhotoType=[[UIActionSheet alloc]initWithTitle:@"获取情况照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    choosePhotoType.tag=1;
 [choosePhotoType showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1) {
        
    
    if (buttonIndex==0) {
        [self  takePhotopicker];
    }
    else if (buttonIndex==1){
        [self photoFromAlbum];
        
    }}
    else{
        if (buttonIndex==0) {
            
        }
        else if (buttonIndex==1){
            
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];

    
    
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
//在拍照完成后添加图片  根据图片数量判断是否还需添加图片框 并且给予相应的动画
-(void)addImageV:(UIImage *)image{
    
    float imageCount=[imageCollection count];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(20+100*imageCount, 400, 90, 90)];
    imageV.image=image;
    imageV.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *longImage=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
    [longImage setMinimumPressDuration:0.8f];
    [longImage setAllowableMovement:50.0];
    [imageV addGestureRecognizer:longImage];
    [self.view addSubview:imageV];
    imageV.tag=301+imageCount;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *addImageB=(UIButton *)[self.view viewWithTag:304];
        if (imageCount<2) {
            
            [addImageB setFrame:CGRectMake(20+100*(imageCount+1), 400, 90, 90)];
        }
        else{
           addImageB.hidden=YES;
            
            
        }
    } completion:^(BOOL finished) {
        
    }];
    [imageCollection addObject:image];
    
}

//长按键的效果  点击相应时间开始触发动画
-(void)longAction:(UILongPressGestureRecognizer *)longG{
    CGPoint firstImageP=CGPointMake(65, 445);
    CGPoint  secondImageP=CGPointMake(165, 445);
    CGPoint  thirdImageP=CGPointMake(265, 445);
    UIImageView *imageS=(UIImageView *)[self.view viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.view viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.view viewWithTag:301];
//    还没开始移动
    if (allowMove==NO) {
//  弹出回收按钮
        UIImageView *wasteBasket=[[UIImageView alloc]initWithFrame:CGRectMake(-66, 425, 66, 40)];
        
        wasteBasket.backgroundColor=[UIColor redColor];
        wasteBasket.tag=300;
        [self.view addSubview:wasteBasket];
//  同时 图片变大可以进行移动
        [UIView animateWithDuration:0.3 animations:^{
            [longG.view setBounds:CGRectMake(longG.view.bounds.origin.x, longG.view.bounds.origin.y, longG.view.bounds.size.width*1.2, longG.view.bounds.size.height*1.2)];
            [self.view bringSubviewToFront:longG.view];
            recordMove=[longG locationInView:self.view];
            recordMove=CGPointMake(recordMove.x-longG.view.center.x,recordMove.y-longG.view.center.y);
            
            allowMove=YES;
            
            [wasteBasket setFrame:CGRectMake(0, 425, 66, 40)];
        } completion:^(BOOL finished) {
            
            
            
        }];
    }
//    当图片开始移动
    else if(allowMove){
        
        float imageCount=[imageCollection count];
        
        lastPoint=[longG locationInView:self.view];
        longG.view.center=CGPointMake(lastPoint.x-recordMove.x, lastPoint.y-recordMove.y);
        UIImageView *wasteBasket=(UIImageView *)[self.view viewWithTag:300];
//        如果移动的事第一个图片
        if (longG.view.tag==301) {
//            判断其位置 给出相应的动画 如果在大于250的位置 图片二三都需向左移动
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
//        同理 移动图片二也是同样的效果
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
//       但当试图进入这个范围 也就是回收按钮的位置 回收按钮变大 图片变透明 如果在这个位置放手 图片则被删除
        if (lastPoint.x<66&&lastPoint.x>0) {
            if (lastPoint.y<485&&lastPoint.y>425) {
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
//    当手势结束的时候调用
    if (longG.state==UIGestureRecognizerStateEnded) {
//        在回收按钮的范围 触发删除图片的动画 否则只执行改变顺序 和tag的方法
        if (lastPoint.x<66&&lastPoint.x>0) {
            
            [self performSelector:@selector(delayDeleteMove:) withObject:longG.view afterDelay:0.5];
            
        }
        else{
            [self performSelector:@selector(delayEndMove:) withObject:longG.view afterDelay:0.5];
            
        }
        
    }
    
    
}
//删除图片的方法
-(void)delayDeleteMove:(UIImageView *)longV{
    CGPoint firstImageP=CGPointMake(65, 445);
    CGPoint  secondImageP=CGPointMake(165, 445);
    //    CGPoint  thirdImageP=CGPointMake(265+self.frame.size.width, 175);
    UIButton *addImageButton=(UIButton *)[self.view viewWithTag:304];
    UIImageView *imageS=(UIImageView *)[self.view  viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.view  viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.view  viewWithTag:301];
    
    float imageCount=[imageCollection count];
//    当触发的事第一个图片 然后根据可能存在的图片数 给出相应的动画  然后remove自己
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
//    在删除后 回收按钮同时动画移除
    UIImageView *wasteBasket=(UIImageView *)[self.view  viewWithTag:300];
    
    [UIView animateWithDuration:0.2 animations:^{
        [wasteBasket setFrame: CGRectMake(-66, 425, 66, 40)];
        [longV removeFromSuperview];
        [imageCollection removeObjectAtIndex:longV.tag-301];
        
        
    } completion:^(BOOL finished) {
        [wasteBasket removeFromSuperview];
    }];
    
    
    allowMove=NO;
    
    
    
}
//结束移动的方法
-(void)delayEndMove:(UIImageView *)longV{
    NSString *firstImagex=[NSString stringWithFormat:@"%f",65.0f ];
    NSString *secondImagex=[NSString stringWithFormat:@"%f",165.0f ];
    NSString *thirdImagex=[NSString stringWithFormat:@"%f",265.0f ];
    
    
    UIImageView *imageS=(UIImageView *)[self.view  viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[self.view  viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[self.view  viewWithTag:301];
    float imageCount=[imageCollection count];
    
//   假设移动的事第一个tag的图片 可以知道其他图片所在的位置 然后根据所在的位置给他们相应这个位置的tag 然后移动的图片到空缺位置的地方
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
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 445)];
                
            }];
            
        }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * secondImageX=[NSString stringWithFormat:@"%f",imageS.center.x
                                     ];
            imageS.tag=[numberArray indexOfObject:secondImageX]+301;
            longV.tag=603-imageS.tag;
            
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 445)];
                
            }];
            
            
        }
        else if (imageCount==1){
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake(65, 445)];
                
            }];
            
            
        }
        
    }
    
//  与上同理  根据不同的图片数 给予不同的动画
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
             [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 445)];
                
            }];
            
            
            
            
        }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * firstImageX=[NSString stringWithFormat:@"%f",imageF.center.x
                                    ];
            imageF.tag=[numberArray indexOfObject:firstImageX]+301;
            longV.tag=603-imageF.tag;
            
            [UIView animateWithDuration:0.2 animations:^{
               [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 445)];
                
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
            [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 445)];
            
        }];
        
        
        
        
        
        
        
    }
    UIImageView *wasteBasket=(UIImageView *)[self.view  viewWithTag:300];
    
    [UIView animateWithDuration:0.2 animations:^{
        [wasteBasket setFrame: CGRectMake(-66, 425, 66, 40)];
        longV.alpha=1;
        [longV setBounds:CGRectMake(longV.bounds.origin.x, longV.bounds.origin.y, 90, 90)];
        [self.view  sendSubviewToBack:longV];
        
    } completion:^(BOOL finished) {
        [wasteBasket removeFromSuperview];
    }];
    
    
    allowMove=NO;
    
}
//加载这个风火轮的view
- (void)showWithLabelMixed {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate=self;
    //    HUD.labelText = @"Connecting";
    //    HUD.minSize = CGSizeMake(135.f, 135.f);
    
    [HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}
//给定风火轮的样式 以及切换的时间（根据上传的时间而定）结束后上传成功 回收vc
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
//    传好回调
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
   }

-(void)chooseLocation{

    [self performSegueWithIdentifier:@"locationVC" sender:nil];
    

}

@end
