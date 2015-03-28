//
//  PB-SOSPOPMapViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPMapViewController.h"
#import "PB-LocationCell.h"
#import "locationInfo.h"
@interface PB_SOSPOPMapViewController ()

@end

@implementation PB_SOSPOPMapViewController{
    float latitude;
    float longitude;
    CLLocationManager  *locationManager;
    NSMutableArray *allLocationName;
    NSMutableArray *allLocationDetail;
     NSMutableArray *allLocationFind;
    NSInteger cellCount;
    BOOL seletedCell;
    NSIndexPath *recordCell;
    NSInteger recordCellN;
    NSString *locationWeizhi;
    CLLocation *gett;
    locationInfo *locInfo;
    NSString *chooseLocationLabel;
    CLLocation *chooseLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    存放获取周边位置信息的名字 详细地址 和位置
    allLocationName=[NSMutableArray array];
    allLocationDetail=[NSMutableArray array];
    allLocationFind=[NSMutableArray array];

    [_mapView setMapType:MKMapTypeStandard];
    _mapView.showsUserLocation=YES;
   

    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    recordCell=[NSIndexPath indexPathForRow:0 inSection:0];
    locInfo=[locationInfo defaultManager];
//    获取当前的位置坐标
    CLLocation *location=[locInfo getLocation];
    NSLog(@"%@",location);
    chooseLocation=location;
    longitude=location.coordinate.longitude;
    latitude=location.coordinate.latitude;
//    获取当前位置的地址
    locationWeizhi=[locInfo getLocationLabel];
    chooseLocationLabel=locationWeizhi;
//    找到当前位置
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = latitude;
    centerCoordinate.longitude = longitude;
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = {centerCoordinate, span};
    
    [_mapView setRegion:region animated:YES];
    
    

}

-(void)issueLocalSearchLookup:(NSString *)searchString region:(MKCoordinateRegion)region
{
//    每次检索周边信息 清空数组
    [allLocationName removeAllObjects];
    [allLocationDetail removeAllObjects];
    [allLocationFind removeAllObjects];
    recordCell=[NSIndexPath indexPathForRow:0 inSection:0];

    MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
           localSearchRequest.region = region;
        localSearchRequest.naturalLanguageQuery =searchString;
        MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem *mapItem in response.mapItems) {
//tableview信息添加
            [allLocationName addObject:mapItem.name];
            [allLocationDetail addObject:mapItem.placemark.administrativeArea];
            [allLocationFind addObject:mapItem.placemark.location];
            
        }
        CLLocation *  location =[[CLLocation alloc]initWithLatitude:region.center.latitude longitude:region.center.longitude];
        chooseLocation=location;
        chooseLocationLabel=locationWeizhi;
        NSLog(@"%@",chooseLocationLabel);
        cellCount=[allLocationName count]+1;
        NSLog(@"%ld",(long)cellCount);
       [self.tableView reloadData];

    }];
    
    
                 }

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//在移动mapview时候调用
//    找到移动后中心点位置的地址显示在tableview第一行
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
   CLLocation *  location =[[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
   
    [geocoder reverseGeocodeLocation: location
 completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            locationWeizhi=[NSString stringWithFormat:@"%@ %@ %@",placemark.administrativeArea,placemark.subLocality,placemark.name];
            
        }
        
        
    }];
    
     MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = {centerCoordinate, span};
    if (seletedCell==NO) {
        [self issueLocalSearchLookup:@"hotel" region:region];
       

    }
    seletedCell=NO;
   
 }

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//在开始改变位置的时候 抬起标注
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *indefier=@"cell";
   PB_LocationCell *cell=[tableView dequeueReusableCellWithIdentifier:indefier];
   
    if ([allLocationDetail count]!=0) {
        if (indexPath.row==0) {
            cell.locationLabel.text=@"位置";
            cell.locationDetalLabel.text=locationWeizhi;
                   }
        else{
        cell.locationLabel.text=[allLocationName objectAtIndex:indexPath.row-1];
        cell.locationDetalLabel.text=[allLocationDetail objectAtIndex:indexPath.row-1];
                   }
        
        

        
    }
    
    
    if (indexPath==recordCell) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType=UITableViewCellAccessoryNone;

    }
    
       return cell;


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=0) {
        
    
    PB_LocationCell *lastCell=(PB_LocationCell*)[tableView cellForRowAtIndexPath:recordCell];
    lastCell.accessoryType=UITableViewCellAccessoryNone;
    PB_LocationCell *newCell=(PB_LocationCell*)[tableView cellForRowAtIndexPath:indexPath];
    newCell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    [self findPlace:[allLocationFind objectAtIndex:indexPath.row-1]];
           recordCell=indexPath;
        chooseLocation=[allLocationFind objectAtIndex:indexPath.row-1];
        chooseLocationLabel=[allLocationDetail objectAtIndex:indexPath.row-1];;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellCount;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)findPlace:(CLLocation * )locatio{
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = {locatio.coordinate, span};

      [_mapView setRegion:region animated:YES];
    seletedCell=YES;
    



}
- (IBAction)findCurrentLocation:(UIButton *)sender {
    locationInfo *loc=[locationInfo defaultManager];

    
       MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = {[[loc getUserLocation]coordinate], span};

    [_mapView setRegion:region animated:YES];
    

}

- (IBAction)completeButton:(UIButton *)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    locInfo=[locationInfo defaultManager];
    [locInfo saveLocationLabel:chooseLocationLabel];
    [locInfo saveLocation:chooseLocation];
    
    
    
    

}

@end
