//
//  PB-SOSpopView.m
//  PANDA-BANG
//
//  Created by mhand on 15/3/7.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSpopView.h"
#import "PB-TabBarMenuViewController.h"
#import "MBProgressHUD.h"
#import <unistd.h>
#import "NSString+Valid.h"
@implementation PB_SOSpopView
{
    UIScrollView *scrollV;
    float currentPage;
    BOOL allowMove;
    CGPoint lastPoint;
    CGPoint recordMove;
    UITextField *telephoneText;
    UITextField *telephoneTextS;
    UITextField *nameText;
    UIControl *backGroundV;
    UITextView *contentSos;
    MBProgressHUD *HUD;
    UITextField *locationText;
    NSArray *currentlocation;
    NSMutableArray *alertContent;
    UILabel *age;
    UILabel *volume;
    
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self!=nil) {
    }
    
    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
-(void)getAllThings{
    NSLog(@"1");
    if (self.imageCollection==nil) {
        [self initAllControl];
        [self keyboardAddNSNotification];
        
        backGroundV=[[UIControl alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH-40, 707, 40, 40)];
        backGroundV.backgroundColor=[UIColor redColor];
        [backGroundV addTarget:self action:@selector(recoverKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        backGroundV.hidden=YES;
        
        [self.superview addSubview:backGroundV];
        
        
    }

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //    能同时响应多个手势
    
    return YES;
}
-(void)keyboardAddNSNotification{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)aNotification{
    backGroundV.hidden=NO;
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //    根据键盘的高度添加输入框
    [UIView animateWithDuration:0.3 animations:^{
        [backGroundV setFrame:CGRectMake(KSCREEM_WIDTH-40, 667-height-backGroundV.frame.size.height, 40,40)];
    
    } completion:^(BOOL finished) {
        //        将discussinputy变为这个类型最初的状态 在此状态上增减
      
    }];

    
}
-(void)keyboardWillHide:(NSNotification *)aNotification{
    backGroundV.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        [backGroundV setFrame:CGRectMake(KSCREEM_WIDTH-40, 707, 40,40)];
    } completion:^(BOOL finished) {
        backGroundV.hidden=YES;
        
        //        将discussinputy变为这个类型最初的状态 在此状态上增减
        
    }];


}
-(void)recoverKeyboard:(UIControl *)sender{
    [contentSos resignFirstResponder];
    [telephoneText resignFirstResponder];
    [telephoneTextS resignFirstResponder];
    [nameText resignFirstResponder];
    [locationText resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [backGroundV setFrame:CGRectMake(0, 707, 40,40)];
    } completion:^(BOOL finished) {
        backGroundV.hidden=YES;

        //        将discussinputy变为这个类型最初的状态 在此状态上增减
        
    }];

    
}



-(void)setButton:(UIButton *)sender Title:(NSString *)title ActionName:(SEL)aName Color:(UIColor *)color tag:(int)Tag andImage:(UIImage *)image{
    sender.layer.cornerRadius=20;
    sender.layer.masksToBounds=YES;
    [sender setTitle:title forState:UIControlStateNormal];
    [sender addTarget:self action:aName forControlEvents:UIControlEventTouchUpInside];
    sender.tag=Tag;
    [sender setImage:image forState:UIControlStateNormal];
    [sender setBackgroundColor:color];
}

-(void)initAllControl{
    alertContent=[NSMutableArray array];
    self.imageCollection=[NSMutableArray array];

//  求助条的内容展示区
    self.layer.cornerRadius=20;
    self.layer.masksToBounds=YES;
    
    scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 290)];
//    使同样是触摸移动控件不延迟操作
    scrollV.delaysContentTouches=NO;
    scrollV.delegate=self;
    scrollV.contentSize=CGSizeMake(self.frame.size.width*5, 290);
    scrollV.pagingEnabled=YES;
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 290, 130, 30)];
    UIButton *completeButton=[[UIButton alloc]initWithFrame:CGRectMake(180, 290, 130, 30)];
    [self setButton:backButton Title:@"上一步" ActionName:@selector(backPage:) Color:[UIColor redColor] tag:888 andImage:nil];
    [self setButton:completeButton Title:@"下一步" ActionName:@selector(changePage:) Color:[UIColor redColor]tag:666 andImage:nil];
    [self addSubview:scrollV];
    [self addSubview:completeButton];
    [self addSubview:backButton];

//    在page1的时候
    UIButton *headButton=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width+20, 20, 60, 60)];
    [self setButton:headButton Title:nil ActionName:@selector(chooseHead:) Color:[UIColor redColor] tag:101 andImage:nil];
    UIButton *sexButton=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width+20, 110, 60, 60)];
    
    [self setButton:sexButton Title:@"男" ActionName:@selector(chooseSex:) Color:[UIColor redColor] tag:102 andImage:nil];

    UIButton *bloodButton=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width+20, 200, 60, 60)];
    [self setButton:bloodButton Title:@"A" ActionName:@selector(chooseBlood:) Color:[UIColor redColor] tag:103 andImage:nil];
    [scrollV addSubview:sexButton];
  age=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width+220, 70, 50, 50)];
   age.text=@"0岁";
       UISlider *ageSlider=[[UISlider alloc]initWithFrame:CGRectMake(self.frame.size.width+100, 110, 200, 60)];
    [ageSlider addTarget:self action:@selector(ageChange:) forControlEvents:UIControlEventValueChanged];
    ageSlider.maximumValue=1;
    ageSlider.minimumValue=0;
   volume=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width+220, 160, 90, 50)];
volume.text=@"0毫升";
    UISlider *bloodVolume=[[UISlider alloc]initWithFrame:CGRectMake(self.frame.size.width+100, 200, 200, 60)];
    bloodVolume.maximumValue=1;
    bloodVolume.minimumValue=0;
    
    [bloodVolume addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventValueChanged];

    nameText=[[UITextField alloc]initWithFrame:CGRectMake(self.frame.size.width+100, 30, 200, 40)];
    nameText.layer.borderColor=[UIColor grayColor].CGColor;
    nameText.layer.borderWidth=1;
    nameText.borderStyle=UITextBorderStyleLine;
    nameText.placeholder=@"输入姓名";
    nameText.clearButtonMode=UITextFieldViewModeWhileEditing;

    
    [scrollV addSubview:age];
    [scrollV addSubview:volume];
    [scrollV addSubview:headButton];
    [scrollV addSubview:bloodButton];
    [scrollV addSubview:ageSlider];
    [scrollV addSubview:bloodVolume];
    [scrollV addSubview:nameText];
    
// page2的时候
    PB_TabBarMenuViewController *tabMVC=(PB_TabBarMenuViewController *)self.delegate;
//    currentlocation=[NSArray arrayWithArray:tabMVC.currentLocation];
    currentlocation=@[@"浙江",@"舟山",@"定海"];
    UIButton *locationButton=[[UIButton alloc]initWithFrame:CGRectMake(2*self.frame.size.width+20, 20, 90, 90)];
    [self setButton:locationButton Title:nil ActionName:@selector(chooseLocation:) Color:[UIColor redColor] tag:201 andImage:nil];
    locationText=[[UITextField alloc]initWithFrame:CGRectMake(25, 30, 50, 30)];
    locationText.text=[currentlocation objectAtIndex:0];
    locationText.borderStyle=UITextBorderStyleNone;
    locationText.enabled=NO;
      [locationButton addSubview:locationText];
//    另提个改textfield
    telephoneText=[[UITextField alloc]initWithFrame:CGRectMake(2*self.frame.size.width+130, 23, 180, 40)];
    telephoneText.borderStyle=UITextBorderStyleLine;
    telephoneText.layer.borderColor=[UIColor grayColor].CGColor;
   telephoneText.layer.borderWidth=1;
    telephoneText.placeholder=@"输入电话";
    telephoneText.keyboardType=UIKeyboardTypeNumberPad;
   telephoneTextS=[[UITextField alloc]initWithFrame:CGRectMake(2*self.frame.size.width+130, 73, 180, 40)];
    telephoneTextS.borderStyle=UITextBorderStyleLine;
    telephoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
    telephoneTextS.clearButtonMode=UITextFieldViewModeWhileEditing;

    telephoneTextS.layer.borderColor=[UIColor grayColor].CGColor;
    telephoneTextS.layer.borderWidth=1;
   telephoneTextS.placeholder=@"输入备用电话/没有为空";
    telephoneTextS.keyboardType=UIKeyboardTypeNumberPad;

    
    
    UIButton *addImageButton=[[UIButton alloc]initWithFrame:CGRectMake(2*self.frame.size.width+20, 150, 90, 90)];
    [self setButton:addImageButton Title:@"+" ActionName:@selector(addImage:) Color:[UIColor groupTableViewBackgroundColor] tag:304 andImage:nil];
    [scrollV addSubview:addImageButton];
    [scrollV addSubview:telephoneTextS];
    [scrollV addSubview:telephoneText];
    [scrollV addSubview:locationButton];
//   page3的时候
   contentSos=[[UITextView alloc]initWithFrame:CGRectMake(3*self.frame.size.width+20, 40, 295, 220)];
    contentSos.backgroundColor=[UIColor whiteColor];
    contentSos.layer.borderColor=UIColor.grayColor.CGColor;
    contentSos.layer.borderWidth=1;
    
    [scrollV addSubview:contentSos];
    
    


}
-(void)ageChange:(UISlider *)sender{
    age.text=[NSString stringWithFormat:@"%.0f岁",sender.value*100];

}
-(void)volumeChange:(UISlider *)sender{
    NSString *volumeN=[NSString stringWithFormat:@"%.0f",sender.value*100];
   int volumeNN=[volumeN floatValue];
    volume.text=[NSString stringWithFormat:@"%d毫升",volumeNN*100];

    
}

-(void)getHead:(UIImage *)image{
    UIButton *headButton=(UIButton *)[self viewWithTag:101];
    [headButton setImage:image forState:UIControlStateNormal];

}

-(void)addImage:(UIButton *)sender{
    [telephoneText resignFirstResponder];
    [telephoneTextS resignFirstResponder];
    UIActionSheet *choosePhotoType=[[UIActionSheet alloc]initWithTitle:@"获取情况照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    [choosePhotoType showInView:self.superview];
    choosePhotoType.tag=22;

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==22) {
        if (buttonIndex==0) {
            [self.delegate takePhotopicker:NO];
        }
        else if (buttonIndex==1){
            [self.delegate photoFromAlbum:NO];
            
        }
        
    }
    else if (actionSheet.tag==33){
    if (buttonIndex==0) {
        [self.delegate takePhotopicker:YES];
               }
    else if (buttonIndex==1){
        [self.delegate photoFromAlbum:YES];
    
    }
    
    }


}
-(void)addImageV:(UIImage *)image{
    
    float imageCount=[self.imageCollection count];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(2*self.frame.size.width+20+100*imageCount, 130, 90, 90)];
    imageV.image=image;
    imageV.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *longImage=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
    [longImage setMinimumPressDuration:0.8f];
    [longImage setAllowableMovement:50.0];
    [imageV addGestureRecognizer:longImage];

    imageV.tag=301+imageCount;
    [scrollV addSubview:imageV];
   
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *addImageButton=(UIButton *)[self viewWithTag:304];
        
        if (imageCount<2) {
            [addImageButton setFrame:CGRectMake(2*self.frame.size.width+20+100*(imageCount+1), 130, 90, 90)];}
        else{
            addImageButton.hidden=YES;
            
            
        }
    } completion:^(BOOL finished) {
        
    }];
    [self.imageCollection addObject:image];
 
}
-(void)longAction:(UILongPressGestureRecognizer *)longG{
    CGPoint firstImageP=CGPointMake(65+2*self.frame.size.width, 175);
    CGPoint  secondImageP=CGPointMake(165+2*self.frame.size.width, 175);
    CGPoint  thirdImageP=CGPointMake(265+2*self.frame.size.width, 175);
    UIImageView *imageS=(UIImageView *)[scrollV viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[scrollV viewWithTag:303];

    UIImageView *imageF=(UIImageView *)[scrollV viewWithTag:301];


    if (allowMove==NO) {
        UIImageView *wasteBasket=[[UIImageView alloc]initWithFrame:CGRectMake(2*self.frame.size.width-66, 155, 66, 40)];

     wasteBasket.backgroundColor=[UIColor redColor];
        wasteBasket.tag=300;
        [scrollV addSubview:wasteBasket];
    
[UIView animateWithDuration:0.3 animations:^{
    [longG.view setBounds:CGRectMake(longG.view.bounds.origin.x, longG.view.bounds.origin.y, longG.view.bounds.size.width*1.2, longG.view.bounds.size.height*1.2)];
    [scrollV bringSubviewToFront:longG.view];
    recordMove=[longG locationInView:scrollV];
    recordMove=CGPointMake(recordMove.x-longG.view.center.x,recordMove.y-longG.view.center.y);

    allowMove=YES;
   
    [wasteBasket setFrame:CGRectMake(2*self.frame.size.width, 155, 66, 40)];
    } completion:^(BOOL finished) {
       

    
}];
    }
    else if(allowMove){

        float imageCount=[self.imageCollection count];

        lastPoint=[longG locationInView:scrollV];
        longG.view.center=CGPointMake(lastPoint.x-recordMove.x, lastPoint.y-recordMove.y);
        UIImageView *wasteBasket=(UIImageView *)[scrollV viewWithTag:300];

        if (longG.view.tag==301) {

            if (lastPoint.x>150+2*self.frame.size.width&&lastPoint.x<250+2*self.frame.size.width) {
                 if(imageCount!=1) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageS setCenter:firstImageP];
                    }];
                

                }
                                         }
            else if (lastPoint.x>250+2*self.frame.size.width){
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
            
               else if (lastPoint.x<80+2*self.frame.size.width) {

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
                
               else if (lastPoint.x>=80+2*self.frame.size.width&&lastPoint.x<180+2*self.frame.size.width){
               
                   if (imageCount==3) {
                       [UIView animateWithDuration:0.2 animations:^{
                           [imageT setCenter:thirdImageP];
                       }];

                                         }
               
               }
            
            
        }
        else if (longG.view.tag==302){
        
            if (lastPoint.x>250+2*self.frame.size.width) {
                if (imageCount==3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [imageF setCenter:firstImageP];
                        [imageT setCenter:secondImageP];

                    }];

                }
            }
            else if (lastPoint.x>150+2*self.frame.size.width&&lastPoint.x<250+2*self.frame.size.width){
            
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:firstImageP];
                    [imageT setCenter:thirdImageP];
                }];

            
            
            }
            else if (lastPoint.x<80+2*self.frame.size.width){
            
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:secondImageP];
                    [imageT setCenter:thirdImageP];
                }];
            }
        
            else if (lastPoint.x>=80+2*self.frame.size.width&&lastPoint.x<180+2*self.frame.size.width){
                
                
                if (imageCount==3) {
                    [imageT setCenter:thirdImageP];
                }
            }
        
        
        }
        else if(longG.view.tag==303){
            if (lastPoint.x>250+2*self.frame.size.width) {
                [UIView animateWithDuration:0.2 animations:^{
                    [imageF setCenter:firstImageP];
                    [imageS setCenter:secondImageP];

                }];

                
            }
            else if (lastPoint.x>150+2*self.frame.size.width&&lastPoint.x<250+2*self.frame.size.width){
                [UIView animateWithDuration:0.2 animations:^{

                [imageF setCenter:firstImageP];
                [imageS setCenter:secondImageP];
                }];


            }
            else if (lastPoint.x<80+2*self.frame.size.width){
                [UIView animateWithDuration:0.2 animations:^{

                [imageF setCenter:secondImageP];
                [imageS setCenter:thirdImageP];
                }];


                
            }
            else if (lastPoint.x>=80+2*self.frame.size.width&&lastPoint.x<180+2*self.frame.size.width){
                [UIView animateWithDuration:0.2 animations:^{

                [imageF setCenter:firstImageP];
                [imageS setCenter:thirdImageP];
                }];


            }
        
        }
        
        if (lastPoint.x<2*self.frame.size.width+66&&lastPoint.x>2*self.frame.size.width) {
            if (lastPoint.y<195&&lastPoint.y>155) {
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
        if (lastPoint.x<2*self.frame.size.width+66&&lastPoint.x>2*self.frame.size.width) {
            [self performSelector:@selector(delayDeleteMove:) withObject:longG.view afterDelay:0.5];

        }
        else{
            [self performSelector:@selector(delayEndMove:) withObject:longG.view afterDelay:0.5];
        
        }
//        if (longG.view.center.y<220) {
//            if (longG.view.center.x<50) {
//                <#statements#>
//            }
//        }
    
        //            [UIView animateWithDuration:0.2 animations:^{
        //                [wasteBasket setFrame:CGRectMake(self.frame.size.width-66, 155, 66, 40)];
        //
        //            } completion:^(BOOL finished) {
        //                [wasteBasket removeFromSuperview];
        //
        //            }];

            }
            

}
-(void)delayDeleteMove:(UIImageView *)longV{
    CGPoint firstImageP=CGPointMake(65+2*self.frame.size.width, 175);
    CGPoint  secondImageP=CGPointMake(165+2*self.frame.size.width, 175);
//    CGPoint  thirdImageP=CGPointMake(265+self.frame.size.width, 175);
    UIButton *addImageButton=(UIButton *)[scrollV viewWithTag:304];
    UIImageView *imageS=(UIImageView *)[scrollV viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[scrollV viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[scrollV viewWithTag:301];

    float imageCount=[self.imageCollection count];

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
    UIImageView *wasteBasket=(UIImageView *)[scrollV viewWithTag:300];
    
    [UIView animateWithDuration:0.2 animations:^{
        [wasteBasket setFrame: CGRectMake(2*self.frame.size.width-66, 155, 66, 40)];
        [longV removeFromSuperview];
        [self.imageCollection removeObjectAtIndex:longV.tag-301];

        
    } completion:^(BOOL finished) {
        [wasteBasket removeFromSuperview];
    }];
    
    
    allowMove=NO;



}
-(void)delayEndMove:(UIImageView *)longV{
    NSString *firstImagex=[NSString stringWithFormat:@"%f",65+2*self.frame.size.width];
    NSString *secondImagex=[NSString stringWithFormat:@"%f",165+2*self.frame.size.width];
    NSString *thirdImagex=[NSString stringWithFormat:@"%f",265+2*self.frame.size.width];

    
    UIImageView *imageS=(UIImageView *)[scrollV viewWithTag:302];
    UIImageView *imageT=(UIImageView *)[scrollV viewWithTag:303];
    
    UIImageView *imageF=(UIImageView *)[scrollV viewWithTag:301];
    float imageCount=[self.imageCollection count];

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
            [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 175)];

        }];
        
        }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * secondImageX=[NSString stringWithFormat:@"%f",imageS.center.x
                                     ];
            imageS.tag=[numberArray indexOfObject:secondImageX]+301;
            longV.tag=603-imageS.tag;

            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 175)];
                
            }];

        
        }
        else if (imageCount==1){
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake(65+2*self.frame.size.width, 175)];
                
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
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 175)];
                
            }];
            

    
    
    }
        else if (imageCount==2){
            NSMutableArray *numberArray=[NSMutableArray arrayWithObjects:firstImagex,secondImagex, nil];
            NSString * firstImageX=[NSString stringWithFormat:@"%f",imageF.center.x
                                     ];
            imageF.tag=[numberArray indexOfObject:firstImageX]+301;
            longV.tag=603-imageF.tag;
            
            [UIView animateWithDuration:0.2 animations:^{
                [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 175)];
                
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
            [longV setCenter:CGPointMake([[numberArray objectAtIndex:longV.tag-301] floatValue], 175)];
            
        }];
        
        

    
    
    
    
    }
        UIImageView *wasteBasket=(UIImageView *)[scrollV viewWithTag:300];
        
        [UIView animateWithDuration:0.2 animations:^{
            [wasteBasket setFrame: CGRectMake(2*self.frame.size.width-66, 155, 66, 40)];
            longV.alpha=1;
            [longV setBounds:CGRectMake(longV.bounds.origin.x, longV.bounds.origin.y, 90, 90)];
            [scrollV sendSubviewToBack:longV];
            
        } completion:^(BOOL finished) {
            [wasteBasket removeFromSuperview];
        }];
        

    allowMove=NO;

}
-(void)chooseLocation:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
 [sender setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, 295, 240)];
        UIButton *sureButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 200, 30, 30)];
        sureButton.backgroundColor=[UIColor whiteColor];
        [locationText setFrame:CGRectMake(295/2-125, 105, 250, 30)];
        locationText.text=[NSString stringWithFormat:@"%@,%@,%@",[currentlocation objectAtIndex:0],[currentlocation objectAtIndex:1],[currentlocation objectAtIndex:2]];
        locationText.enabled=YES;
        [sureButton addTarget:self action:@selector(backLocationV:) forControlEvents:UIControlEventTouchUpInside];
        
        [sender addSubview:sureButton];
    }];
 

}
-(void)backLocationV:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        locationText.enabled=NO;

        [locationText setFrame:CGRectMake(25, 30, 50, 30)];
        locationText.text=[currentlocation objectAtIndex:0];
  
    [sender.superview setFrame:CGRectMake(sender.superview .frame.origin.x, sender.superview .frame.origin.y,90, 90)];

    [sender removeFromSuperview];

    }];

}
-(void)chooseSex:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"男"]) {
        [sender setTitle:@"女" forState:UIControlStateNormal];
    }
    else{
        [sender setTitle:@"男" forState:UIControlStateNormal];

    }

}
-(void)chooseHead:(UIButton *)sender{
    [nameText resignFirstResponder];

    UIActionSheet *chooseHead=[[UIActionSheet alloc]initWithTitle:@"头像照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    chooseHead.tag=33;
    [chooseHead showInView:self.superview];

}
-(void)chooseBlood:(UIButton *)sender{

    if ([sender.titleLabel.text isEqualToString:@"A"]) {
        [sender setTitle:@"B" forState:UIControlStateNormal];
    }
    else if([sender.titleLabel.text isEqualToString:@"B"]){
        [sender setTitle:@"AB" forState:UIControlStateNormal];
        
    }
    else if([sender.titleLabel.text isEqualToString:@"AB"]){
        [sender setTitle:@"O" forState:UIControlStateNormal];
        
    }
    else if([sender.titleLabel.text isEqualToString:@"O"]){
        [sender setTitle:@"A" forState:UIControlStateNormal];
        
    }



}
-(void)changePage:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"完成"]) {
//        判断是否资料完善
        
            if (telephoneText.text.length !=11) {
                if ([telephoneText.text isEqualToString:@""])  {
                    [alertContent addObject:@" 联系电话不能为空"];

            }
                else{
                    [alertContent addObject:@"电话号码位数不对"];

                }
            
        
        }
        if (telephoneTextS.text.length !=11&&telephoneTextS.text.length !=0) {
           
                [alertContent addObject:@"备用电话位数不对"];
                
        
            
            
        }
        if (![nameText.text isChinese]) {
            [alertContent addObject:@"姓名需要中文"];
        }
               if ([nameText.text isEqualToString:@""]) {
            [alertContent addObject:@" 姓名不为空"];

        }
        if ([contentSos.text isEqualToString:@""]) {
            [alertContent addObject:@" 求助详情不能为空"];

        }
        
        if ([alertContent count]!=0) {
            NSMutableString *content=[NSMutableString string];
            for (NSString *str in alertContent) {
                [content appendFormat:@"%@!\n",str];
            }
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alertContent removeAllObjects];
            [alertV show];
            return;
        }
        else{
        
            //    page4的时候 已经成型
            UIImageView *userPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(4*self.frame.size.width+20, 20, 40, 40)];
            userPhoto.layer.cornerRadius=10;
            userPhoto.layer.masksToBounds=YES;
       
            UIButton *headButton=(UIButton *)[self viewWithTag:101];
            NSLog(@"%@",headButton.imageView.image);
            userPhoto.image=headButton.imageView.image;
            float imageCount=[self.imageCollection count];
//            最后完成的图片信息
            for (int index=0; index<imageCount; index++) {
                UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(4*self.frame.size.width+20+100*index, 160, 90, 90)];
                imageV.image=[self.imageCollection objectAtIndex:index];
                [scrollV addSubview:imageV];
                
            }
//            最后完成后的位置信息
           UILabel *locationLa=[[UILabel alloc]initWithFrame:CGRectMake(4*self.frame.size.width+90, 70, 50, 20)];
            locationLa.text=[currentlocation objectAtIndex:0];
            locationLa.font=[UIFont systemFontOfSize:14];

            locationLa.backgroundColor=[UIColor redColor];

          
            //            最后完成后的血量信息

          UILabel *bloodVolume=[[UILabel alloc]initWithFrame:CGRectMake(4*self.frame.size.width+20, 70, 60, 20)];
            bloodVolume.text=[NSString stringWithFormat:@"%@",volume.text];
            bloodVolume.backgroundColor=[UIColor redColor];
            bloodVolume.font=[UIFont systemFontOfSize:14];
            //            最后完成后的求助详情

          UITextView *contentV=[[UITextView alloc]initWithFrame:CGRectMake(4*self.frame.size.width+20, 90, 295, 64)];
            UIButton *bloodButton=(UIButton *)[self viewWithTag:103];
            UIButton *sexButton=(UIButton *)[self viewWithTag:102];

            contentV.text=[NSString stringWithFormat:@"%@,%@,%@(RH阴性%@型血)\n%@",nameText.text,sexButton.titleLabel.text,age.text,bloodButton.titleLabel.text,contentSos.text];
            contentV.userInteractionEnabled=NO;
            
            
            [scrollV addSubview:userPhoto];
            [scrollV addSubview:headButton];
            [scrollV addSubview:locationLa];
            [scrollV addSubview:bloodVolume];
            [scrollV addSubview:contentV];
            
        }
        
          }
    if ([sender.titleLabel.text isEqualToString:@"提交"]) {
        [self showWithLabelMixed];
        
        return;

    }
    else if([sender.titleLabel.text isEqualToString:@"完成"])
    {
        UIButton *completeB=(UIButton *)[self viewWithTag:666];
        [completeB setTitle:@"提交" forState:UIControlStateNormal];
        UIButton *giveUpB=(UIButton *)[self viewWithTag:888];
        [giveUpB setTitle:@"放弃" forState:UIControlStateNormal];
    }

       if (currentPage<=4) {
       if (currentPage==2) {
            UIButton *completeB=(UIButton *)[self viewWithTag:666];
            [completeB setTitle:@"完成" forState:UIControlStateNormal];
        }
        currentPage=currentPage+1;
        [scrollV setContentOffset:CGPointMake((currentPage)*self.frame.size.width, 0) animated:YES];

    }


}
-(void)backPage:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"放弃"]) {
        
        [self.delegate  backView];
        return;
        
    }

    if (currentPage>0) {
        UIButton *completeB=(UIButton *)[self viewWithTag:666];
        [completeB setTitle:@"下一步" forState:UIControlStateNormal];
        currentPage=currentPage-1;
        [scrollV setContentOffset:CGPointMake((currentPage)*self.frame.size.width, 0) animated:YES];

        
    }

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentPage=scrollV.contentOffset.x/self.frame.size.width;
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ((scrollV.contentOffset.x-(currentPage)*self.frame.size.width)>0) {
        scrollV.scrollEnabled=NO;

    }
    if (currentPage==4) {
        scrollV.scrollEnabled=NO;
    }
    else{
        scrollV.scrollEnabled=YES;}

}

- (void)showWithLabelMixed {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.superview];
    [self.superview addSubview:HUD];
    
    HUD.delegate=self.superview;
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
    [self.delegate backView];
    [self.delegate addCell];
}

@end
