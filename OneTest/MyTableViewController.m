//
//  MyTableViewController.m
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import "MyTableViewController.h"
#import "FMDB.h"

@interface MyTableViewController ()
@property(strong,nonatomic)NSString *str;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myData = [[NSArray alloc]init];
    _str = [[NSString alloc]init];
    
    _myData = [[NSMutableArray alloc]initWithObjects:
              @"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
              @"Data 4 in array",@"Data 5 in array",@"Data 5 in array",
              @"Data 6 in array",@"Data 7 in array",@"Data 8 in array",
              @"Data 9 in array", nil];
    _str = [_dataJson objectForKey:@"breezometer_aqi"];
    NSLog(@"JSON Data receieved from the TableViewController is %@", _dataJson);

//    [_myData addObject:_dataJson[@"country_name"]];
    
    _myData = [_dataJson allKeys];
    
    
    //FMDB PART
    FMResultSet *success;
    BOOL booleanResult;
    FMDatabase *db = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];
    [db open];
    

    
    NSString *sql = @"create table if not exists apiDataTwo (id integer primary key autoincrement, country_name text, breezometer_description text, country_description text, dateString text);";
    booleanResult = [db executeUpdate:sql]; //Creating the table
    
    //Getting the required data in String form
    NSString *country_name = [_dataJson valueForKey:@"country_name"];
    NSString *breezometer_description = [_dataJson valueForKey:@"breezometer_description"];
    NSString *country_description = [_dataJson valueForKey:@"country_description"];
    
//    NSDate *date = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [dateFormatter stringFromDate:date];
//    NSLog(@"Current Date is %@",dateString);
    
//    booleanResult = [db executeUpdate:@"DELETE FROM apiDataTwo"];
    
    NSString *dateString = @"2016-10-07";
    
    //Inserting
    booleanResult = [db executeUpdate:@"insert into apiDataTwo (country_name, breezometer_description, country_description, dateString) VALUES (?,?,?,?)", country_name, breezometer_description,country_description,dateString];
    NSLog(@"Boolean Value %d",booleanResult);
    
    success = [db executeQuery:@"SELECT * FROM apidataTwo;"];
    
    while([success next]){
        
        int first = [success intForColumn:@"id"];
        NSLog(@"The the variable is : %d",first);
        
        NSString *country_name = [success stringForColumn:@"country_name"];
        NSLog(@"The variable is : %@",country_name);
        
        NSString *breezometer_description = [success stringForColumn:@"breezometer_description"];
        NSLog(@"The variable is : %@",breezometer_description);
        
        NSString *country_description = [success stringForColumn:@"country_description"];
        NSLog(@"The variable is : %@",country_description);
        
        NSString *dateString = [success stringForColumn:@"dateString"];
        NSLog(@"The variable is : %@",dateString);
    }
    
 
    [db close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_myData count]/2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *stringForCell;

    stringForCell= [_myData objectAtIndex:indexPath.row];


    [cell.textLabel setText:stringForCell];
    cell.imageView.image = [UIImage imageNamed:@"successIndicator.png"];
    return cell;
}



@end
