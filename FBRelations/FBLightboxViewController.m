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
#import "FBGalleryViewController.h"
#import "FBAPI.h"
#import "FBPictureEntity.h"

#define ITEM_SIZE            (CGSize){ 70.0f, 70.0f }
#define ANIMATION_DURATION   0.3f

static CGFloat activityIndicatorHeight = 50.0f;

@interface FBLightboxViewController () {
  FBLightboxDataSource *_dataSource;
  UIActivityIndicatorView *_nextPageLoadingView;
  BOOL _isAnimated;
}

@end

@implementation FBLightboxViewController

#pragma mark - LifeCycles

- (id)initWithItems:(NSArray *)items title:(NSString *)title nextPageUrl:(NSString *)nextPageUrl {
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  flowLayout.itemSize = ITEM_SIZE;
  self = [super initWithCollectionViewLayout:flowLayout];
  if ( self ) {
    self.title = title;
    _dataSource = [[FBLightboxDataSource alloc] initWithItems:items];
    _dataSource.nextPageUrl = nextPageUrl;
    _isAnimated = NO;
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
  frame.size.height -= CGRectGetMinY( frame );
  self.collectionView.frame = frame;
  
  UIToolbar *toolbar = [[UIToolbar alloc] init];
  toolbar.frame = self.view.frame;
  toolbar.backgroundColor = CLEAR_COLOR;
  toolbar.barStyle = UIBarStyleBlackOpaque;

  [self.view addSubview:toolbar];
  [self.view sendSubviewToBack:toolbar];
  
  _nextPageLoadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  [_nextPageLoadingView stopAnimating];
  _nextPageLoadingView.frame = (CGRect){ 0.0f, CGRectGetHeight( self.view.frame ) - activityIndicatorHeight, CGRectGetWidth( self.collectionView.frame ), activityIndicatorHeight };


  [self.view addSubview:_nextPageLoadingView];
  DKCreateMotionEffect( self.collectionView );
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if ( !_isAnimated ) {
    CATransition *slide = [CATransition animation];
    slide.type = kCATransitionPush;
    slide.subtype = kCATransitionFromTop;
    slide.duration = ANIMATION_DURATION;
    slide.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    slide.removedOnCompletion = YES;
    [self.navigationController.view.layer addAnimation:slide forKey:@"slidein"];
    _isAnimated = YES;
  }
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGSize contentSize = scrollView.contentSize;
  CGSize frameSize = scrollView.frame.size;
  CGPoint contentOffset = scrollView.contentOffset;
  if ( ( contentOffset.y >= fabs( contentSize.height - frameSize.height ) ) &&
      !_nextPageLoadingView.isAnimating && _dataSource.nextPageUrl ) {
    [self reloadData];
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  FBGalleryViewController *galleryViewController = [[FBGalleryViewController alloc] initWithItems:_dataSource.items startIndex:indexPath.row];
  [self.navigationController pushViewController:galleryViewController animated:YES];
}

#pragma mark - UserActions

- (void)cancelButtonDidPress {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

- (void)reloadData {
  [_nextPageLoadingView startAnimating];
  id<FBPictureEntity> firstObject = [_dataSource.items firstObject];
  
  [FBAPI loadWithPageUrl:_dataSource.nextPageUrl type:firstObject.entityType completetionBlock:^( NSArray *items, NSString *nextPageUrl ) {
    [self reloadDataSourceWithItems:items nextPageUrl:nextPageUrl];
  } failureBlock:^( NSError *error ) {
    [_nextPageLoadingView stopAnimating];
  }];
}

#pragma mark - Private

- (void)reloadDataSourceWithItems:(NSArray *)items nextPageUrl:(NSString *)nextPageUrl {
  _dataSource.nextPageUrl = nextPageUrl;
  [_dataSource.items addObjectsFromArray:items];
  [self.collectionView reloadData];
  [_nextPageLoadingView stopAnimating];
}

@end
