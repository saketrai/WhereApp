//
//  FBELoggedinViewController.m
//  FBEvents
//
//  Created by Saket Rai on 11/14/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import "FBELoggedinViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBEViewController.h"
#import "FBEFriendViewController.h"
#import "FBEEventsViewController.h"

@interface FBELoggedinViewController () <FBEViewControllerDelegate, FBEFriendViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong,nonatomic) NSNumber* tzone;

@end



@implementation FBELoggedinViewController

- (void)setTzone:(NSNumber *)tzone
{
    if (_tzone != tzone) {
        _tzone = tzone;
    }
}
- (IBAction)getFriends:(id)sender {
  
}


- (IBAction)getEvents:(id)sender {
}



- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self showProfileData];
        
     }];
}

-(void) showProfileData
{
    [FBProfilePictureView class];
    
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 
                 self.userNameLabel.text = user.first_name;
                 self.profilePictureView.profileID = user.id;
                 //NSString* userID=user.id;;
                 
                 NSString *query =
                 @"SELECT timezone FROM user WHERE ";
                 query = [query stringByAppendingFormat:@" uid =%@",user.id];
                 

                 // Set up the query parameter
                 NSDictionary *queryParam =
                 [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
                 // Make the API request that uses FQL
                 [FBRequestConnection startWithGraphPath:@"/fql"
                                              parameters:queryParam
                                              HTTPMethod:@"GET"
                                       completionHandler:^(FBRequestConnection *connection,
                                                           id result,
                                                           NSError *error) {
                                           if (error) {
                                               NSLog(@"Error: %@", [error localizedDescription]);
                                           } else {
                                        
                                              
                                               NSNumber *timezone = [[[result objectForKey:@"data"] objectAtIndex:0] objectForKey:@"timezone"];
                                               self.tzone=timezone;
                                                NSLog(@"timezone: %@", self.tzone);
                                               
                                           }
                                       }];
                 //self.tzone = user.timezone;
                // NSLog(@" %@",user.id);
             }
         }];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"Logout"
                                                  style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(logoutButtonWasPressed:)];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // See if we have a valid token for the current state.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whitelinen.png"]];
    
   
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:1.0]];


    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
       // NSLog(@"User session found");
       // NSLog(@"session info2 %@",FBSession.activeSession.accessToken);
        [self openSession];
        
    }
    else
    {
        // No, display the login page.
       // NSLog(@"Not found");
        [self performSegueWithIdentifier: @"Show Login" sender: self];

    }
    //NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
   // NSLog(@"System  timezone is %i",[destinationTimeZone secondsFromGMT]);
    
    
}

-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self performSegueWithIdentifier: @"Show Login" sender: self];
}




-(void) loginViewController:(FBEViewController*) sender
        
{
        [self dismissViewControllerAnimated:YES completion:^{
            
        } ];
        [self showProfileData];

    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Show Login"]) {
        FBEViewController *asker = (FBEViewController *)segue.destinationViewController;
        asker.delegate = self;
    }
//    
//    if ([segue.identifier hasPrefix:@"Show Friends"]) {
//        FBEFriendViewController * friend = (FBEFriendViewController *)segue.destinationViewController;
//        //friend.delegate = self;
//         NSLog(@"Prepared");
//        
//        // Query to fetch the active user's friends, limit to 25.
//        
//        NSString *query =
//        @"SELECT uid, name, pic_square FROM user WHERE uid IN "
//        @"(SELECT uid2 FROM friend WHERE uid1 = me() LIMIT 25)";
//        // Set up the query parameter
//        NSDictionary *queryParam =
//        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
//        // Make the API request that uses FQL
//        [FBRequestConnection startWithGraphPath:@"/fql"
//                                     parameters:queryParam
//                                     HTTPMethod:@"GET"
//                              completionHandler:^(FBRequestConnection *connection,
//                                                  id result,
//                                                  NSError *error) {
//                                  if (error) {
//                                      NSLog(@"Error: %@", [error localizedDescription]);
//                                  } else {
//                                      //NSLog(@"Result: %@", result);
//                                      
//                                      NSArray *friendInfo = (NSArray *) [result objectForKey:@"data"];
//                                      //NSLog(@"Result: %@", friendInfo);
//                                      //[self showFriends:friendInfo];
//                                      
//                                      
//                                     // friend.data=friendInfo;
//                                      
//                                      
//                                      
//                                     friend.data=friendInfo;
//                                     // NSLog(@"Result: %@", friendInfo);
//                                      NSLog(@"Result: %u", friend.data.count);
//
//                                  }
//                              }];
//    
//
//    }
    
    if ([segue.identifier hasPrefix:@"My Events"]) {
        //NSLog(@"Prepared");
        //NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        
        //NSLog(@"Current Date is: %@", [[NSDate date] description]);
        
        
        //int timeStampObj = (int)timeStamp;
        //int timeStampObj2 = timeStampObj+7*24*3600;
       // NSLog(@"Prepared %@",self.tzone);
        
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        // Get the weekday component of the current date
        NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
        
        /*
         Create a date components to represent the number of days to add to the current date.
         The weekday value for Friday in the Gregorian calendar is 6, so add the difference between 6 and today to get the number of days to add.
         Actually, on Saturday that will give you -1, so you want to subtract from 13 then take modulo 7
         */
        NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
        //[componentsToAdd setDay: (13 - [weekdayComponents weekday]) % 7];
        
        [componentsToAdd setDay: [weekdayComponents weekday] +1];
        
        NSDate *tdy = [gregorian dateByAddingComponents:componentsToAdd toDate:today options:0];
        
        /*
         friday now has the same hour, minute, and second as the original date (today).
         To normalize to midnight, extract the year, month, and day components and create a new date from those components.
         */
        NSDateComponents *components =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tdy];
        
        // And to set the time to 20:00
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        
        tdy = [gregorian dateFromComponents:components];
        //int timeStampObj2=(int) [tdy timeIntervalSince1970];
        
        NSString *query =
        @"{"
        @"'friends':'SELECT eid,uid FROM event_member WHERE uid =me() LIMIT 200 ";
       // query = [query stringByAppendingFormat:@" and start_time >=%i and start_time<=%i",timeStampObj,timeStampObj2];
        
        query = [query stringByAppendingFormat:@"',"];
        
        query = [query stringByAppendingFormat:@"'friendinfo':'SELECT eid,name, description,pic_square,pic_big, start_time, location, venue FROM event WHERE eid IN (SELECT eid FROM #friends)',}"];
        
        
       // NSLog(@"%@", query);
        
        
        // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                                  if (error) {
                                      NSLog(@"Error: %@", [error localizedDescription]);
                                  } else {
                                      
                                      
                                      NSArray *friendInfo =
                                      (NSArray *) [[[result objectForKey:@"data"]
                                                    objectAtIndex:1]
                                                   objectForKey:@"fql_result_set"];
                                      
                                       NSLog(@"Result: %@", friendInfo);
                                      //[self showFriends:friendInfo];
                                      
                                      NSMutableArray* data2=[friendInfo mutableCopy ];
                                      // NSLog(@"Initial: %@",data2);
                                      
                                      NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                                                  initWithKey:@"start_time" ascending:YES selector:@selector(compare:)
                                                                  ];
                                      NSArray *data3 = [NSArray arrayWithObject: sorter];
                                      
                                      
                                      NSArray* data4= [data2 sortedArrayUsingDescriptors:data3];
                                      FBEEventsViewController * event=(FBEEventsViewController *)segue.destinationViewController;
                                      event.data=data4;
                                      NSLog(@"Initial: %@",data4);
                                      
                                      
                                  }
                              }];
        
        
    }

    
    if ([segue.identifier hasPrefix:@"Today"]) {
        //NSLog(@"Prepared");
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        
        NSLog(@"Current Date is: %@", [[NSDate date] description]);


        int timeStampObj = (int)timeStamp;
        //int timeStampObj2 = timeStampObj+7*24*3600;
        //NSLog(@"Prepared %@",self.tzone);
        
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        // Get the weekday component of the current date
       // NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
        
        /*
         Create a date components to represent the number of days to add to the current date.
         The weekday value for Friday in the Gregorian calendar is 6, so add the difference between 6 and today to get the number of days to add.
         Actually, on Saturday that will give you -1, so you want to subtract from 13 then take modulo 7
         */
        NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
        //[componentsToAdd setDay: (13 - [weekdayComponents weekday]) % 7];
        
        [componentsToAdd setDay: 1];
        
        NSDate *tdy = [gregorian dateByAddingComponents:componentsToAdd toDate:today options:0];
        
        /*
         friday now has the same hour, minute, and second as the original date (today).
         To normalize to midnight, extract the year, month, and day components and create a new date from those components.
         */
        NSDateComponents *components =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tdy];
        
        // And to set the time to 20:00
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        
        tdy = [gregorian dateFromComponents:components];
       // NSLog(@"Tdy is%@",tdy);
        int timeStampObj2=(int) [tdy timeIntervalSince1970];
        //NSLog(@"Tdy is%@",componentsToAdd);

        NSString *query =
        @"{"
        @"'friends':'SELECT eid,uid FROM event_member WHERE uid in (select uid2 from friend where uid1=me()) ";
        query = [query stringByAppendingFormat:@" and start_time >=%i and start_time<=%i ",timeStampObj,timeStampObj2];
        
        query = [query stringByAppendingFormat:@" LIMIT 200',"];
        
        query = [query stringByAppendingFormat:@"'friendinfo':'SELECT eid,name,description, pic_square,pic_big, start_time, location, venue FROM event WHERE eid IN (SELECT eid FROM #friends)',}"];
        
       //NSLog(@"%@", query);
         
        
        // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                                  if (error) {
                                      NSLog(@"Error: %@", [error localizedDescription]);
                                  } else {
                                      
                                      
                                      NSArray *friendInfo =
                                      (NSArray *) [[[result objectForKey:@"data"]
                                                    objectAtIndex:1]
                                                   objectForKey:@"fql_result_set"];
                                      
                                     // NSLog(@"Result: %@", friendInfo);
                                      //[self showFriends:friendInfo];
                                      
                                      NSMutableArray* data2=[friendInfo mutableCopy ];
                                     // NSLog(@"Initial: %@",data2);
                                      
                                      NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                                                  initWithKey:@"start_time" ascending:YES selector:@selector(compare:)
                                                                  ];
                                      NSArray *data3 = [NSArray arrayWithObject: sorter];
                                      
                                      
                                     NSArray* data4= [data2 sortedArrayUsingDescriptors:data3];
                                    FBEEventsViewController * event=(FBEEventsViewController *)segue.destinationViewController;
                                      event.data=data4;
                                        //NSLog(@"Initial: %@",data4);

                                      
                                  }
                              }];
        
        
    }
    
    if ([segue.identifier hasPrefix:@"Tomorrow"]) {

        
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        // Get the weekday component of the current date
       // NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
        
        /*
         Create a date components to represent the number of days to add to the current date.
         The weekday value for Friday in the Gregorian calendar is 6, so add the difference between 6 and today to get the number of days to add.
         Actually, on Saturday that will give you -1, so you want to subtract from 13 then take modulo 7
         */
        NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
        //[componentsToAdd setDay: (13 - [weekdayComponents weekday]) % 7];
        
        [componentsToAdd setDay: 1];
        
        NSDateComponents *componentsToAdd2 = [[NSDateComponents alloc] init];
        //[componentsToAdd setDay: (13 - [weekdayComponents weekday]) % 7];
        
        [componentsToAdd2 setDay: 2];
        
        NSDate *tdy = [gregorian dateByAddingComponents:componentsToAdd toDate:today options:0];
        NSDate *tmw = [gregorian dateByAddingComponents:componentsToAdd2 toDate:today options:0];
        
        /*
         friday now has the same hour, minute, and second as the original date (today).
         To normalize to midnight, extract the year, month, and day components and create a new date from those components.
         */
        NSDateComponents *components =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tdy];
        
        // And to set the time to 20:00
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        
        NSDateComponents *components2 =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tmw];
        
        // And to set the time to 20:00
        [components2 setHour:0];
        [components2 setMinute:0];
        [components2 setSecond:0];
        
        
        
        tdy = [gregorian dateFromComponents:components];
        tmw = [gregorian dateFromComponents:components2];
        int timeStampObj=(int) [tdy timeIntervalSince1970];
        int timeStampObj2=(int) [tmw timeIntervalSince1970];
        
        NSString *query =
        @"{"
        @"'friends':'SELECT eid,uid FROM event_member WHERE uid in (select uid2 from friend where uid1=me())  ";
        query = [query stringByAppendingFormat:@" and start_time >=%i and start_time<=%i ",timeStampObj,timeStampObj2];
        
        query = [query stringByAppendingFormat:@" LIMIT 200',"];
        
        query = [query stringByAppendingFormat:@"'friendinfo':'SELECT eid,name, description,pic_square,pic_big, start_time, location, venue FROM event WHERE eid IN (SELECT eid FROM #friends)',}"];
        
        NSLog(@"%@", query);
        
        
        // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                                  if (error) {
                                      NSLog(@"Error: %@", [error localizedDescription]);
                                  } else {
                                      
                                      
                                      NSArray *friendInfo =
                                      (NSArray *) [[[result objectForKey:@"data"]
                                                    objectAtIndex:1]
                                                   objectForKey:@"fql_result_set"];
                                      
                                      // NSLog(@"Result: %@", friendInfo);
                                      //[self showFriends:friendInfo];
                                      
                                      NSMutableArray* data2=[friendInfo mutableCopy ];
                                      // NSLog(@"Initial: %@",data2);
                                      
                                      NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                                                  initWithKey:@"start_time" ascending:YES selector:@selector(compare:)
                                                                  ];
                                      NSArray *data3 = [NSArray arrayWithObject: sorter];
                                      
                                      
                                      NSArray* data4= [data2 sortedArrayUsingDescriptors:data3];
                                      FBEEventsViewController * event=(FBEEventsViewController *)segue.destinationViewController;
                                      event.data=data4;
                                     // NSLog(@"Initial: %@",data4);
                                      
                                      
                                  }
                              }];
        
        
    }
    
    if ([segue.identifier hasPrefix:@"Weekend"]) {
        
        
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        // Get the weekday component of the current date
        NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
        
        
        /*
         Create a date components to represent the number of days to add to the current date.
         The weekday value for Friday in the Gregorian calendar is 6, so add the difference between 6 and today to get the number of days to add.
         Actually, on Saturday that will give you -1, so you want to subtract from 13 then take modulo 7
         */
        NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
        [componentsToAdd setDay: (13 - [weekdayComponents weekday]) % 7];
        
       
        
        NSDateComponents *componentsToAdd2 = [[NSDateComponents alloc] init];
        
        [componentsToAdd2 setDay: (3+(13 - [weekdayComponents weekday]) % 7)];
        
       
        
        NSDate *tdy = [gregorian dateByAddingComponents:componentsToAdd toDate:today options:0];
        NSDate *tmw = [gregorian dateByAddingComponents:componentsToAdd2 toDate:today options:0];
     
        
        /*
         friday now has the same hour, minute, and second as the original date (today).
         To normalize to midnight, extract the year, month, and day components and create a new date from those components.
         */
        NSDateComponents *components =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tdy];

        
        
        // And to set the time to 20:00
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        
        NSDateComponents *components2 =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit
                               |NSMinuteCalendarUnit|NSSecondCalendarUnit)
                     fromDate: tmw];
        
        // And to set the time to 20:00
        [components2 setHour:0];
        [components2 setMinute:0];
        [components2 setSecond:0];
        
        
        
        tdy = [gregorian dateFromComponents:components];
        tmw = [gregorian dateFromComponents:components2];
       // NSDateComponents *weekdayComponents2 = [gregorian components:NSWeekdayCalendarUnit fromDate:tmw];
        int timeStampObj2;
        int timeStampObj;
   
            timeStampObj2=(int) [tmw timeIntervalSince1970];
            timeStampObj=(int) [tdy timeIntervalSince1970];
     
        
        
        NSString *query =
        @"{"
        @"'friends':'SELECT eid,uid FROM event_member WHERE uid in (select uid2 from friend where uid1=me())  ";
        query = [query stringByAppendingFormat:@" and start_time >=%i and start_time<=%i ",timeStampObj,timeStampObj2];
        
        query = [query stringByAppendingFormat:@" LIMIT 200',"];
        
        query = [query stringByAppendingFormat:@"'friendinfo':'SELECT eid,name,description, pic_square,pic_big, start_time, location, venue FROM event WHERE eid IN (SELECT eid FROM #friends)',}"];
        
        NSLog(@"%@", query);
        
        
        // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                                  if (error) {
                                      NSLog(@"Error: %@", [error localizedDescription]);
                                  } else {
                                      
                                      
                                      NSArray *friendInfo =
                                      (NSArray *) [[[result objectForKey:@"data"]
                                                    objectAtIndex:1]
                                                   objectForKey:@"fql_result_set"];
                                      
                                      // NSLog(@"Result: %@", friendInfo);
                                      //[self showFriends:friendInfo];
                                      
                                      NSMutableArray* data2=[friendInfo mutableCopy ];
                                      // NSLog(@"Initial: %@",data2);
                                      
                                      NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                                                  initWithKey:@"start_time" ascending:YES selector:@selector(compare:)
                                                                  ];
                                      NSArray *data3 = [NSArray arrayWithObject: sorter];
                                      
                                      
                                      NSArray* data4= [data2 sortedArrayUsingDescriptors:data3];
                                      FBEEventsViewController * event=(FBEEventsViewController *)segue.destinationViewController;
                                      event.data=data4;
                                      //NSLog(@"Initial: %@",data4);
                                      
                                      
                                  }
                              }];
        
        
    }
    
}

@end
