//
//  MapViewController.m
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property(strong,nonatomic) CLLocation *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myMapView.showsUserLocation = YES;
    _myMapView.showsBuildings = YES;
    
    _locationManager = [[CLLocation alloc]init];
    
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager performSelector: @selector(requestWhenInUseAuthorization)];
    }
   
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

@end
