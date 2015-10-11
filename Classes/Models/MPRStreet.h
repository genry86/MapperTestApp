//
//  MPRStreet.h
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPRStreet : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *streetName;
@property (nonatomic, copy) NSString *mapIndexName;
@property (nonatomic, assign) CGRect mapIndex;

-(BOOL)setIndex:(NSString *)mapIndexString;
@end
