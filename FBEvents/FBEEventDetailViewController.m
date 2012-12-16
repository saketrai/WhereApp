//
//  FBEEventDetailViewController.m
//  FBEvents
//
//  Created by Saket Rai on 11/22/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import "FBEEventDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FBEEventDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventStartTime;
@property (strong, nonatomic) IBOutlet UIImageView *friend1;
@property (strong, nonatomic) IBOutlet UIImageView *friend2;
@property (strong, nonatomic) IBOutlet UITextView *eventDesc;


@property (strong, nonatomic) IBOutlet UILabel *eventLoc;

@end

@implementation FBEEventDetailViewController

@synthesize eventHeader =_eventHeader;
@synthesize eventTitle=_eventTitle;
@synthesize imageURL=_imageURL;
@synthesize eventTime=_eventTime;
@synthesize eventStartTime=_eventStartTime;

@synthesize friends=_friends;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whitelinen.png"]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:1.0]];

    
    #if !defined(MIN)
    #define MIN(A,B)((A) < (B) ? (A) : (B))
    #endif

    self.eventTitle.text=self.eventHeader;
    
    UIImage *image = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:
                       [NSURL URLWithString:self.imageURL]]];
    
    

    self.eventImage.image=image;
    self.eventStartTime.text=self.eventTime;
    self.eventDesc.text=self.eventDescription;
    
    //self.scrollview.contentSize = self.eventDesc.;
    self.eventLoc.text=self.eventLocation;
    NSString *query =
    @"{"
    @"'friends':'SELECT uid,eid FROM event_member WHERE   ";
    query = [query stringByAppendingFormat:@"  eid=%@ ",self.eventID ];
    
    query = [query stringByAppendingFormat:@" and uid in (select uid2 from friend where uid1=me()) limit 5',"];
    
    query = [query stringByAppendingFormat:@"'friendinfo':'SELECT uid,name, pic_big FROM user WHERE uid IN (SELECT uid FROM #friends)',}"];
    
//    NSString *query =
//    @"select uid, name, pic_square  from user where uid in (select uid from event_member where";
//    
//    query = [query stringByAppendingFormat:@" eid =%@",self.eventID];
//    query = [query stringByAppendingFormat:@")and uid in (select uid2 from friend where uid1=me())"];
    
    

 
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
                                
                                  NSArray *friendInfo = (NSArray *) [[[result objectForKey:@"data"] objectAtIndex:1] objectForKey:@"fql_result_set"];
                                  
                                   // NSLog(@"Result: %@", friendInfo);
//                                  self.friends=friendInfo;
//                                  if([[friendInfo objectAtIndex:0] objectForKey:@"pic_square"]){
//                                      UIImage *image = [UIImage imageWithData:
//                                                        [NSData dataWithContentsOfURL:
//                                                         [NSURL URLWithString:
//                                                          
//                                                          [[friendInfo objectAtIndex:0]
//                                                           objectForKey:@"pic_square"]]]];
//                                      self.friend1.image=image;
                              
                                  int count=(int)[friendInfo count];
                                  //NSLog(@"count: %i",count);
                                  int count2 =MIN(count,5);
                                  // NSLog(@"count: %i",count2);
                                //int count2=(5,count);
//                                NSMutableArray *images = [[NSMutableArray alloc] init];
//                                UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,70, 66)];
                               if (count2>0)
                               {
                               for (int i=0; i<=count2-1; ++i)
                               {
                                  //int i=0;
                                   UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0+(78*i)+8,240,57,57)];
                                   UILabel *friendsName=[[UILabel alloc]initWithFrame:CGRectMake(0+(78*i)+8,293,57, 20)];
                                   
                                   [friendsName setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
                                   [friendsName setTextColor:[UIColor whiteColor]];
                                   [friendsName setTextAlignment:NSTextAlignmentCenter];
                                   [friendsName setBackgroundColor:[UIColor clearColor]];

                                   
                                   UIImage *image = [UIImage imageWithData:
                                                     [NSData dataWithContentsOfURL:
                                                      [NSURL URLWithString:
                                                       
                                                       [[friendInfo objectAtIndex:i]
                                                        objectForKey:@"pic_big"]]]];
                                   animationView.image=image;
                                   friendsName.text=[[friendInfo objectAtIndex:i]
                               objectForKey:@"name"];
                                   [self.view addSubview:animationView];
                                   [self.view addSubview:friendsName];


                                   
                                   // ;

}

                                 // NSLog(@"%@",images);
                                 

                                  
                              }
                                  
                                  
                                  
                              }
                          }];
    
    
    NSString *query2 =
    @"{"
    @"'friends':'SELECT uid,eid FROM event_member WHERE   ";
    query2 = [query2 stringByAppendingFormat:@"  eid=%@ ",self.eventID ];
    
    query2 = [query2 stringByAppendingFormat:@"  limit 5',"];
    
    query2 = [query2 stringByAppendingFormat:@"'friendinfo':'SELECT uid,name, pic_big FROM user WHERE uid IN (SELECT uid FROM #friends)',}"];
   // NSLog(@"Result: %@", query2);
    // Set up the query parameter
    NSDictionary *queryParam2 =
    [NSDictionary dictionaryWithObjectsAndKeys:query2, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam2
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  
                                  NSArray *friendInfo = (NSArray *) [[[result objectForKey:@"data"] objectAtIndex:1] objectForKey:@"fql_result_set"];
                                  
                                 // NSLog(@"Result: %@", friendInfo);
                         
                                  
                                  int count=(int)[friendInfo count];
                                  //NSLog(@"count: %i",count);
                                  int count2 =MIN(count,5);
                                 // NSLog(@"count: %i",count2);
                                  //int count2=(5,count);
                                  //                                NSMutableArray *images = [[NSMutableArray alloc] init];
                                  //                                UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,70, 66)];
                                  
                                  //UIScrollView* scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(6,320,1000, 57)];
                                  
                                  
                               //[self.view addSubview:scrollview];
                                 
                                  if (count2>0)
                                  {
                                      for (int i=0; i<=count2-1; ++i)
                                      {
                                          //int i=0;
                                          UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0+(78*i)+8,340,57, 57)];
                                          UILabel *friendsName=[[UILabel alloc]initWithFrame:CGRectMake(0+(78*i)+8,393,57, 20)];
                                          
                                          [friendsName setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
                                          [friendsName setTextColor:[UIColor whiteColor]];
                                          [friendsName setTextAlignment:NSTextAlignmentCenter];
                                          [friendsName setBackgroundColor:[UIColor clearColor]];
                                          
                                          
                                          UIImage *image = [UIImage imageWithData:
                                                            [NSData dataWithContentsOfURL:
                                                             [NSURL URLWithString:
                                                              
                                                              [[friendInfo objectAtIndex:i]
                                                               objectForKey:@"pic_big"]]]];
                                          animationView.image=image;
                                          friendsName.text=[[friendInfo objectAtIndex:i]
                                                            objectForKey:@"name"];
                                          [self.view addSubview:animationView];
                                          [self.view addSubview:friendsName];

                                          
                                          
                                          
                                          // ;
                                          
                                      }
                                      //[self.view addSubview:scrollview];
                                      
                                      // NSLog(@"%@",images);
                                      
                                      
                                      
                                  }
                                  
                                  
                                  
                              }
                          }];
    
   // [self.showFriends  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Show Friends"];

    

}


@end
