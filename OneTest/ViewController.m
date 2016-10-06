//
//  ViewController.m
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "MyTableViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [[HTTPService instance] getData:^(NSDictionary * _Nullable jsonData, NSString * _Nullable errMessage) {
        if(jsonData){
            //NSLog(@"JSON Data from the main thread : %@",jsonData.debugDescription);
            _data = jsonData;
            //NSLog(@"JSON Data from the main thread : %@",_data.debugDescription);
        }else if(errMessage){
            NSLog(@"JSON data not received in the main thread");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"passSegue"]){
        MyTableViewController *tableViewController = segue.destinationViewController;
        tableViewController.dataJson = _data;
        //NSLog(@"JSON Data from the main thread : %@",_data.debugDescription);
        
    }
    
}


@end
