//
//  MPRStreetCell.m
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import "MPRStreetCell.h"

@implementation MPRStreetCell
@synthesize idLabel;
@synthesize streetNameLabel;
@synthesize mapIndexLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
