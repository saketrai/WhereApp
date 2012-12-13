//
//  FBEFriendViewController.m
//  FBEvents
//
//  Created by Saket Rai on 11/13/12.
//  Copyright (c) 2012 Saket Rai. All rights reserved.
//

#import "FBEFriendViewController.h"

@interface FBEFriendViewController ()

@end

@implementation FBEFriendViewController

@synthesize data = _data;

- (void)setData:(NSArray *)data
{
    if (_data != data) {
        _data = data;
        // Model changed, so update our View (the table)
        if (self.tableView.window) [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 4;
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Show Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    // Configure the cell...

      //  NSLog(@"Result: %@", @"Hello");
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row]
                           objectForKey:@"name"];
    
    //cell.textLabel.text = @"saket";
    UIImage *image = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:
                       [NSURL URLWithString:
                        [[self.data objectAtIndex:indexPath.row]
                         objectForKey:@"pic_square"]]]];
    cell.imageView.image = image;
    
    return cell;
}


@end
