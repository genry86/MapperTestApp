//
//  MPRStreet.m
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import "MPRStreet.h"
#import "MPRUtility.h"

@implementation MPRStreet
@synthesize id;
@synthesize streetName;
@synthesize mapIndex;
@synthesize mapIndexName;

-(BOOL)setIndex:(NSString *)mapIndexString{
    
    NSArray *cell1;
    NSArray *cell2;
    
    int x = 0, y = 0, w = 0, h = 0;
    
    
    NSDictionary *charDictionary = [MPRUtility getCellsDictionary];
    
    if ([mapIndexString rangeOfString:@"-"].location == NSNotFound) { //K16
        
        cell1 = [MPRUtility getCharAndNumber:mapIndexString];   // 0-K  1-16
        
        NSString *firstCellXChar = cell1[0]; //K
        NSString *firstCellX = [charDictionary objectForKey:firstCellXChar];
        
        if (firstCellX == nil) return NO;
        
        x = [firstCellX integerValue];  //11
        y = [cell1[1] integerValue];    //16
        w = 1;
        h = 1;
        
    }else{  //K16-L15
        
        NSArray *stringArray = [mapIndexString componentsSeparatedByString: @"-"]; // K16 and L15

        cell1 = [[NSArray alloc] initWithArray:[MPRUtility getCharAndNumber:stringArray[0]]];   // 0-K  1-16
        
        NSString *firstCellXChar = cell1[0]; //K
        NSString *firstCellX = [charDictionary objectForKey:firstCellXChar]; // K -> 11
        
        int x1 = [firstCellX integerValue];  //11
        int y1 = [cell1[1] integerValue];    //16

        cell2 = [MPRUtility getCharAndNumber:stringArray[1]];   // 0-L  1-15
        
        NSString *secondCellXChar = cell2[0]; //L
        NSString *secondCellX = [charDictionary objectForKey:secondCellXChar]; // L -> 12
        
        if (firstCellX == nil || secondCellX == nil) return NO;
        
        int x2 = [secondCellX integerValue];  //12
        int y2 = [cell2[1] integerValue];    //15
        
        x = MIN(x1, x2);
        y = MIN(y1, y2);
        w = abs(x2 - x1)+1;
        h = abs(y2 - y1)+1;
    }
    
    mapIndex = CGRectMake(x, y, w, h);
    
    return YES;
}

@end
