//
//  FBEEventsViewController.m
//  FBEvents
//
//  Created by Saket Rai on 11/21/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import "FBEEventsViewController.h"
#import "FBEEventDetailViewController.h"
#import "FBEEventCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import <CoreLocation/CoreLocation.h>


@interface FBEEventsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *locationIcon;
@property (strong, nonatomic) IBOutlet UILabel *Title;
//@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation FBEEventsViewController


// locationManager = _locationManager;
@synthesize userLat = _userLat;
@synthesize userLon = _userLon;;

@synthesize data=_data;
@synthesize dist3=_dist;

  

//- (void)setData6:(NSArray *)data6
//{
//    if (_data6 != data6) {
//        _data6 = data6;
//    }
//    
//  
//        NSMutableArray* data7= [_data6 mutableCopy];
//    
//        NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
//                                    initWithKey:@"distance" ascending:YES selector:@selector(compare:)
//                                    ];
//        NSArray *data8 = [NSArray arrayWithObject: sorter];
//    
//    
//    
//    
//    NSArray* data9= [data6 sortedArrayUsingDescriptors:data8];
//     _data6=data9;
//}


- (void)setData:(NSArray *)data
{
    if (_data != data) {
        _data = data;
        
        if(_data.count==0)
        {
            UILabel *textView =[[UILabel alloc]init];
            textView.frame=CGRectMake(20,100,280,40);
            [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
            [textView setTextColor:[UIColor whiteColor]];
            [textView setTextAlignment:NSTextAlignmentCenter];
            [textView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:textView];
            textView.text=@"No Events Found! :(";
             [self.spinner stopAnimating];
        }
    }

   // __block NSMutableArray* newdata=[[NSMutableArray alloc]init];
   // NSMutableArray* data2= [_data mutableCopy];

    
    
//    
//
//    for (int i=0; i<self.data.count; i++) {
//        
//        if (![[[self.data objectAtIndex:i]
//               objectForKey:@"venue"] objectForKey:@"id"])
//        {
//            //NSLog(@"%@",@"NA");
//        
//        NSNumber *dist2 = [NSNumber numberWithDouble:999.9];
//        [newdata addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[self.data objectAtIndex:i]objectForKey:@"name"],@"name",
//                            [[self.data objectAtIndex:i]objectForKey:@"start_time"],@"start_time",
//                            [[self.data objectAtIndex:i]objectForKey:@"location"],@"location",
//                            [[self.data objectAtIndex:i]objectForKey:@"pic_square"],@"pic_square",
//                            dist2,@"distance",
//                            nil]];
//        
//           // cell.distance.text = loc;
//        } else
//        {
//            NSNumber* loc= [[[self.data objectAtIndex:i]
//                             objectForKey:@"venue"] objectForKey:@"id"];
//            
//            
//            NSString *query =
//            @"select location from page where";
//            query = [query stringByAppendingFormat:@" page_id=%@",loc];
    
            //query = [query stringByAppendingFormat:@"',"];
            // Set up the query parameter
//            NSDictionary *queryParam =
//            [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
//            // Make the API request that uses FQL
//          // __block double dist4 =-999.9;
//            [FBRequestConnection startWithGraphPath:@"/fql"
//                                         parameters:queryParam
//                                         HTTPMethod:@"GET"
//                                  completionHandler:^(FBRequestConnection *connection,
//                                                      id result,
//                                                      NSError *error) {
//                                      if (error) {
//                                          NSLog(@"Error: %@", [error localizedDescription]);
//                                      } else {
//                                          NSNumber* lon=  [[[(NSArray*)[ result objectForKey:@"data"] objectAtIndex:0]objectForKey:@"location"] objectForKey:@"longitude"];
//                                          NSNumber* lat=  [[[(NSArray*)[ result objectForKey:@"data"] objectAtIndex:0]objectForKey:@"location"] objectForKey:@"latitude"];
//                                          double lon2=[lon doubleValue];
//                                          double lat2=[lat doubleValue];
//                                          
//                                          CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:self.userLat longitude:self.userLon];
//                                          
//                                          //NSLog(@"Current%@",currentLoc);
//                                          CLLocation *restaurnatLoc = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2];
//                                          CLLocationDistance dist = [restaurnatLoc distanceFromLocation:currentLoc]*0.000621371;
//                                          // NSString*loc2=[NSString* in]
//                                          //
//                                          [self addToArray:newdata forrun:i withdistance:dist];
//                                              
//                                          
//                                      }
//                                  }];
//          
//
//           }
//        }
    
        
        

    
    
       //  [name addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"loo",@"name", nil]]     ;

    
    // NSLog(@"%@",newdata);
    
    //NSLog(@"%@",newdata);

   // _data=data2;
    
//    NSMutableArray* data2= [newdata mutableCopy];
//    
//    NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
//                                initWithKey:@"start_time" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)
//                                ];
//    NSArray *data3 = [NSArray arrayWithObject: sorter];
//    
//   
//    
//    
//    NSArray* data4= [data2 sortedArrayUsingDescriptors:data3];
//   // _data=data4;
//    
//    
//  
//
//    NSLog(@"%@",data4);
    

        if (self.tableView.window) [self.tableView reloadData];

}

//
//-(void)addToArray:(NSMutableArray*) newdata
//            forrun:(int) i
//withdistance: (double)dist
//
//{
//    NSNumber *dist2 = [NSNumber numberWithDouble:dist];
//    //NSString *dist2 = [NSString stringWithFormat:@"%lf", dist];
//    
//   // NSLog(@"%@",self.data);
////    
////    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:[[self.data objectAtIndex:i]objectForKey:@"name"],@"name",
////                             [[self.data objectAtIndex:i]objectForKey:@"start_time"],@"start_time",
////                             [[self.data objectAtIndex:i]objectForKey:@"location"],@"location",
////                             [[self.data objectAtIndex:i]objectForKey:@"pic_square"],@"pic_square",
////                             dist2,@"distance",
////                             nil];
////    
////    NSLog(@"%@",dic);
//
//    [newdata addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[self.data objectAtIndex:i]objectForKey:@"name"],@"name",
//                        [[self.data objectAtIndex:i]objectForKey:@"start_time"],@"start_time",
//                        [[self.data objectAtIndex:i]objectForKey:@"location"],@"location",
//                        [[self.data objectAtIndex:i]objectForKey:@"pic_square"],@"pic_square",
//                        dist2,@"distance",
//                        nil]];
//    
//    NSLog(@"%@",newdata);
//    self.data6=newdata;
//    self.data=newdata;
//    
//}

-(void)viewWillAppear
{

    
}
-(void)viewDidLoad
{
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whitelinen.png"]];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.center = CGPointMake(160, 100);
    
    self.spinner.hidesWhenStopped = YES;
    
    [self.view addSubview:self.spinner];
    
    [self.spinner startAnimating];

   
    
    
   // UIActivityIndicatorView *activity
   
    //NSLog(@"Hello");
    //[activity performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    //self.spinner=activity;
    
    //[activity performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];


    //activity.hidesWhenStopped = YES;
    
    
    
  
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    // We don't want to be notified of small changes in location,
//    // preferring to use our last cached results, if any.
//    self.locationManager.distanceFilter = 50;
//    [self.locationManager startUpdatingLocation];
    //NSLog(@"%@",self.data);
    

}


//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    if (!oldLocation ||
//        (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
//         oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
//            
//            // To-do, add code for triggering view controller update
//            NSLog(@"Got location: %f, %f",
//                 newLocation.coordinate.latitude,
//                  newLocation.coordinate.longitude);
//            self.userLat=newLocation.coordinate.latitude;
//            self.userLon=newLocation.coordinate.longitude;
//             // NSLog(@"%@",self.data);
//        }
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error {
//    NSLog(@"Error in location %@", error);
//}

//-(void)dealloc
//{
//    _locationManager.delegate = nil;
//
//}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Simple Table Cell";
    
    FBEEventCell *cell = (FBEEventCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //[cell setBackgroundColor:[UIColor blueColor];;
   
    
    
    if (cell == nil)
    {
        
        NSLog(@"Cell is nil");
        cell = [[FBEEventCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"Simple Table Cell"];
    }
    
    NSURL *url = [NSURL URLWithString:[[self.data objectAtIndex:indexPath.row]
                                                                    objectForKey:@"pic_big"]];
    
    //dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("event image download", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.eventImage.image = [UIImage imageWithData:imageData];
        });
    });
   // dispatch_release(downloadQueue);
    
    
//        UIImage *image = [UIImage imageWithData:
//                          [NSData dataWithContentsOfURL:
//                           [NSURL URLWithString:
//                            [[self.data objectAtIndex:indexPath.row]
//                             objectForKey:@"pic_big"]]]];
    
    //cell.eventImage.image = image;
    
 
    
        cell.eventTitle.text = [[self.data objectAtIndex:indexPath.row]
                              objectForKey:@"name"];
//    
//    NSNumber* distance=[[self.data6 objectAtIndex:indexPath.row]
//                        objectForKey:@"distance"];
//    NSString *distance2 = [distance stringValue];
//
//
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    
    NSDate *date = [df dateFromString:[[self.data objectAtIndex:indexPath.row]
                                        objectForKey:@"start_time" ]];

    
    //NSLog(@"date1: %@", date);
   
    [df setDateFormat:@"MMM d  h:mm a"];
   
    NSString *dateStr = [df stringFromDate:date];

    //NSLog(@"date: %@", dateStr);
  
    cell.eventTime.text =  dateStr;
    
   // NSLog(@"Location: %@", [[self.data objectAtIndex:indexPath.row]
   //                         objectForKey:@"location" ]);
    
    if ([[self.data objectAtIndex:indexPath.row]
          objectForKey:@"location" ]==[NSNull null])
    {
        cell.eventLocation.text =@" ";
        //NSLog(@"Loc is %@",@"Hello");

    }
        else
    {

     
        //NSLog(@"Loc is %@",@"Not Hello");
        cell.eventLocation.text =  [[self.data objectAtIndex:indexPath.row]
                                    objectForKey:@"location" ];
    }

                                     // cell.distance.text =dist2;
                          

        
        
        
    
   // NSLog(@"%@",loc);
    
//    if(![loc objectForKey])
//    {
//        $latitude=null;
//    }
//    if ([self data ]  == nil)    {
//        NSLog(@"count is 0");
//        NSLog(@"Count:%u",[self.data count]);
        //NSLog(@"data:%@",self.data);
        //[self.spinner stopAnimating];
        //cell.eventTitle.text=@"No Events Found";
        //[self.spinner stopAnimating];
   //}
    

        [self.spinner stopAnimating];
    //self.spinner.hidden=YES;
    
    return cell;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Show Event Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleSubtitle
//                reuseIdentifier:CellIdentifier];
//    }
//    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row]
//                           objectForKey:@"name"];
//    //cell.detailTextLabel.text=@"saket";
//    
//    cell.detailTextLabel.text=[[self.data objectAtIndex:indexPath.row]
//                               objectForKey:@"location"];
//    
//    //cell.textLabel.text = @"saket";
//    UIImage *image = [UIImage imageWithData:
//                      [NSData dataWithContentsOfURL:
//                       [NSURL URLWithString:
//                        [[self.data objectAtIndex:indexPath.row]
//                         objectForKey:@"pic_square"]]]];
//    self.locationIcon.image = image;
//    
//
//    
////    FBEEventDetailViewController * eventDetail = (FBEEventDetailViewController *) segue.destinationViewController;
//   
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    
//     FBEEventDetailViewController *detailViewController = [[FBEEventDetailViewController alloc] initWithNibName:@"Show Event Detail" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     
//}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        if ([[segue identifier] isEqualToString:@"Show Event Detail"])
        {
            FBEEventDetailViewController *detailViewController =
            [segue destinationViewController];
            
            NSIndexPath *myIndexPath = [self.tableView
                                        indexPathForSelectedRow];
            
           // NSLog(@"Hello");
            
//            int row = [myIndexPath row];
//            
            detailViewController.eventHeader =
            [[self.data objectAtIndex:myIndexPath.row]
             objectForKey:@"name"];
            detailViewController.eventDescription =
            [[self.data objectAtIndex:myIndexPath.row]
             objectForKey:@"description"];
            
            detailViewController.imageURL =
            [[self.data objectAtIndex:myIndexPath.row]
             objectForKey:@"pic_big"];
            
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            
            [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
            
            NSDate *date = [df dateFromString:[[self.data objectAtIndex:myIndexPath.row]
                                               objectForKey:@"start_time" ]];
            
            
           // NSLog(@"date1: %@", date);
            
            [df setDateFormat:@"MMM d  h:mm a"];
            
            NSString *dateStr = [df stringFromDate:date];
            
           // NSLog(@"date for detailview is: %@", dateStr);
            
            if ([[self.data objectAtIndex:myIndexPath.row]
                 objectForKey:@"location"]==[NSNull null])
            {
                detailViewController.eventLocation =
              @" ";
                
            }
            else
            {
                detailViewController.eventLocation =
                [[self.data objectAtIndex:myIndexPath.row]
                 objectForKey:@"location"];
                
               
            }
            
            
            
            if ([[self.data objectAtIndex:myIndexPath.row]
                 objectForKey:@"location"]==nil)
            {
               // NSLog(@"Loc is %@",@"Not Hello");
                detailViewController.eventLocation =
                [[self.data objectAtIndex:myIndexPath.row]
                 objectForKey:@"location"];
                
            }
            else
            {
                
                detailViewController.eventLocation =@" ";
            }

            
            detailViewController.eventTime =dateStr;
//            if ( [[self.data objectAtIndex:myIndexPath.row]
//                  objectForKey:@"location"])
//            {
//            
//            detailViewController.eventLocation =
//            [[self.data objectAtIndex:myIndexPath.row]
//             objectForKey:@"location"];
//            }
            
           // NSLog(@"Uid: %@",[[self.data objectAtIndex:myIndexPath.row]
           //                   objectForKey:@"eid"]);
            detailViewController.eventID =
            [[self.data objectAtIndex:myIndexPath.row]
             objectForKey:@"eid"];
        }
    }


@end
