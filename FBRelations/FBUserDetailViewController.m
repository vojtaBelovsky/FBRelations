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

@interface FBUserDetailViewController ()

@end

@implementation FBUserDetailViewController

#pragma mark - LifeCycles

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = NSLocalizedString( @"FBRelations", @"" );
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(initializeData)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
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


#pragma mark - Memory Management

- (void)dealloc {
//  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Properties

- (FBUserDetailView *)userDetailView {
  return (FBUserDetailView *)self.view;
}

#pragma mark - Private

- (void)initializeData {

  [FBAPI loadUserInfoWithId:@"me" completetionBlock:^( FBUser *user ) {

  } failureBlock:^( NSError *error ) {
    NSLog( @"%@", error );
  }];
  
//  [FBAPI loadMyFriendsWithCompletetionBlock:^( NSArray *data ) {
//    
//  } failureBlock:^( NSError *error ) {
//    
//  }];
//  [FBAPI loadAlbumsWithUserId:@"me" completetionBlock:nil failureBlock:nil];
  
//  [FBAPI loadMusicWithUserId:@"me" completetionBlock:nil failureBlock:nil];
//    [FBAPI loadMoviesWithUserId:@"me" completetionBlock:nil failureBlock:nil];
//    [FBAPI loadPhotosWithUserId:@"me" completetionBlock:nil failureBlock:nil];
}

@end
