//
//  PB-SOSPOPMapViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/24.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPMapViewController.h"
#import "PB-LocationCell.h"
@interface PB_SOSPOPMapViewController ()

@end

@implementation PB_SOSPOPMapViewController{
    float latitude;
    float longitude;
    CLLocationManager  *locationManager;
    NSMutableArray *allLocationName;
    NSMutableArray *allLocationDetail;
    NSInteger cellCount;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    allLocationName=[NSMutableArray array];
    allLocationDetail=[NSMutableArray array];

    [_mapView setMapType:MKMapTypeStandard];
    _mapView.showsUserLocation=YES;
   

    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLocationManager];
    

}
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

-(void)issueLocalSearchLookup:(NSString *)searchString region:(MKCoordinateRegion)region
{
    [allLocationName removeAllObjects];
    [allLocationDetail removeAllObjects];

    MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
           localSearchRequest.region = region;
        localSearchRequest.naturalLanguageQuery = @"hotel";
        MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSLog(@"%@",response);
        for (MKMapItem *mapItem in response.mapItems) {
//tableview信息添加
            [allLocationName addObject:mapItem.name];
            [allLocationDetail addObject:mapItem.placemark.administrativeArea];
            NSLog(@"%@",mapItem);
        }
        cellCount=[allLocationName count];
        [self.tableView reloadData];

    }];
    
    
                 }

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;


   
    MKCoordinateSpan span = {0.01, 0.01};
    MKCoordinateRegion region = {centerCoordinate, span};
    
   [self issueLocalSearchLookup:nil region:region];
    
  //    获取中心点的位置
    NSLog(@" +++++++regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
//    在结束改变位置 放下标注 并且搜索位置 和附件的位置
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//在开始改变位置的时候 抬起标注
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *gett;
    
    for (CLLocation *get in locations) {
        
        latitude= get.coordinate.latitude;
        longitude=get.coordinate.longitude;
        gett=get;
    }
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = latitude;
    centerCoordinate.longitude = longitude;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = span;
    [_mapView setRegion:region animated:YES];

    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:gett completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
//            [self.currentLocation addObject:placemark.administrativeArea];
//            [self.currentLocation addObject:placemark.subLocality];
//            [self.currentLocation addObject:placemark.name];
//            NSLog(@"%@",self.currentLocation);
            
            
        }
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *indefier=@"cell";
   PB_LocationCell *cell=[tableView dequeueReusableCellWithIdentifier:indefier];
   
    if ([allLocationDetail count]!=0) {
        cell.locationLabel.text=[allLocationName objectAtIndex:indexPath.row];
        cell.locationDetalLabel.text=[allLocationDetail objectAtIndex:indexPath.row];

        
    }
       return cell;


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
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"11");

}
- (IBAction)findCurrentLocation:(UIButton *)sender {
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = latitude;
    centerCoordinate.longitude = longitude;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = span;
    [_mapView setRegion:region animated:YES];
    

}
@end
