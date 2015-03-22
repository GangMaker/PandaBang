//
//  PB-MessageViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/3/6.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PB-FirstSOSViewController.h"
#import "ViewController.h"
@interface PB_MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)BOOL  popPan;
@property(nonatomic,assign)BOOL MainPan;;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backVC:(UIBarButtonItem *)sender;
@property(nonatomic,retain)PB_FirstSOSViewController *sosVC;
@property(nonatomic,retain)UIPanGestureRecognizer *panG;
@property(nonatomic,assign)CGPoint startPoint;

@end
