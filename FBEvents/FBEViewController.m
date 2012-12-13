//
//  FBEViewController.m
//  FBEvents
//
//  Created by Saket Rai on 11/10/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import "FBEViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBEFriendViewController.h"
#import "FBELoggedinViewController.h"


@interface FBEViewController ()  
//@property (nonatomic,strong) FBSession * session;


@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;


@end


@implementation FBEViewController

@synthesize userNameLabel= userNameLabel;
@synthesize state2=_state2;

/*
 * Callback for session changes.
 */



/*
 * Opens a Facebook session and optionally shows the login UX.
 */
-(void) viewDidLoad
{
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whitelinen.png"]];

}
    - (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_events",
                                @"friends_events",
                                nil];
        return [FBSession openActiveSessionWithReadPermissions:permissions
                                                  allowLoginUI:allowLoginUI
                                             completionHandler:^(FBSession *session,
                                                                 FBSessionState state,
                                                                 NSError *error) {
                                                 
                                                 [self sessionStateChanged:session
                                                                     state:state
                                                                     error:error];
                                             }];
        NSLog(@"session info2 %@",FBSession.activeSession.description);


    }
- (void)sessionStateChanged:(FBSession *)session
state:(FBSessionState) state
error:(NSError *)error
    {
      // NSLog(@"session info2 %s","Hello");
    //NSLog(@"session info2 %@",FBSession.activeSession.description);
        
        switch (state) {
            case FBSessionStateOpen:
                if (!error) {
                    // We have a valid session
                    //NSLog(@"User session found");
                   // NSLog(@"session info2 %@",FBSession.activeSession.accessToken);
                    
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                              initWithTitle:@"Logout"
                                                              style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(logoutButtonWasPressed:)];
                    [self populateUserDetails];
                   
 
                }
                break;
            case FBSessionStateClosed:
            case FBSessionStateClosedLoginFailed:{
                // NSLog(@"User login failed");
                
              [FBSession.activeSession closeAndClearTokenInformation];
               // [self openSessionWithAllowLoginUI:YES];
            
            }
                break;
            default:
                break;
        }
        
            }

- (IBAction)LoginPressed:(id)sender

{
    
        [self openSessionWithAllowLoginUI:YES];
     //NSLog(@"session info2 %s","Hello");

    //self.sessionstatus.text=@"Hello SAket";
    //BOOL  appID = self.session.isOpen;
    //FBSessionState state= self.session.state;
    //self.sessionstatus.text=[FBSession* state];
   // NSLog(@"session info %c",appID);
    //NSLog(@"session info %@",state);
 
    
}
    
-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

   
- (void)populateUserDetails
{
    [FBProfilePictureView class];

    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = user.id;
                // NSLog(@" %@",user.id);
                 self.state2=@"OPEN";
                 [self.delegate loginViewController:self ];
                // [[self.delegate presentedViewController] dismissViewControllerAnimated:YES];
             }
         }];
    }
}



@end
