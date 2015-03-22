//
//  PB-ThirdGroupViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/2/3.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-ThirdGroupViewController.h"
#import "PB-TabBarMenuViewController.h"
#import "PB-grouppCell.h"
#import "PB-saveCell.h"
#import "PB-FriendCell.h"
//#import "MJRefresh.h"

#import "PB-ThirdGroupDetailViewController.h"

typedef NS_ENUM(NSInteger, PBCellType){

    PBCellTypeGroup=0,
    PBCellTypeFriend=1,
    PBCellTypeSave=2,
    PBCellTypeSos=3
    

};
@interface PB_ThirdGroupViewController ()

@end

@implementation PB_ThirdGroupViewController
{
    int cellChose;
   UIView *TfooterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNewTabBar];
    [self addTableHearder];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self.tableView addHeaderWithTarget:self action:@selector(headerrefresh)];
//    [self.tableView addFooterWithTarget:self action:@selector(footerrefresh)];
}
-(void)initNewTabBar{
    //设置新的自定义Tabbar
    //    设置tabbar的frame
    
    PB_TabView *tabView=[[PB_TabView alloc]initWithFrame:CGRectMake(0, KSCREEM_HEIGHT-50, KSCREEM_WIDTH, 50)];
    tabView.delegate=self;
    tabView.page=2;

    tabView.userInteractionEnabled=YES;
    [self.view addSubview:tabView];
    //
    
}
-(void)changeT:(UIButton *)sender{
    
    PB_TabBarMenuViewController *tabVC=(PB_TabBarMenuViewController *)self.tabBarController;
    [tabVC changeTabView:sender];
}
//-(void)headerrefresh{
//    [self.tableView headerEndRefreshing];
//
//}
//-(void)footerrefresh{
//
//}
-(void)addTableHearder{
    if (self.THeaderView==nil) {
        UIView *tbBackGroundview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEM_WIDTH, 180)];
        tbBackGroundview.backgroundColor=COLOR(23, 172, 107, 1);        tbBackGroundview.tag=1001;
    self.THeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEM_WIDTH, 180)];
    self.THeaderView.backgroundColor=COLOR(23, 172, 107, 1);
        [self.THeaderView addSubview:tbBackGroundview];

    self.headImage=[[UIButton alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH/2-40, self.THeaderView.frame.size.height/2-40, 80, 80)];
    [self.headImage setImage:[UIImage imageNamed:@"head.jpg"] forState:UIControlStateNormal];
    self.headImage.layer.cornerRadius=40;
    self.headImage.layer.masksToBounds=YES;
        self.detailInformation=[[UIButton alloc]initWithFrame:CGRectMake(10, self.THeaderView.frame.size.height-60, 40, 50)];
    [self.THeaderView addSubview:self.headImage];
        UILabel *bloodlabel=[[UILabel alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH/2+40, self.THeaderView.frame.size.height/2-40, 40, 20)];
        bloodlabel.text=@"B－";
        bloodlabel.textColor=[UIColor whiteColor];
        [self.THeaderView addSubview:bloodlabel];
        UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH/2-100, self.THeaderView.frame.size.height/2+50, 200, 30)];
        userName.text=@"doupdoup";
        userName.textColor=[UIColor whiteColor];
        userName.textAlignment=NSTextAlignmentCenter;
        [self.THeaderView addSubview:userName];

        [self.THeaderView addSubview:self.detailInformation];
        
//        TfooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEM_WIDTH, 180)];
//        UIButton *footView=[[UIButton alloc]initWithFrame:CGRectMake(15, 15, 345, 150)];
//        [TfooterView addSubview:footView];
//        TfooterView.backgroundColor=[UIColor groupTableViewBackgroundColor];
//        footView.backgroundColor=[UIColor grayColor];
//        self.tableView.tableFooterView=TfooterView;
        
     self.tableView.tableHeaderView=self.THeaderView;
        
          }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (cellChose==PBCellTypeFriend) {
          self.cellCount=1;
        
    }
    else if(cellChose==PBCellTypeGroup){
          self.cellCount=3;
    }
    else if(cellChose==PBCellTypeSave){
        self.cellCount=1;

    }
    


    else if(cellChose==PBCellTypeSos){
        self.cellCount=1;

    }
  
    return self.cellCount;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *heightByType=@[@"180",@"70",@"390",@"390"];
    return [[heightByType objectAtIndex:cellChose]intValue];
    

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *titleArray=@[@"帮帮",@"血友",@"收藏",@"我的求助"];
    
    UIView *buttonCollectionV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEM_WIDTH, 60)];
    buttonCollectionV.backgroundColor=[UIColor whiteColor];
    for (int index=0; index<4; index++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(KSCREEM_WIDTH/4*index, 0, KSCREEM_WIDTH/4-1, 60)];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        button.tag=index+1;
        
        [button addTarget:self action:@selector(changeCellContent:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[titleArray objectAtIndex:index] forState:UIControlStateNormal];
        [buttonCollectionV addSubview:button];
    }
    
    return buttonCollectionV;



}

-(void)changeCellContent:(UIButton *)sender

{
    if (sender.tag==1) {
        cellChose=PBCellTypeGroup;
        
    }
    else if (sender.tag==2){
        cellChose=PBCellTypeFriend;
    
    }
    else if (sender.tag==3){
    
        cellChose=PBCellTypeSave;

    }
    else if (sender.tag==4){
        cellChose=PBCellTypeSos;
    
    }
    [self.tableView reloadData];
                                            
                                            
 }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenfgroup=@"groupcell";

    static NSString *idensave=@"saveCell";
    static NSString *idenffriend=@"friendCell";
    static NSString *idenfadd=@"addCell";

    PB_saveCell *saveCell=(PB_saveCell *)[tableView dequeueReusableCellWithIdentifier:idensave];
    PB_FriendCell *friendCell=(PB_FriendCell *)[tableView dequeueReusableCellWithIdentifier:idenffriend];

    PB_grouppCell *groupCell=(PB_grouppCell *)[tableView dequeueReusableCellWithIdentifier:idenfgroup];
    UITableView *cell=[tableView dequeueReusableCellWithIdentifier:idenfadd];


    NSArray *cellType=@[groupCell,friendCell,saveCell,saveCell,cell];
              self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
            self.tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (cellChose==PBCellTypeGroup) {
        if (indexPath.row==self.cellCount-1) {
            return [cellType objectAtIndex:4];
        };
    }
              return [cellType objectAtIndex:cellChose];
     

    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



    self.mydetailVC=K_GETFROM_STORYBOARD(@"Main", @"thirdDetail");
    
    self.mydetailVC.indexPathRow=indexPath.row/2;
    
    [self.mydetailVC.view setFrame:CGRectMake(375, 0, 375, 677)];
    [self.parentViewController.view addSubview:self.mydetailVC.view ];
    
    [self.parentViewController addChildViewController:self.mydetailVC];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
        [self.mydetailVC.view setFrame:CGRectMake(0, 0, 375, 677)];
        
    } completion:^(BOOL finished) {
        
    }];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//   设置头视图的往下拉变化大小  使下拉后上面的填充颜色和原来一样
    if (scrollView.contentOffset.y<-20) {
        NSLog(@"%f",scrollView.contentOffset.y);
      UIView *view=(UIView *)[self.tableView viewWithTag:1001];
       [view setFrame:CGRectMake(0,scrollView.contentOffset.y+20 , KSCREEM_WIDTH,-scrollView.contentOffset.y-20)];
        
        
    }

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
