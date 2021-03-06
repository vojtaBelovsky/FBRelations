//
//  FBUserDetailViewController.m
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserDetailViewController.h"
#import "FBUserDetailView.h"
#import "FBAPI.h"
#import "FBUser.h"
#import "FBUserDetailDataSource.h"
#import "FBBeaconManager.h"
#import "FBLightboxViewController.h"
#import "FBAppDelegate.h"

#define ADD  [UIImage imageNamed:@"plusbutton"]

@interface FBUserDetailViewController () {
  FBUser *_user;
  FBUserDetailDataSource *_dataSource;
}

@end

@implementation FBUserDetailViewController

#pragma mark - LifeCycles

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if ( self ) {
    self.title = NSLocalizedString( @"FBRelations", @"" );
    _user = [[FBUser alloc] initWithUserId:userId];
    _dataSource = [[FBUserDetailDataSource alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializeData) name:kCurrentUserDidLoadNotification object:nil];
  }
  
  return self;
}

- (void)loadView {
  self.view = [[FBUserDetailView alloc] init];
  self.userDetailView.collectionView.dataSource = _dataSource;
  self.userDetailView.collectionView.delegate = self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:ADD style:UIBarButtonItemStylePlain target:self action:@selector(addButtonDidPress)];
  self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if ( ![_dataSource allDataIsLoaded] ) {
    [self initializeData];
  }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *items = _dataSource.items[ indexPath.section ];
  NSString *title = _dataSource.headerTitles[ indexPath.section ];
  NSString *nextPageUrl = _dataSource.nextPagesDict[ title ];
  
  FBLightboxViewController *lightboxViewController = [[FBLightboxViewController alloc] initWithItems:items title:title nextPageUrl:nextPageUrl];
  
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lightboxViewController];
  self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
  self.navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  [self presentViewController:navController animated:YES completion:NULL];
}

#pragma mark - Properties

- (FBUserDetailView *)userDetailView {
  return (FBUserDetailView *)self.view;
}

#pragma mark - UserActions

- (void)addButtonDidPress {
  
}

#pragma mark - Private

- (void)initializeData {
  [self initializeUserInfo];
  [self initializePhotos];
  [self initializeMusic];
  [self initializeMovies];
}

- (void)initializeUserInfo {
  [FBAPI loadUserInfoWithId:_user.userId completetionBlock:^( FBUser *user ) {
    _user = user;
    [self.userDetailView setUser:_user];
  } failureBlock:^( NSError *error ) {
    NSLog( @"%@", error );
  }];
}

- (void)initializeFriends {
  [FBAPI loadFriendsWithUserId:_user.userId completetionBlock:^( NSArray *data, NSString *nextPageUrl ) {
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializeMusic {
  [FBAPI loadMusicWithUserId:_user.userId completetionBlock:^( NSArray *data, NSString *nextPageUrl ) {
    _dataSource.musics = data;
    if ( nextPageUrl ) {
      _dataSource.nextPagesDict[ NSLocalizedString( @"Music", @"" ) ] = nextPageUrl;
    }
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
   
  }];
}

- (void)initializeMovies {
  [FBAPI loadMoviesWithUserId:_user.userId completetionBlock:^( NSArray *data, NSString *nextPageUrl ) {
    _dataSource.movies = data;
    if ( nextPageUrl ) {
      _dataSource.nextPagesDict[ NSLocalizedString( @"Movies", @"" ) ] = nextPageUrl;
    }
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializePhotos {
  [FBAPI loadPhotosWithUserId:_user.userId completetionBlock:^( NSArray *data, NSString *nextPageUrl ) {
    _dataSource.photos = data;
    if ( nextPageUrl ) {
      _dataSource.nextPagesDict[ NSLocalizedString( @"Photos", @"" ) ] = nextPageUrl;
    }
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)reloadCollection {
  [self.userDetailView.collectionView reloadData];
  if ( [_dataSource allDataIsLoaded] ) {
    [self.userDetailView setCollectionViewHeight:[_dataSource collectionViewHeight]];
  }
}

@end
