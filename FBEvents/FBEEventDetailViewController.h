//
//  FBEEventDetailViewController.h
//  FBEvents
//
//  Created by Saket Rai on 11/22/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBEEventDetailViewController : UIViewController

@property (nonatomic,strong) NSString * eventHeader;
@property (nonatomic,strong) NSString * imageURL;

@property (nonatomic,strong) NSString * eventTime;
@property (nonatomic,strong) NSString * eventID;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventLocation;

@end
