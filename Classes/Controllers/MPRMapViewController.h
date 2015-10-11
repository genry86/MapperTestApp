//
//  MPRMapViewController.h
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPRMapViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (assign, nonatomic) CGRect selectedRect;

- (void)centerScrollViewContents;
@end
