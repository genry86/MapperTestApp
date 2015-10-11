//
//  MPRStreetCell.h
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPRStreetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *streetNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapIndexLabel;

@end
