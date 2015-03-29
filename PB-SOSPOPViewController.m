//
//  PB-SOSPOPViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPViewController.h"
#import "PB-SOSPOPSecondViewController.h"
#import "NSString+Valid.h"
#import "locationInfo.h"
#import "PostInfo.h"
@interface PB_SOSPOPViewController ()

@end

@implementation PB_SOSPOPViewController
{
    BOOL informationComplete;
        CLLocationManager *locationManager;
    PostInfo *postInfo;
    locationInfo *locInfo;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllControl];
    [self setLocationManager];
    postInfo=[PostInfo defaultManager];
    self.textName.text=postInfo.Post_name;
    self.textAge.text=postInfo.Post_age;
    UILabel *blood=(UILabel *)[self.view viewWithTag:111];
    blood.text=postInfo.Post_bloodType;
    
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
//    每次将要出现  添加键盘hide通知
    [super viewWillAppear:animated];
    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    locInfo=[locationInfo defaultManager];
    [self.locationButton setTitle:[locInfo getLocationLabel] forState:UIControlStateNormal];
    
    
    [self keyboardAddNSNotification];


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
        CLLocationDistance distance=100.0;//十米定位一次
        locationManager.distanceFilter=distance;
        //启动跟踪定位
        [locationManager startUpdatingLocation];
        
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *gett;
    locInfo= [locationInfo defaultManager];
    
    for (CLLocation *get in locations) {
        
        gett=get;
        [locInfo saveLocation:get];
        [locInfo saveUserLocation:get];
        
        
    }
    
    
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
            
            NSString *locationLabel=[NSString stringWithFormat:@"%@ %@ %@",placemark.administrativeArea,placemark.subLocality,placemark.name];
            //                 [currentLocation addObject:placemark.administrativeArea];
            //                 [currentLocation addObject:placemark.subLocality];
            //                 [currentLocation addObject:placemark.name];
            [locInfo saveLocationLabel:locationLabel];
            [locInfo saveUserLocationLabel:locationLabel];
            
            
        }
        
        
    }];
    [locationManager stopUpdatingLocation];
}

//回收键盘的方法
-(void)recoverKeyBoard{

    [self.textName resignFirstResponder];
    [self.textAge resignFirstResponder];

}
-(void)keyboardAddNSNotification{
    //增加监听
       [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
-(void)keyboardWillHide:(NSNotification *)aNotification{
//当键盘回收 滚动视图下移

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initAllControl{


}
-(void)setButton:(UIButton *)sender{
    sender.layer.cornerRadius=20;
    sender.layer.masksToBounds=YES;
}
//返回vc


-(IBAction)backVC:(UIBarButtonItem *)sender {
    NSLog(@"1");
    
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"是否保存下次使用？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:@"不保存", nil];
    [action showInView:self.view];
    
    
    
}

- (IBAction)chooseBlood:(UIButton *)sender {
    UIActionSheet *bloodType=[[UIActionSheet alloc]initWithTitle:@"选择RH阴性血型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"A型血" otherButtonTitles:@"B型血" ,@"AB型血", @"O型血",nil];
    bloodType.tag=1;
    [bloodType showInView:self.view];
    
    
}

- (IBAction)chooseLocation:(UIButton *)sender {
    [self performSegueWithIdentifier:@"locationPush" sender:nil];
}

//离开页面前删除通知
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UILabel *label=(UILabel *)[self.view viewWithTag:111];
    if (actionSheet.tag==1) {
        
    
    if (buttonIndex==0) {
        [label setText:@"RH阴性A型血"];
    }
    else if (buttonIndex==1){
        [label setText:@"RH阴性B型血"];

    }
    else if (buttonIndex==2){
        [label setText:@"RH阴性AB型血"];

    }
    else if (buttonIndex==3){
        [label setText:@"RH阴性O型血"];

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



- (IBAction)nextStepAction:(UIButton *)sender {
//    点击下一步操作
    NSMutableString *errors=[NSMutableString string];
    [self recoverKeyBoard];
//    判断是否有以下错误 并且加到字符串上
    if ([self.textName.text isEqualToString:@""]) {
        [errors appendFormat:@"%@\n",@" 姓名没有填写"];
        
    }
   if (![self.textName.text isChinese]){
        [errors appendFormat:@"%@\n",@" 填写中文姓名"];

    }
    if ([self.textAge.text isEqualToString:@""]) {
        [errors appendFormat:@"%@\n",@" 年龄没有填写"];
        
    }
        // 如果没有error 推送下一页面
    if ([errors isEqualToString:@""]) {
        postInfo=[PostInfo defaultManager];

      
        [self performSegueWithIdentifier:@"nextStep" sender:nil];
        

    }
//    否则弹出警告
    else
    {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"注意" message:errors delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
        [alertView show];
    
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    postInfo.Post_name=textField.text;
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
