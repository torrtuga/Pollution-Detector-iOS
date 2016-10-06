//
//  HTTPService.m
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import "HTTPService.h"
#import "ViewController.h"


#import "HTTPService.h"
#define URL "https://api.breezometer.com/baqi/?lat=40.7324296&lon=-73.9977264&key=616e4ac1dd3a45ecab60732d06a6fcc0"

@implementation HTTPService

+(id) instance{
    static HTTPService *instance = nil;
    
    @synchronized (self) {
        if(instance == nil){
            instance = [[self alloc]init];
        }
    }
    return instance;
}


-(void) getData : (nullable onComplete)completionHandler {
    _json = [[NSDictionary alloc]init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s",URL]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data != nil){
            NSError *err;
            _json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if(err ==nil){
                //NSLog(@"JSON : %@",_json.debugDescription);
                completionHandler(_json,nil);
            }else {
                completionHandler(nil,@"Data is corrupt");
            }
        }else{
            NSLog(@"Error : %@",error.debugDescription);
            completionHandler(nil,@"Error while receiving");
        }
        
    }]resume];
}






@end
