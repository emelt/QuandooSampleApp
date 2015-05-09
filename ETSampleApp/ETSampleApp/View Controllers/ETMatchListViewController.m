//
//  ETMatchListViewController.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:14.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETMatchDetailsViewController.h"
#import "ETMatchListViewController.h"
#import "ETMatchNetworkingManager.h"
#import "ETMatch.h"

static NSString * const kETShowMatchDetailsSegueIdentifier = @"showMatchDetails";
static NSString * const kETBaseURLString = @"showMatchDetails";

@interface ETMatchListViewController ()

@property (nonatomic, strong) NSMutableArray *matches;

@end

@implementation ETMatchListViewController

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
	
    self.title = NSLocalizedString(@"Available Matches", nil);
    
    [[ETMatchNetworkingManager sharedInstance] getMatchesStartingFromIndex:0 completion:^(NSError *error, NSArray *matches) {

    }];
}

#pragma mark - Setters & Getters


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kETShowMatchDetailsSegueIdentifier sender:self];
}

#pragma mark - UITableViewDataSource



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kETShowMatchDetailsSegueIdentifier])
    {
        NSInteger selectedIndex = [self.tableView indexPathForSelectedRow].row;
        ETMatch *selectedMatch = self.matches[selectedIndex];
        ETMatchDetailsViewController *detailViewController = segue.destinationViewController;
        detailViewController.match = selectedMatch;
    }
}

@end
