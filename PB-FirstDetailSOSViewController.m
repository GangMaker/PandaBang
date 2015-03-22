//
//  PB-FirstDetailSOSViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/1/28.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-FirstDetailSOSViewController.h"
#import "PB-FirstSOSViewController.h"
#import "PB-TabBarMenuViewController.h"
#import "PB-SOSDetailCell.h"
#import "PB-SOSDetailFCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface PB_FirstDetailSOSViewController ()

@end

@implementation PB_FirstDetailSOSViewController{
    int disscussInputy;
    UIScrollView *imageScrollV;
    CGFloat ChangeX;
  
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    能同时响应多个手势
   
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panG=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    self.panG.delegate=self;
  [self.view addGestureRecognizer:self.panG];
    if (self.isDisscussView) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:14 inSection:0];
       [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    [self getDataFromServer];
//    键盘添加通知
   [self keyboardAddNSNotification];
//    添加image到scroll上
    [self addImageToScrollV];
//    设置评论框的边框
   [self setBorderproperty];
//    监听评论框内容改变
  [self textChangeAddNotification];

   
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)getDataFromServer{
//  这里应该有所有关联数据
//暂时数据
    self.imageArray=[NSMutableArray array];
    [self.imageArray addObject:@"http://pic1a.nipic.com/2008-10-22/20081022103550586_2.jpg"];
    [self.imageArray addObject:@"http://pic1.nipic.com/2008-08-15/200881516037481_2.jpg"];
    [self.imageArray addObject:@"http://pic11.nipic.com/20101115/668573_163809002973_2.jpg"];
    
//    UIImage *fimage=[UIImage imageNamed:@"1.jpg"];
//    UIImage *simage=[UIImage imageNamed:@"2.jpg"];
//    
//    [self.imageArray addObject:fimage];
//    [self.imageArray addObject:simage];



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
-(void)textChangeAddNotification{
//    添加监听 当视图内容改变时 来改变高度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    如果点换行键 这里当send键用
    
      if ([text isEqualToString:@"\n"])
    {
//        判断是否是空的文字
        if ([textView.text isEqualToString:@""]) {
//空的给警告
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"请输入评论" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
            
        }
//不是空的发送
        //按下return键
        //这里隐藏键盘，不做任何处理
        else{
            [self sendImageNow];

        }
// 同时回收键盘
        [textView resignFirstResponder];
        self.discussInputV.hidden=YES;
        
        self.lightView.hidden=YES;
        NSLog(@"asdasd");
        
        return NO;
    }
    else{
        return YES;
    }


}

-(void)textViewDidChange:(NSNotification *)notif{
    
////    最高的height282 385（不包括view的高）335   平常的252 415  365
   UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];
//    
  CGSize contentSize = textV.contentSize;
    

  //    NSLog(@"%lu",[[textV.text componentsSeparatedByString:@"\n"]count]-1);
    if (contentSize.height==34) {
       [self.discussInputV setFrame:CGRectMake(0, disscussInputy, 375, 50)];
        NSLog(@"sdasd");
        [textV setFrame:CGRectMake(8, 8, 302, 34)];

           }
    else if (contentSize.height==52){
        [self.discussInputV setFrame:CGRectMake(0, disscussInputy-18, 375, 68)];

        [textV setFrame:CGRectMake(8, 8, 302,52 )];

    }
    else if (contentSize.height==70){
        [self.discussInputV setFrame:CGRectMake(0, disscussInputy-36, 375, 86)];
        
        [textV setFrame:CGRectMake(8, 8, 302,70 )];
        
    }
//

}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
//    根据键盘高度变化回复条
    self.lightView.hidden=NO;
    self.lightView.userInteractionEnabled=YES;
    NSDictionary *userInfo = [aNotification userInfo];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];

    int height = keyboardRect.size.height;
//    根据键盘的高度添加输入框
//    self.discussInputV.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    [UIView animateWithDuration:duration animations:^{
        
    [self.discussInputV setFrame:CGRectMake(0, 667-height-self.discussInputV.frame.size.height, 375,self.discussInputV.frame.size.height)];
    self.discussInputV.hidden=NO;
    } completion:^(BOOL finished) {
//        将discussinputy变为这个类型最初的状态 在此状态上增减
    disscussInputy=self.discussInputV.frame.origin.y+(self.discussInputV.frame.size.height-50);
    }];
  

    
    

 
}
//寻找view 暂时没用
- (UIView *)findView:(UIView *)aView withName:(NSString *)name {
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc])
        return aView;
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++) {
        UIView *subView = [aView.subviews objectAtIndex:i];
        
        subView = [self findView:subView withName:name];
        if (subView)
            return subView;
    }
    return nil;
}


- (void)keyboardWillHide:(NSNotification *)aNotification
{

//当键盘回收时候 设置输入框位置
    [UIView animateWithDuration:0.2 animations:^{
        [self.discussInputV setCenter:CGPointMake(KSCREEM_WIDTH/2,642)];

    } completion:^(BOOL finished) {

    }];
    
}
//添加图片在tableheader的scroll上
-(void)addImageToScrollV{
  imageScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,KSCREEM_WIDTH, KSCREEM_WIDTH)];
   imageScrollV.delegate=self;
    //    设置图片
    [imageScrollV setContentSize:CGSizeMake(375*[self.imageArray count],375)];
    UIPageControl *pageC;
 
    pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(165,15, 50, 30)];
    pageC.tag=555;
    
    
    pageC.numberOfPages=[self.imageArray count];
    
    [self.tableView addSubview:pageC];

    for (int index=0; index<[self.imageArray count]; index++){
        UIImageView *imageV;
        if ([imageScrollV viewWithTag:1001+index]==nil) {
            
            imageV=[[UIImageView  alloc]initWithFrame:CGRectMake(375*index, 0, 375, 375)];
            imageV.tag=1001+index;
            [imageScrollV addSubview:imageV];
           
        }
        
        imageV=(UIImageView *)[imageScrollV viewWithTag:1001+index];
        
//        imageV.image=[self.imageArray objectAtIndex:index];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"placeholder240x240@2x"]];
        
    }
    imageScrollV.pagingEnabled=YES;
    imageScrollV.scrollEnabled=YES;
    imageScrollV.delegate=self;
    self.tableView.tableHeaderView=imageScrollV;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *fid=@"PBDFCell";
    static NSString *idf=@"PBDCell";
    static NSString *idspace=@"spaceCell";
    static NSString *idtitile=@"titleCell";
    if (indexPath.row==0) {
        
        PB_SOSDetailFCell *Fcell=(PB_SOSDetailFCell *)[tableView dequeueReusableCellWithIdentifier:fid];
        
        
        return Fcell;
    }
    else if(indexPath.row==1){
       
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idspace];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        return cell;
    
    }
    else if(indexPath.row==2){
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idtitile];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
        else{
    
        PB_SOSDetailCell *sosDetailCell=(PB_SOSDetailCell *)[tableView dequeueReusableCellWithIdentifier:idf];
        sosDetailCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return sosDetailCell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row!=0) {
        UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];
        
        [textV becomeFirstResponder];
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//需要自适应高度
    if (indexPath.row==0) {
        return 180;
    }
    else if (indexPath.row==1){
    
        return 10;
    }
    else if(indexPath.row==2){
    
        return 25;
    }
       else{
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 15;

}
//返回vc
- (IBAction)backVc:(UIButton *)sender {
  
    self.sosVC=(PB_FirstSOSViewController *)[self.parentViewController.childViewControllers objectAtIndex:0];

    [UIView animateWithDuration:0.3 animations:^{
//        大小为本视图的1:1大小 不是自身的比例大小
        [self.sosVC.view  setTransform:CGAffineTransformScale(self.view.transform, 1, 1)];
        [self.view setFrame:CGRectMake(375, 0, 375, 677)];
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];

    }];

    
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    ViewController *vc= (ViewController *)self.tabBarController.parentViewController;

    self.sosVC=(PB_FirstSOSViewController *)[self.parentViewController.childViewControllers objectAtIndex:0];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.startPoint=[pan translationInView:self.view];
            

            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint=[pan translationInView:self.view];
            CGFloat DeltaX=currentPoint.x-self.startPoint.x;

//            CGFloat ChangeX;
            ChangeX=MIN(DeltaX, 375);
            NSLog(@"%f",ChangeX);
            if (DeltaX>0&&[pan locationInView:self.view].x<KSCREEM_WIDTH*0.8&&self.MainPan==NO) {
                self.popPan=YES;
                vc.panG.enabled=NO;
                self.tableView.scrollEnabled=NO;

            }
            if ([pan locationInView:self.view].x>KSCREEM_WIDTH*0.8&&DeltaX<0&&self.popPan==NO) {
                self.MainPan=YES;
                self.panG.enabled=NO;
            }
            if (self.popPan==YES&&DeltaX>0) {
                [self.view setFrame:CGRectMake(ChangeX, 0, 375, 677)];
                [self.sosVC.view  setTransform:CGAffineTransformScale(self. view.transform, 0.95+0.5*ChangeX/3750, 0.95+0.5*ChangeX/3750)];
            }
            
        }
            break;
    
        case UIGestureRecognizerStateEnded:{
            
            if (ChangeX>60&&self.popPan==YES) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view setFrame:CGRectMake(375, 0, 375, 677)];
                    [self.sosVC.view  setTransform:CGAffineTransformScale(self.view.transform, 1, 1)];
                  
                    vc.panG.enabled=YES;

                } completion:^(BOOL finished) {
                    [self.view removeFromSuperview];
                    [self removeFromParentViewController];
                    
                    
                }];

            }
            else if(ChangeX<=60&&self.popPan==YES){
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view setFrame:CGRectMake(0, 0, 375, 677)];
                    [self.sosVC.view  setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
                    self.popPan=NO;
                    self.MainPan=NO;
                    vc.panG.enabled=YES;
                    self.panG.enabled=YES;
                    self.tableView.scrollEnabled=YES;


                } completion:^(BOOL finished) {
                    

                }];

            
            
            }
            
            
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.view setFrame:CGRectMake(0, 0, 375, 677)];
                [self.sosVC.view  setTransform:CGAffineTransformScale(self.view.transform, 0.95, 0.95)];
            } completion:^(BOOL finished) {
                
                
            }];}
        
        default:
            break;
    }


}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0;
}
//设置uiview边框等属性
-(void)setBorderproperty{
    self.discussInputV.layer.borderColor=[UIColor grayColor].CGColor;
    self.discussInputV.layer.borderWidth=1;
    UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];
    textV.layer.borderColor=[UIColor grayColor].CGColor;
    textV.layer.borderWidth=1;
    textV.layer.cornerRadius=5;

}

#define scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"+++++");
    self.panG.enabled=NO;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
       self.panG.enabled=YES;
    



}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"------");
    
    //如果是imagescroll在调用代理 通过手势结束的位置设置pagec的点
    if (scrollView==imageScrollV) {
        int numberPage=scrollView.contentOffset.x/375;
        NSLog(@"%d",numberPage);
        
        UIPageControl *pageC=(UIPageControl *)[self.tableView viewWithTag:555];
        pageC.currentPage=numberPage;
    }

}

//评论
- (IBAction)discussAction:(UIButton *)sender {
    UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];

    [textV becomeFirstResponder];
    
}
//电话
- (IBAction)connectAction:(UIButton *)sender {
    NSString *str=@"18888888888";
    PB_FirstSOSViewController *first=(PB_FirstSOSViewController *)[self.parentViewController.childViewControllers objectAtIndex:0];
    [first letshowView:str type:KPhoneCall];
    
    
}
//分享
- (IBAction)shareAction:(UIButton *)sender {
    PB_FirstSOSViewController *first=(PB_FirstSOSViewController *)[self.parentViewController.childViewControllers objectAtIndex:0];

    [first letshowView:nil type:KShare];

}
//发送内容
-(void)sendImageNow{

    
}
//发送按钮
- (IBAction)sendImage:(UIButton *)sender {
//  用代理同理 输入空格键判断
    UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];
   NSRange range={textV.text.length,0};
    [self textView:textV shouldChangeTextInRange:range replacementText:@"\n"];

}

- (IBAction)saveAction:(UIButton *)sender {
}
//空白处回收键盘
- (IBAction)resignKeyBoard:(UIControl *)sender {
    UITextView *textV=(UITextView *)[self.discussInputV viewWithTag:666];
    
    [textV resignFirstResponder];
    self.discussInputV.hidden=YES;

    sender.hidden=YES;

}



@end
