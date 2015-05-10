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
#import "ETMatchDetailCell.h"
#import "ETLoadingCell.h"
#import "ETMatch.h"

static NSString * const kETShowMatchDetailsSegueIdentifier = @"showMatchDetails";
static NSString * const kETMatchCellIdentifier = @"matchCell";

@interface ETMatchListViewController ()

@property (nonatomic, strong) NSMutableArray *matches;
@property (nonatomic, strong) ETLoadingCell *loadingCell;

@end

@implementation ETMatchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Available Matches", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ETMatchDetailCell class]) bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:kETMatchCellIdentifier];

    self.tableView.estimatedRowHeight = [ETMatchDetailCell estimatedRowHeight];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Setters & Getters

- (NSMutableArray *)matches
{
    if (!_matches)
    {
        _matches = [NSMutableArray array];
    }
    return _matches;
}

- (ETLoadingCell *)loadingCell
{
    if (!_loadingCell)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ETLoadingCell class]) owner:self options:nil];
        _loadingCell = [topLevelObjects objectAtIndex:0];
    }
    
    return _loadingCell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kETShowMatchDetailsSegueIdentifier sender:self];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.matches.count)
    {
        return self.loadingCell;
    }
    else
    {
        ETMatchDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kETMatchCellIdentifier];
        
        if (self.matches.count > indexPath.row && cell)
        {
            ETMatch *match = self.matches[indexPath.row];
            [cell updateWithMatch:match];
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.matches.count + 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.matches.count && self.loadingCell.loading)
    {
        [self getMatchesStartingFromIndex:self.matches.count];
    }
}

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

#pragma mark - Helpers

- (void)getMatchesStartingFromIndex:(NSInteger)startIndex
{
    __weak typeof(self) weakSelf = self;
    [[ETMatchNetworkingManager sharedInstance] getMatchesStartingFromIndex:startIndex
                                                                completion:^(NSError *error, NSArray *matches)
     {
         if (error)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                             message:NSLocalizedString(@"An error occured, please try again later", nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                   otherButtonTitles:nil];
             [alert show];
         }
         else
         {
             if (matches.count == 0)
             {
                 self.loadingCell.loading = NO;
                 return;
             }
             
             [weakSelf.matches addObjectsFromArray:matches];
             NSArray *newIndexes = [weakSelf indexPathArrayStartingFromIndex:[NSIndexPath indexPathForRow:startIndex inSection:0]
                                                         numberOfIndexes:matches.count];
             [weakSelf.tableView insertRowsAtIndexPaths:newIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
         }
     }];
}

- (NSArray *)indexPathArrayStartingFromIndex:(NSIndexPath *)index numberOfIndexes:(NSInteger)numberOfIndexes
{
    NSMutableArray *newCellIndexes = [NSMutableArray array];
    
    for (NSUInteger idx = 0; idx < numberOfIndexes; idx++)
    {
        [newCellIndexes addObject:[NSIndexPath indexPathForRow:index.row+idx inSection:index.section]];
    }
    
    return newCellIndexes;
}

@end
