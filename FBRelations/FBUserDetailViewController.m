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
  }
  
  return self;
}

- (void)loadView {
  self.view = [[FBUserDetailView alloc] init];
  self.userDetailView.collectionView.dataSource = _dataSource;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:ADD style:UIBarButtonItemStylePlain target:self action:@selector(addButtonDidPress)];
  self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self initializeData];
  [FBBeaconManager sharedInstance].locationManager.delegate = self;
}

#pragma mark - Properties

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  if ( [beacons count] ) {
    CLBeacon *beacon = beacons[ 0 ];
    NSLog( @"%@", beacon.major );
  }
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
//  [self initializeFriends];
  [self initializeMusic];
//  [self initializeMovies];
}

- (void)initializeUserInfo {
  [FBAPI loadUserInfoWithId:_user.userId completetionBlock:^( FBUser *user ) {
    _user = user;
    [self.userDetailView setUser:_user];
    [[FBBeaconManager sharedInstance] setUser:user];
  } failureBlock:^( NSError *error ) {
    NSLog( @"%@", error );
  }];
}

- (void)initializeFriends {
  [FBAPI loadFriendsWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializeMusic {
  [FBAPI loadMusicWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    _dataSource.musics = data;
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
   
  }];
}

- (void)initializeMovies {
  [FBAPI loadMoviesWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializePhotos {
  [FBAPI loadPhotosWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    _dataSource.photos = data;
    [self reloadCollection];
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)reloadCollection {
  [self.userDetailView.collectionView reloadData];
  [self.userDetailView setCollectionViewHeight:[_dataSource collectionViewHeight]];
}

@end
