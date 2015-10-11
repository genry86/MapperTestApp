//
//  MPRStreetsListViewController.h
//  Mapper
//
//  Created by Genry on 7/4/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPRStreetsListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *streetsTable;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
