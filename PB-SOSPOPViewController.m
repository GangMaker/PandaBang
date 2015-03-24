//
//  PB-SOSPOPViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPViewController.h"
#import "PB-SOSPOPSecondViewController.h"
@interface PB_SOSPOPViewController ()

@end

@implementation PB_SOSPOPViewController
{
    UIImagePickerController *myPickerController;
    BOOL informationComplete;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllControl];
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self keyboardAddNSNotification];


}

-(void)recoverKeyBoard{

    [self.textName resignFirstResponder];
    [self.textTelephone resignFirstResponder];
    [self.textTelephoneS resignFirstResponder];


}
-(void)keyboardAddNSNotification{
    //增加监听，当键盘出现或改变时收出消息
       [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
-(void)keyboardWillHide:(NSNotification *)aNotification{

    [self.scrollView setContentOffset:CGPointMake(0,-64) animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initAllControl{
    [self setButton:self.sexButton];
    [self setButton:self.headButton];
    [self setButton:self.bloodButton];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBoard)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.scrollView addGestureRecognizer:tap];


}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
  [self.scrollView setContentOffset:CGPointMake(0, 250) animated:YES];
    return YES;

}
- (IBAction)nextStepAction:(UIButton *)sender {
    [self recoverKeyBoard];
    
    [self performSegueWithIdentifier:@"nextStep" sender:nil];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (self.textName) {
        <#statements#>
    }
    
    
    PB_SOSPOPSecondViewController *secondVC=(PB_SOSPOPSecondViewController *) segue.destinationViewController;
    


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setButton:(UIButton *)sender{
    sender.layer.cornerRadius=20;
    sender.layer.masksToBounds=YES;
    }

- (IBAction)chooseHead:(UIButton *)sender {
    UIActionSheet *chooseHead=[[UIActionSheet alloc]initWithTitle:@"头像照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    chooseHead.tag=33;
    [chooseHead showInView:self.view];

}
-(void)addImage:(UIButton *)sender{
    
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

- (IBAction)chooseSex:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"男"]) {
        [sender setTitle:@"女" forState:UIControlStateNormal];
    }
    else{
        [sender setTitle:@"男" forState:UIControlStateNormal];
        
    }

}

- (IBAction)chooseBlood:(UIButton *)sender {
    
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

- (IBAction)backVC:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (IBAction)ageChange:(UISlider *)sender {
    self.age.text=[NSString stringWithFormat:@"%.0f岁",sender.value*100];
   
}

- (IBAction)volumeChange:(UISlider *)sender {
    NSString *volumeN=[NSString stringWithFormat:@"%.0f",sender.value*100];
    int volumeNN=[volumeN floatValue];
    self.volume.text=[NSString stringWithFormat:@"%d毫升",volumeNN*100];

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
        [self getHead:image];

    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)getHead:(UIImage *)image{
//    防止图片渲染成蓝色
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self.headButton setImage:image forState:UIControlStateNormal];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
