//
//  DisplayViewController.m
//  OneTest
//
//  Created by arqam ahmed on 10/4/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import "DisplayViewController.h"
#import "FMDB.h"

@interface DisplayViewController ()


@property(strong,nonatomic) NSDictionary *animals;
@property(strong,nonatomic) NSArray *animalSectionTitles;

@property(strong,nonatomic) NSMutableDictionary *dataDictionary;
@property(strong,nonatomic) NSMutableArray *dateSectionArray;
@property(strong,nonatomic) NSMutableArray *tempArray;


@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataDictionary = [[NSMutableDictionary alloc]init];
    _dateSectionArray = [[NSMutableArray alloc]init];
    _tempArray = [[NSMutableArray alloc]init];
    
    _animals = @{@"B" : @[@"Bear", @"Black Swan", @"Buffalo"],
                 @"C" : @[@"Camel", @"Cockatoo"],
                 @"D" : @[@"Dog", @"Donkey"],
                 @"E" : @[@"Emu"],
                 @"G" : @[@"Giraffe", @"Greater Rhea"],
                 @"H" : @[@"Hippopotamus", @"Horse"],
                 @"K" : @[@"Koala"],
                 @"L" : @[@"Lion", @"Llama"],
                 @"M" : @[@"Manatus", @"Meerkat"],
                 @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
                 @"R" : @[@"Rhinoceros"],
                 @"S" : @[@"Seagull"],
                 @"T" : @[@"Tasmania Devil"],
                 @"W" : @[@"Whale", @"Whale Shark", @"Wombat"]};
    _animalSectionTitles = [[_animals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    //FMDB PART
    FMResultSet *success;
    BOOL booleanResult;
    FMDatabase *db = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];
    [db open];
    
    success = [db executeQuery:@"SELECT * FROM apidataTwo;"];
    
    while([success next]){
        
        NSString *dateString= [success stringForColumn:@"dateString"];
        NSLog(@"The variable is : %@",dateString);
        if(![_dateSectionArray containsObject:dateString]){
            [_dateSectionArray addObject:dateString];
            _tempArray = [[NSMutableArray alloc]init];
        }
        
        int first = [success intForColumn:@"id"];
        NSLog(@"The the variable is : %d",first);
        NSString *id = [NSString stringWithFormat:@"%d",first];
        [_tempArray addObject:id];
        
        NSString *country_name = [success stringForColumn:@"country_name"];
        NSLog(@"The variable is : %@",country_name);
        [_tempArray addObject:country_name];
        
        NSString *breezometer_description = [success stringForColumn:@"breezometer_description"];
        NSLog(@"The variable is : %@",breezometer_description);
        [_tempArray addObject:breezometer_description];
        
        NSString *country_description = [success stringForColumn:@"country_description"];
        NSLog(@"The variable is : %@",country_description);
        [_tempArray addObject:country_description];
        
        if(!_dataDictionary[dateString]){
            NSArray *array = [NSArray arrayWithObjects: id,country_name,breezometer_description,country_description, nil];
            
            [_dataDictionary setObject: array forKey:dateString];
        }
        
        else{
            [_dataDictionary setObject:_tempArray forKey:dateString];
        }
     
    }
    
    NSLog(@"Dictionary is %@",_dataDictionary);
    NSLog(@"The array length is %lu",(unsigned long)[_dateSectionArray count]);
    
    NSArray *sectionArrayObject = [_dataDictionary objectForKey:@"2016-10-05"];
    NSLog(@"Array is %@",sectionArrayObject);
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_dateSectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionTitle = [_dateSectionArray objectAtIndex:section];
    //NSLog(@"Section Title is %@",sectionTitle);
    NSArray *sectionArrayObject = [_dataDictionary objectForKey:sectionTitle];
    NSLog(@"SectionArrayObject is %@",sectionArrayObject);
    NSLog(@"Data section count is %lu",(unsigned long)[sectionArrayObject count]);
    return [sectionArrayObject count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *sectionTitle = [_dateSectionArray objectAtIndex:indexPath.section];
    NSArray *sectionArrayObject = [_dataDictionary objectForKey:sectionTitle];
    NSString *data = [sectionArrayObject objectAtIndex:indexPath.row];
    NSLog(@"Data is %@",data);
    cell.textLabel.text = data;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *test = [_dateSectionArray objectAtIndex:section];
    return test;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
