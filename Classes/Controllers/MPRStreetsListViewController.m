//
//  MPRStreetsListViewController.m
//  Mapper
//
//  Created by Genry on 7/4/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import "MPRStreetsListViewController.h"
#import "MPRStreet.h"
#import "MPRStreetCell.h"
#import "MPRUtility.h"
#import "MPRMapViewController.h"

@interface MPRStreetsListViewController ()
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, strong) NSMutableDictionary *sourceDictionary;

@property (nonatomic, strong) NSMutableDictionary *searchableDictionary;
@property (nonatomic, strong) NSMutableArray *searchableKeys;

@property (nonatomic, strong) MPRMapViewController *mapViewController;
@end


@implementation MPRStreetsListViewController

@synthesize streetsTable;
@synthesize searchBar;
@synthesize indicator;

@synthesize sourceDictionary;
@synthesize searchableDictionary;
@synthesize searchableKeys;
@synthesize isSearching;

@synthesize mapViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Streets Map";
    [self.indicator startAnimating];
    
    [MPRUtility dispatch:^{
        NSArray *lines = [MPRUtility loadFileToArray:@"data" extension:@"csv"];
        self.sourceDictionary = [self loadArrayToDictionary:lines];
    } completeBlock:^{
        [self searchStreets];
    }];
    
    self.mapViewController = [[MPRMapViewController  alloc] initWithNibName:@"MPRMapViewController" bundle:nil];
}


-(NSMutableDictionary*)loadArrayToDictionary:(NSArray*)lines{
    
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *arr;
    MPRStreet *street;
    NSMutableString *line;
    NSArray *stringArray;
    NSInteger indexId = 0;
    BOOL indexAvailable;
    
    for (int i = 1; i < lines.count; i++){
        line = lines[i];
        
        if(line.length == 1){
            arr = [[NSMutableArray alloc] init];
            [resultDictionary setObject:arr forKey:line];
        }else{
            stringArray = [line componentsSeparatedByString: @","];
            if (stringArray.count == 3) {
                street = [[MPRStreet alloc] init];
                
                street.id = indexId;
                street.streetName = stringArray[1];
                street.mapIndexName = stringArray[2];
                indexAvailable = [street setIndex:street.mapIndexName];
                
                if(indexAvailable){
                    [arr addObject:street];
                    indexId++;
                }
            }
        }
    }
    return resultDictionary;
}


- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)runSearch{
    [self.indicator startAnimating];
    [self performSelector:@selector(searchStreets) withObject:nil afterDelay:2];
}

-(void)searchStreets{
    
    NSString *searchPhrase = self.searchBar.text;
    
    if (searchPhrase.length > 0) {
        
        self.searchableDictionary = [[NSMutableDictionary alloc] init];
        self.searchableKeys = [[NSMutableArray alloc] init];
        
        NSPredicate *predicate;
        NSString *filter = [[NSString alloc] initWithFormat:@"streetName BEGINSWITH[cd]  '%@'",searchPhrase];
        NSArray *results;
        
        for(NSString *key in self.sourceDictionary){
            NSMutableArray *sectionArray = self.sourceDictionary[key];
            
            predicate = [NSPredicate predicateWithFormat:filter ];
            results = [sectionArray filteredArrayUsingPredicate: predicate];
            
            if (results.count > 0) {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:results];
                [self.searchableDictionary setObject:arr forKey:key];
                [self.searchableKeys addObject:key];
            }
        }
    }else{
        
        self.searchableDictionary = [[NSMutableDictionary alloc] initWithDictionary:self.sourceDictionary copyItems:YES];
        self.searchableKeys = [[NSMutableArray alloc] initWithArray:[self.searchableDictionary allKeys]];
    }
    
    [MPRUtility sortMArray:self.searchableKeys];
    [self.streetsTable reloadData];
    self.isSearching = NO;
    [self.indicator stopAnimating];
}

-(MPRStreet *)streetByIndexPath:(NSIndexPath *)indexPath{
    NSInteger sectionIndex = [indexPath section];
    NSInteger rowIndex = [indexPath row];
    NSMutableArray *sectionArr = self.searchableDictionary[self.searchableKeys[sectionIndex]];
    
    return (MPRStreet*)sectionArr[rowIndex];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.searchableDictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionName = self.searchableKeys[section];
    NSMutableArray *arrayStreets = (NSMutableArray*)self.searchableDictionary[sectionName];
    return arrayStreets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StreetCell";
    MPRStreet *street = [self streetByIndexPath:indexPath];
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [self.streetsTable registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    MPRStreetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.idLabel.text = [[NSString alloc] initWithFormat:@"%d",street.id];
    cell.streetNameLabel.text = street.streetName;
    cell.mapIndexLabel.text = street.mapIndexName;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.searchableKeys[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPRStreet *street = [self streetByIndexPath:indexPath];
    self.mapViewController.selectedRect = street.mapIndex;
    
    self.mapViewController.title = street.streetName;
    
    [self.view endEditing:YES];
    [self.navigationController pushViewController:self.mapViewController animated:YES];
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (!self.isSearching) {
        self.isSearching = YES;
        [self runSearch];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [self.view endEditing:YES];
    self.searchBar.text = @"";
    [self runSearch];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self runSearch];
}

@end
