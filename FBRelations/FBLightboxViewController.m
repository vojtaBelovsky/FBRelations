//
//  FBLightboxViewController.m
//  FBRelations
//
//  Created by Daniel Krezelok on 07/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBLightboxViewController.h"
#import "FBUserDetailInfoCell.h"
#import "FBLightboxDataSource.h"

#define ITEM_SIZE            (CGSize){ 70.0f, 70.0f }
#define ANIMATION_DURATION   0.3f

@interface FBLightboxViewController () {
  FBLightboxDataSource *_dataSource;
}

@end

@implementation FBLightboxViewController

#pragma mark - LifeCycles

- (id)initWithItems:(NSArray *)items title:(NSString *)title {
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  flowLayout.itemSize = ITEM_SIZE;
  self = [super initWithCollectionViewLayout:flowLayout];
  if ( self ) {
    self.title = title;
    _dataSource = [[FBLightboxDataSource alloc] initWithItems:items];
  }
  
  return self;
}

- (void)loadView {
  [super loadView];
  
  self.view.backgroundColor = CLEAR_COLOR;
  self.collectionView.backgroundColor = CLEAR_COLOR;
  [self.collectionView registerClass:[FBUserDetailInfoCell class] forCellWithReuseIdentifier:kUserDetailInfoCellIdentifier];
  
  self.collectionView.showsVerticalScrollIndicator = NO;
  self.collectionView.showsHorizontalScrollIndicator = NO;
  
  self.collectionView.dataSource = _dataSource;
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString( @"Cancel", @"" ) style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDidPress)];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGRect frame = self.collectionView.frame;
  frame.origin.x = 5.0f;
  frame.origin.y = 5.0f;
  frame.size.width -= 2 * CGRectGetMinX( frame );
  frame.size.height -= 2 * CGRectGetMinY( frame );
  self.collectionView.frame = frame;
  
  UIToolbar *toolbar = [[UIToolbar alloc] init];
  toolbar.frame = self.view.frame;
  toolbar.backgroundColor = CLEAR_COLOR;
  toolbar.barStyle = UIBarStyleBlackOpaque;

  [self.view addSubview:toolbar];
  [self.view sendSubviewToBack:toolbar];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  CATransition *slide = [CATransition animation];
  slide.type = kCATransitionPush;
  slide.subtype = kCATransitionFromTop;
  slide.duration = ANIMATION_DURATION;
  slide.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  slide.removedOnCompletion = YES;
  [self.navigationController.view.layer addAnimation:slide forKey:@"slidein"];
}

#pragma mark - UserActions

- (void)cancelButtonDidPress {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
