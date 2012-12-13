//
//  FBEEventCell.h
//  FBEvents
//
//  Created by Saket Rai on 11/23/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBEEventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
//@property (weak, nonatomic) IBOutlet UILabel *eventLocation2;

@end
