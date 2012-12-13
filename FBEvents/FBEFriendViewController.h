//
//  FBEFriendViewController.h
//  FBEvents
//
//  Created by Saket Rai on 11/13/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBEFriendViewController  ;

@protocol FBEFriendViewControllerDelegate <NSObject>

@end

@interface FBEFriendViewController : UITableViewController

@property (strong, nonatomic) NSArray *data;

@property (nonatomic, weak) id <FBEFriendViewControllerDelegate> delegate;


@end
