//
//  FBEEventsViewController.h
//  FBEvents
//
//  Created by Saket Rai on 11/21/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FBEEventsViewController : UITableViewController
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data6;
@property (nonatomic) double userLat;
@property (nonatomic) double userLon;
@property (nonatomic) double dist3;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;




@end
