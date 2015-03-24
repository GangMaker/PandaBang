//
//  PB-SCREENView.m
//  PANDA-BANG
//
//  Created by mhand on 15/2/16.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SCREENView.h"
#import "PB-FirstSOSViewController.h"
@implementation PB_SCREENView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        self.backgroundColor=[UIColor clearColor];

    }
    
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    这个是首页左上角的范围选择框 是否附近或全国  刷新tableview
    if (self.tableV==nil) {
        
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageV.image=[UIImage imageNamed:@"popV"];
       self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        self.tableV.backgroundColor=[UIColor blackColor];
        self.tableV.alpha=0.7;
        self.tableV.delegate=self;
       self.tableV.dataSource=self;
        self.tableV.scrollEnabled=NO;
        [self addSubview:self.imageV];
        self.imageV.userInteractionEnabled=YES;
     [self.imageV addSubview:self.tableV];

        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PB_FirstSOSViewController *sosVC=(PB_FirstSOSViewController *)self.delegate;

    if (indexPath.row==0) {
//       改变checkmark选中的值
        sosVC.checkMarkPostion=0;
      
        [self.delegate screenChooseNear];
 
    }
    else{
        sosVC.checkMarkPostion=1;
        [self.delegate screenChooseAllC];

    }



}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idf=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idf];
    PB_FirstSOSViewController *sosVC=(PB_FirstSOSViewController *)self.delegate;

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idf] ;
    
    }
    if (indexPath.row==0) {
        if (sosVC.checkMarkPostion==1) {
            cell.accessoryView=[UIView new];
        }
       
        cell.detailTextLabel.text=@"附近";
    }
    else{
        if (sosVC.checkMarkPostion==0) {
            cell.accessoryView=[UIView new];
        }

        cell.detailTextLabel.text=@"全国";

    }
    cell.accessoryType=UITableViewCellAccessoryCheckmark;

    cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 10);
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    

   
    return cell;}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}





@end
