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

@interface FBUserDetailViewController () {
  FBUser *_user;
}

@end

@implementation FBUserDetailViewController

#pragma mark - LifeCycles

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if ( self ) {
    self.title = NSLocalizedString( @"FBRelations", @"" );
    _user = [[FBUser alloc] initWithUserId:userId];
  }
  
  return self;
}

- (void)loadView {
  self.view = [[FBUserDetailView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self initializeData];
}

#pragma mark - Properties

- (FBUserDetailView *)userDetailView {
  return (FBUserDetailView *)self.view;
}

#pragma mark - Private

- (void)initializeData {
  [self initializeUserInfo];
//  [self initializeFriends];
//  [self initializeMusic];
//  [self initializeMovies];
  [self initializePhotos];
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
  [FBAPI loadFriendsWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializeMusic {
  [FBAPI loadMusicWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    
  } failureBlock:^( NSError *error ) {
   
  }];
}

- (void)initializeMovies {
  [FBAPI loadMoviesWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    
  } failureBlock:^( NSError *error ) {
    
  }];
}

- (void)initializePhotos {
  [FBAPI loadPhotosWithUserId:_user.userId completetionBlock:^( NSArray *data ) {
    
  } failureBlock:^( NSError *error ) {
    
  }];
}
@end
