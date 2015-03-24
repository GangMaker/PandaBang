//
//  PB-TabBarMenuViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-TabBarMenuViewController.h"
#import "ViewController.h"
#import "PB-NAVLoginViewController.h"
#import "PB-FirstSOSViewController.h"
#import "PB-NAVSOSPViewController.h"
#import "UserDB.h"
#import "UserModal.h"


#define K_GETFROM_STORYBOARD(SBNAME,VCNAME)  [[UIStoryboard storyboardWithName:SBNAME bundle:[NSBundle mainBundle]]     instantiateViewControllerWithIdentifier:VCNAME]

@interface PB_TabBarMenuViewController ()

@end

@implementation PB_TabBarMenuViewController{
UIImagePickerController *myPickerController;
    UIImagePickerController *myPickerControllerHead;

    CLLocationManager *locationManager;
    UserDB *userDB;
    //   是否已经登入
    UIView *lightView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    userDB=[[UserDB alloc]init];
    [userDB creatTable];
    UserModal *modal=[[UserModal alloc]init];
    modal.userName=@"yang";
    modal.age=@"20";
    modal.password=@"123456";
    [userDB addUser:modal];
  
//隐藏原来的tabbar
    self.tabBar.hidden=YES;
    [self setLocationManager];
//自定义一个tabbar
   
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//切换页面的时候调用
-(void)changeTabView:(UIButton *)sender{
    NSLog(@"1111");
    if (sender.tag==1) {
        
        self.selectedIndex=0;
    
}
    else if (sender.tag==3) {
        NSLog(@"++++++%d",self.parentVC.isLogin);

//    首先弹出的是登入页 如果有登入直接换视图
        if ([[userDB findUsers]count]==1) {
            
            NSLog(@"1");
        PB_NAVLoginViewController *loginVC=K_GETFROM_STORYBOARD(@"Main", @"loginVC");
        
        [self presentViewController:loginVC animated:YES completion:^{
            
            self.selectedIndex=1;

            
        }];
        }
        else{
            self.selectedIndex=1;}

    }
    else{
        PB_NAVSOSPViewController *navSOS=K_GETFROM_STORYBOARD(@"Main", @"navSOS");
        [self presentViewController:navSOS animated:YES completion:^{
            
            
            
        }];

//        if (self.mySosView==nil) {
        
//中间那个是直接弹出视图 视图里面填写sos相关的信息(弹出sos)
//        self.mySosView=[[PB_SOSView alloc]initWithFrame:CGRectMake(0,KSCREEM_HEIGHT, KSCREEM_WIDTH, 280)];
//        self.mySosView.delegate=self;
//       self.mySosView.backgroundColor=[UIColor whiteColor];
//        
//        UIBlurEffect *blur=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//     UIVisualEffectView *LightCView=[[UIVisualEffectView alloc]initWithEffect:blur];
////     LightCView.backgroundColor=[UIColor blackColor];
//        LightCView.frame=CGRectMake(0, 0,KSCREEM_WIDTH, KSCREEM_HEIGHT);
//        LightCView.alpha=0;
//        self.mySosView.lightView=LightCView;
////     [LightCView addTarget:self action:@selector(PopBackView:) forControlEvents:UIControlEventTouchUpInside];
//     [UIView animateWithDuration:0.3 animations:^{
//         LightCView.alpha=1;
//     }];
//     [self.view addSubview:self.mySosView.lightView];
//     
//    [self.view addSubview:self.mySosView];t
//     [self PopView];
//    让父控制器的左移效果失灵
//           lightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEM_WIDTH, KSCREEM_HEIGHT)];
//            lightView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];

//            for (int index=0; index<5; index++) {
//                UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20+75*index, 500, 38, 38)];
//                [button addTarget:self action:@selector(changeContentButton:) forControlEvents:UIControlEventTouchUpInside];
//                button.tag=101+index;
//                button.backgroundColor=[UIColor whiteColor];
//                [lightView addSubview:button];
//            }
            
//            self.mySosView=[[PB_SOSpopView alloc]initWithFrame:CGRectMake(20, 120, 335, 335)];
//            [self.mySosView getAllThings];
//            self.mySosView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
//            self.mySosView.delegate=self;
//            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PopBackview)];
//            [tap setNumberOfTapsRequired:1];
//            [tap setNumberOfTouchesRequired:1];
//        [lightView addGestureRecognizer:tap];
//            [self.view addSubview:lightView];
//            
//            [self.view addSubview:self.mySosView];
//
//                    [self PopView];
        self.parentVC=(ViewController *)self.parentViewController;
        self.parentVC.popViewCloseAnimation=YES;
    }
    }
    
//}
//-(void)changeContentButton:(UIButton *)sender{
//
//
//}
-(void)PopView{
    
[UIView animateWithDuration:0.3 animations:^{
    lightView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
} completion:^(BOOL finished) {
    
}];
}
-(void)backView{
    [self PopBackview];
}
//收回视图的动画 结束后移除
-(void)PopBackview{
    [UIView animateWithDuration:0.3 animations:^{
        self.mySosView.hidden=YES;
        lightView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    } completion:^(BOOL finished) {
        [lightView removeFromSuperview];
        lightView=nil;
        [self.mySosView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self.mySosView];
        [self.mySosView.imageCollection removeAllObjects];
        self.mySosView=nil;
        self.parentVC=(ViewController *)self.parentViewController;
        
        self.parentVC.popViewCloseAnimation=NO;

        
    }];
   }



#define take PhoteDelegateMethods

-(void)createMyPickerController:(UIImagePickerControllerSourceType )sourceType picker:(BOOL)head{
    if (head==NO) {
        if (myPickerController==nil) {
            
            
            myPickerController=[[UIImagePickerController alloc]init];
            
            myPickerController.delegate=self;
            //    能否允许编辑
            myPickerController.allowsEditing = YES;
            myPickerController.sourceType=sourceType;
            
        }
        

        
    }
    else{
      if (myPickerControllerHead==nil) {
        
        
        myPickerControllerHead=[[UIImagePickerController alloc]init];
        
        myPickerControllerHead.delegate=self;
        //    能否允许编辑
        myPickerControllerHead.allowsEditing = YES;
        myPickerControllerHead.sourceType=sourceType;
        
    }
    }

}


//拍照
-(void)takePhotopicker:(BOOL)head{
    [self createMyPickerController:UIImagePickerControllerSourceTypeCamera picker:head];
    if (head==NO) {
        [self presentViewController:myPickerController animated:YES completion:^{ }];

    }
    else{
        [self presentViewController:myPickerControllerHead animated:YES completion:^{ }];

    }

}
//照片库取照片
-(void)photoFromAlbum:(BOOL)head{
   
//    能否允许编
    [self createMyPickerController:UIImagePickerControllerSourceTypePhotoLibrary picker:head];

  
    if (head==NO) {
        [self presentViewController:myPickerController animated:YES completion:^{ }];
        
    }
    else{
        [self presentViewController:myPickerControllerHead animated:YES completion:^{ }];
        
    }
//
//

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (picker==myPickerController) {
        
    
     UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];

    [self.mySosView addImageV:image];
    }
    else{
        UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.mySosView getHead:image];
    
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

  }
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
#define locationdelegateMetods
-(void)setLocationManager{

    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    if (locationManager==nil) {
        
        locationManager=[[CLLocationManager alloc]init];
        
    //如果没有授权则请求用户授权
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
           //设置代理
        locationManager.delegate=self;
        //设置定位精度
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        locationManager.distanceFilter=distance;
        //启动跟踪定位
        [locationManager startUpdatingLocation];
    
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *gett;

    for (CLLocation *get in locations) {
        
        gett=get;
    }
    self.currentLocation=[NSMutableArray array];
 
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];

         [geocoder reverseGeocodeLocation:gett completionHandler:^(NSArray *placemarks, NSError *error) {
             for (CLPlacemark *placemark in placemarks) {
//                 NSLog(@"name:%@",placemark.name);                     //位置名
//                 NSLog(@"thoroughfare:%@",placemark.thoroughfare);     //街道
//                 NSLog(@"subThoroughfare:%@",placemark.subThoroughfare); //子街道
//                 NSLog(@"administrativeArea:%@",placemark.administrativeArea);
//                 NSLog(@"locality:%@",placemark.locality);               //市
//                 NSLog(@"subLocality:%@",placemark.subLocality);          //区
//                 NSLog(@"country:%@",placemark.country);               //国家
//                 位置的label
                 [self.currentLocation addObject:placemark.administrativeArea];
                 [self.currentLocation addObject:placemark.subLocality];
                 [self.currentLocation addObject:placemark.name];
                 NSLog(@"%@",self.currentLocation);

                 
             }

             
         }];
}
-(void)addCell{
   PB_FirstSOSViewController *firstVC=(PB_FirstSOSViewController *) [[[self.viewControllers objectAtIndex:0]childViewControllers]objectAtIndex:0];
    [firstVC  headerrefresh:1];


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
