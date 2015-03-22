//
//  PB-FirstSOSViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/21.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-FirstSOSViewController.h"
#import "PB-POPupView.h"
#import "PB-TabBarMenuViewController.h"
#import "ViewController.h"
#import "PB-FirstDetailSOSViewController.h"
#import "PB-SCREENView.h"
#import "MJRefresh.h"
#import "MJRefreshBaseView.h"
#import "UIImageView+WebCache.h"
//屏幕的高和宽
//获取StoryBoard里的VC

#define KSCREEM_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define KSCREEM_WIDTH      [UIScreen mainScreen].bounds.size.width
#define KNEAR 1
#define KALLC 2
#define KREGRESH 0
#define KADD 1
@interface PB_FirstSOSViewController ()

@end

@implementation PB_FirstSOSViewController
{
    BOOL isTapDisscuss;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellCount=10;
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH/2-15, 5, 30, 30)];
    imageV.image=[UIImage imageNamed:@"1.jpg"];
    [self.navigationController.navigationBar addSubview:imageV];
    [self getDataFromServer:KNEAR refreshOrAdd:KREGRESH];
    self.tableView.scrollsToTop=YES;
//    self.backGroundImageView.image=[UIImage imageNamed:@"1.jpg"];
    
    self.mainVC=(ViewController *)self.tabBarController.parentViewController;
    // Do any additional setup after loading the view.
    [self initNewTabBar];
}


//当键盘出现或改变时调用

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initNewTabBar{
    //设置新的自定义Tabbar
    //    设置tabbar的frame
    
     PB_TabView *tabView=[[PB_TabView alloc]initWithFrame:CGRectMake(0, KSCREEM_HEIGHT-50, KSCREEM_WIDTH, 50)];
//    tabView.image=[UIImage imageNamed:@"item_detail_bottom_bar@2x"];

    tabView.delegate=self;
    tabView.page=0;
    tabView.userInteractionEnabled=YES;
      [self.view addSubview:tabView];
    //
    
}
-(void)changeT:(UIButton *)sender{

    PB_TabBarMenuViewController *tabVC=(PB_TabBarMenuViewController *)self.tabBarController;
    [tabVC changeTabView:sender];
}
-(void)insertCell{


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      static NSString *idenfier=@"PBCell";

  
//设置求助条cell
        PB_SOSCell *sosCell=[tableView dequeueReusableCellWithIdentifier:idenfier];
//        [sosCell.PBTypeImageView sd_setImageWithURL:<#(NSURL *)#>];
//        初始化求助条的存放照片的数组
//        self.imageArray=[NSMutableArray array];
//设置放置图片的滚动视图的大小 根据图片的多少设置
        UIImageView *imageV;
//  多少图片就需要多少imageview 通过循环添加
        for (int index=0; index<[self.imageArray count]; index++) {
//并且给予tag 不用一直add
            if ((UIImageView *)[sosCell.imageArrayScrollV viewWithTag:1001+index]==nil) {
                

            imageV=[[UIImageView alloc]initWithFrame:CGRectMake(120*index, 0, 100, 100)];
            imageV.tag=1001+index;
                [sosCell.imageArrayScrollV addSubview:imageV];
            }
            imageV=(UIImageView *)[sosCell.imageArrayScrollV viewWithTag:1001+index];
//            imageV.image=[self.imageArray objectAtIndex:index];
            [imageV sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"placeholder240x240@2x"]];
            
        }
        sosCell.delegate=self;
        [sosCell.contentView.layer setShadowRadius:5];
        [sosCell.contentView.layer  setShadowColor:(__bridge CGColorRef)([UIColor blackColor])];
        return sosCell;

    
    
    
}
-(void)pushToInfo{
    self.myinfoVC=K_GETFROM_STORYBOARD(@"Main", @"infoVC");
    [self.myinfoVC.view setFrame:CGRectMake(375, 0, 375, KSCREEM_HEIGHT)];
    [self.parentViewController.view addSubview:self.myinfoVC.view ];
    
    [self.parentViewController addChildViewController:self.myinfoVC];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
        [self.myinfoVC.view setFrame:CGRectMake(0, 0, 375,KSCREEM_HEIGHT)];
        
    } completion:^(BOOL finished) {
        
    }];



}
//点击cell 推送到下一个页面 把soscell内容传过去
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//       UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//     backItem.title=@"";
        
//      self.navigationItem.backBarButtonItem = backItem;
        self.mydetailSOSVC=K_GETFROM_STORYBOARD(@"Main", @"firstSOSDetail");
           self.mydetailSOSVC.indexPathRow=indexPath.row;
        
        if (isTapDisscuss) {
             self.mydetailSOSVC.isDisscussView=YES;
            isTapDisscuss=NO;
        }
//       修改selv。view的动画效果？？
        [self.mydetailSOSVC.view setFrame:CGRectMake(375, 0, 375, KSCREEM_HEIGHT)];
        [self.parentViewController.view addSubview:self.mydetailSOSVC.view ];
        
        [self.parentViewController addChildViewController:self.mydetailSOSVC];
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
            [self.mydetailSOSVC.view setFrame:CGRectMake(0, 0, 375,KSCREEM_HEIGHT)];

        } completion:^(BOOL finished) {
            
        }];

        
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return self.cellCount;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
       return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 390;}

- (IBAction)chooseRange:(UIButton *)sender {
    //    选择查看求助条的范围
    if (self.screenView==nil) {
        self.lightView=[[UIControl alloc]initWithFrame:CGRectMake(0, 60, KSCREEM_WIDTH, KSCREEM_HEIGHT-70)];
        self.lightView.userInteractionEnabled=YES;
        [self.lightView addTarget:self action:@selector(resignScreenView:) forControlEvents:UIControlEventTouchUpInside];
        
        self.screenView=[[PB_SCREENView alloc]initWithFrame:CGRectMake(5, 65, 130, 130)];
        self.screenView.delegate=self;
        [self.view addSubview:self.lightView];
        [self.view addSubview:self.screenView];
        
        
    }
    else{
        
        [self resignScreenView:nil];
    }

}

- (IBAction)pushMessageVC:(UIButton *)sender {
    self.mymessageVC=K_GETFROM_STORYBOARD(@"Main", @"navMessageVC");
    

    //       修改selv。view的动画效果？？
    [ self.mymessageVC.view setFrame:CGRectMake(375, 0, 375, KSCREEM_HEIGHT)];
    [self.parentViewController.view addSubview: self.mymessageVC.view ];
    
    [self.parentViewController addChildViewController: self.mymessageVC];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
        [ self.mymessageVC.view setFrame:CGRectMake(0, 0, 375,KSCREEM_HEIGHT)];
        
    } completion:^(BOOL finished) {
        
    }];

    
    
    
}

-(void)resignScreenView:(UIControl *)sender{
    [self.screenView removeFromSuperview];
    self.screenView=nil;
    
    [self.lightView removeFromSuperview];
    self.lightView=nil;


}
-(void)screenChooseNear{

    [self getDataFromServer:KNEAR refreshOrAdd:KREGRESH];
    [self.tableView reloadData];
    [self resignScreenView:nil];


}
-(void)screenChooseAllC{
    [self getDataFromServer:KALLC refreshOrAdd:KREGRESH];

    [self.tableView reloadData];
    [self resignScreenView:nil];


}

-(void)letshowView:(NSString *)phoneNum type:(PopUpViewStyle)style{
    //拨打电话 联系的按钮
    //    详细界面也要
    self.myTabBarVC=(PB_TabBarMenuViewController *)self.tabBarController;
    UIControl *LightCView=[[UIControl alloc]initWithFrame:CGRectMake(0, 0,KSCREEM_WIDTH, KSCREEM_HEIGHT)];
    LightCView.backgroundColor=[UIColor blackColor];
    self.tableView.userInteractionEnabled=NO;
    LightCView.alpha=0;
    [LightCView addTarget:self action:@selector(PopBackView:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        LightCView.alpha=0.3;
    }];
    [self.myTabBarVC.view addSubview:LightCView];
//根据style的类型给予相应的popview
    if (style==KPhoneCall) {
        
    
    self.myPopView=[[PB_POPupView alloc]initPopUpViewStyle:KPhoneCall withASpeed:KNice];
    self.myPopView.phoneNumber=phoneNum;
    }
    else if (style==KShare){
        self.myPopView=[[PB_POPupView alloc]initPopUpViewStyle:KShare withASpeed:KNice];

    
    }
    self.myPopView.lightView=LightCView;
    self.myPopView.delegate=self;
    
    [self.myTabBarVC.view addSubview:self.myPopView];
    //  主视图的动画效果失效
    self.mainVC.popViewCloseAnimation=YES;


}
-(void)PBPush:(PB_SOSCell *)cell{

    [self tableView:self.tableView didSelectRowAtIndexPath:[self.tableView indexPathForCell:cell]];


}
-(void)PBConnect:(PB_SOSCell *)cell{
    NSString *TellPhoneNumber=@"13888888888";

    [self letshowView:TellPhoneNumber type:KPhoneCall];
}
-(void)PBDisscuss:(PB_SOSCell *)cell{
    isTapDisscuss=YES;

    [self tableView:self.tableView didSelectRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    

}
-(void)PBShare:(PB_SOSCell *)cell{
//分享的按钮
    [self letshowView:nil type:KShare];
}
-(void)PopBackView:(UIControl *)lightcView{
//添加在light上的返回视图的按钮
    [UIView animateWithDuration:0.3 animations:^{
        self.myPopView.frame=CGRectMake(-KSCREEM_WIDTH/3,KSCREEM_HEIGHT/2-160, KSCREEM_WIDTH/4, 300);
        
        
    } completion:^(BOOL finished) {
        [self.myPopView removeFromSuperview];
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        lightcView.alpha=0;
    } completion:^(BOOL finished) {
        [lightcView removeFromSuperview];
        [self recoverUserEnabled];
       
    }];


}

#define ActionSheetDelegate Method
#define Idenfir_delegateMethod
-(void)PB_callPhone:(NSString *)phonenumber{
//调用电话的界面 打电话
    UIWebView *callWebview =[[UIWebView alloc] init];
    //       呼叫电话
    //
    NSString *phoneNumber=[NSString stringWithFormat:@"tel:%@",phonenumber];
    NSURL *telURL =[NSURL URLWithString:phoneNumber];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
 
}
//恢复状态
-(void)recoverUserEnabled{

    self.tableView.userInteractionEnabled=YES;
    self.mainVC.popViewCloseAnimation=NO;

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    [self.tableView addHeaderWithTarget:self action:@selector(headerrefresh:)];
    [self.tableView addFooterWithTarget:self action:@selector(footerrefresh:)];
}

//-(void)endAnimation
//{    angle += 10;
//    [self startAnimation1];
//    
//}
-(void)getDataFromServer:(int)range refreshOrAdd:(BOOL)roa{
    //    暂时数据
    if (range==KNEAR) {
        
    }
    else if (range==KALLC){
        
        
    }
    if (roa==KREGRESH) {
        self.cellCount=10;
    }
    else if (roa==KADD){
    self.cellCount+=10;
    }

    self.imageArray=[NSMutableArray array];
    
    [self.imageArray addObject:@"http://pic1a.nipic.com/2008-10-22/20081022103550586_2.jpg"];
    [self.imageArray addObject:@"http://pic1.nipic.com/2008-08-15/200881516037481_2.jpg"];
    [self.imageArray addObject:@"http://pic11.nipic.com/20101115/668573_163809002973_2.jpg"];

//    UIImage *fimage=[UIImage imageNamed:@"1.jpg"];
//    UIImage *simage=[UIImage imageNamed:@"2.jpg"];
//    
//    [self.imageArray addObject:fimage];
//    [self.imageArray addObject:simage];
    [self completeReload];
    //        从服务器请求下来 求助条的用户名 时间  血型 电话 位置 详情 照片组
    
}
-(void)completeReload{
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];

}
-(void)headerrefresh:(int)range {
    //数据传好
    [self getDataFromServer:range refreshOrAdd:KREGRESH];

    
    
}

-(void)footerrefresh:(int)range{
    
    [self getDataFromServer:range refreshOrAdd:KADD];

    //加载数据
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
