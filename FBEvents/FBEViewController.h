//
//  FBEViewController.h
//  FBEvents
//
//  Created by Saket Rai on 11/10/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class FBEViewController  ;

@protocol FBEViewControllerDelegate <NSObject>
-(void) loginViewController:(FBEViewController*) sender;
@end





@interface FBEViewController : UIViewController

@property (nonatomic,copy) NSString* state2;

@property (nonatomic, weak) id <FBEViewControllerDelegate> delegate;

//extern NSString *const FBSessionStateChangedNotification;


@end
