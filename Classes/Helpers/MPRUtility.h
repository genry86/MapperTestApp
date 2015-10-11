//
//  MPRUtility.h
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block)();

@interface MPRUtility : NSObject
+(void)dispatch:(Block)mainBlock completeBlock:(Block)completeBlock;
+(NSArray*)loadFileToArray:(NSString*)fileName extension:(NSString*)extension;
+(void)sortMArray:(NSMutableArray*)array;
+(NSArray*)getCharAndNumber:(NSString*)originalString;
+ (NSDictionary*)getCellsDictionary;
@end
