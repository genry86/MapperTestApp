//
//  MPRMapViewController.m
//  Mapper
//
//  Created by Genry on 7/5/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import "MPRMapViewController.h"
#import "Constants.h"

@interface MPRMapViewController ()
@end

@implementation MPRMapViewController

@synthesize scrollView;
@synthesize imageView;

@synthesize selectedRect;

- (void)viewDidLoad
{
    [super viewDidLoad];

    imageView.frame = CGRectMake(0,0,3407, 3244);
    [imageView setImage:[UIImage imageNamed:kMapImageName]];
    scrollView.contentSize = imageView.frame.size;
    
    [imageView removeFromSuperview];    // bug - remove/add the same view from parent
    [scrollView addSubview:imageView];  // needed to enable scrolling
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpScale:YES];
    
    self.scrollView.zoomScale = kMaxZoomScale;
    
    CGFloat x = 0, y = 0, w = 0, h = 0;

    CGPoint point = self.selectedRect.origin;
    CGSize size = self.selectedRect.size;
    
    CGFloat realRectSize = kMapCellSize;// * self.scrollView.zoomScale; (bug - do not take into account current zoom)
    
    x = ((point.x-1) * realRectSize);
    y = ((point.y-1) * realRectSize);
    
    w = size.width * realRectSize;
    h = size.height * realRectSize;

    CGRect rectToZoomTo = CGRectMake(x, y, w, h);

    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    [self centerScrollViewContents];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {
    [self setUpScale:NO];
}

-(void)setUpScale:(BOOL)toMinimum{
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / kImageWidth; 
    CGFloat scaleHeight = scrollViewFrame.size.height / kImageHeight; 
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = kMaxZoomScale;
    
    if (toMinimum) {
        self.scrollView.zoomScale = kMaxZoomScale;
    }else{
        self.scrollView.zoomScale = self.scrollView.zoomScale;
    }
    
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}


- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

@end
