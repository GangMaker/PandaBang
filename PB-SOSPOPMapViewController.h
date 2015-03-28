//
//  PB-SOSPOPMapViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface PB_SOSPOPMapViewController : UIViewController<MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)findCurrentLocation:(UIButton *)sender;
- (IBAction)completeButton:(UIButton *)sender;

@end
