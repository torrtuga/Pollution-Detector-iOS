//
//  MyTableViewController.h
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myData;
@property (strong, nonatomic) NSMutableArray *array;
@property (weak, nonatomic) NSDictionary *dataJson;

@end
