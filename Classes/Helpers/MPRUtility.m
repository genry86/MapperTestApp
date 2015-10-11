//
//  MPRUtility.m
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import "MPRUtility.h"

@interface MPRUtility ()

@end

@implementation MPRUtility

static NSDictionary* dic = nil;
+ (NSDictionary*)getCellsDictionary {
    
    if (dic == nil)
        dic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:
                                                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                                     @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                                                     @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",
                                                     nil]
                                                    forKeys:[NSArray arrayWithObjects:
                                                     @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
                                                     @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                                                     @"U",@"V",@"W",@"X",@"Y",@"Z",@"AA",@"AB",
                                                     nil]];
    return dic;
}


+(NSArray*)getCharAndNumber:(NSString*)originalString{
    NSString *numberString;
    NSString *charachterString;
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    [scanner scanUpToCharactersFromSet:numbers intoString:&charachterString];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    NSArray *resultArr = [[NSArray alloc] initWithObjects:charachterString,numberString, nil];
    return resultArr;
}


+(void)sortMArray:(NSMutableArray*)array{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:TRUE];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}


+(void)dispatch:(Block)mainBlock completeBlock:(Block)completeBlock{
    
    const char *queueId = "com.apress.MySerialQueue";
    
    dispatch_queue_t _serial_queue = dispatch_queue_create(queueId, NULL);
    dispatch_suspend(_serial_queue);
    
    dispatch_async(_serial_queue,  ^{
        
        mainBlock();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock();
        });
        
    });
    
    dispatch_resume(_serial_queue);
}


+(NSArray*)loadFileToArray:(NSString*)fileName extension:(NSString*)extension{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    NSError *error;
    NSString *csvFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray *lines = [csvFile componentsSeparatedByString:@"\r\n"];
    return lines;
}

@end
