//
//  HTTPService.h
//  OneTest
//
//  Created by arqam ahmed on 9/30/16.
//  Copyright © 2016 arqam ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^onComplete)(NSDictionary * __nullable dataDict, NSString * __nullable errMessage);

@interface HTTPService : NSObject

+(id) instance;
-(void) getData :(nullable onComplete)completionHandler;
@property (strong, nonatomic) NSDictionary *json;

@end
