//
//  ETMatchDetailsViewController.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:14.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETMatchDetailsViewController.h"
#import "ETTeamNetworkingManager.h"
#import "ETDateFormatter.h"
#import "ETMatch.h"
#import "ETTeam.h"

@interface ETMatchDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamImage;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamImage;
@property (weak, nonatomic) IBOutlet UIButton *homeTeamWebsiteButton;
@property (weak, nonatomic) IBOutlet UIButton *awayTeamWebsiteButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UILabel *penaltiesLabel;

@property (strong, nonatomic) ETTeam *homeTeam;
@property (strong, nonatomic) ETTeam *awayTeam;

@end

@implementation ETMatchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Match Details", nil);
    
    [self getTeamDetailsForTeamWithId:self.match.homeTeamId];
    [self getTeamDetailsForTeamWithId:self.match.awayTeamId];
    
    self.scoreLabel.text = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld:%ld", (long)self.match.homeTeamScore, (long)self.match.awayTeamScore]];
    self.venueLabel.text = self.match.venue;
    self.groupLabel.text = self.match.group ? [NSString stringWithFormat:NSLocalizedString(@"Group: %@", nil), self.match.group] : nil;
    self.startDateLabel.text = [[ETDateFormatter sharedFormatter] stringWithDateFormat:@"dd-MM-YYYY hh:mm" fromDate:self.match.startDate];
    
    if (self.match.awayTeamPenalties || self.match.homeTeamPenalties)
    {
        self.penaltiesLabel.text = [NSString stringWithFormat:@"(%ld:%ld)", (long)self.match.homeTeamPenalties, (long)self.match.awayTeamPenalties];
    }
    else
    {
        self.penaltiesLabel.text = @"";
    }
}

- (void)getTeamDetailsForTeamWithId:(NSString *)teamId
{
    __weak typeof(self) weakSelf = self;
    
    [[ETTeamNetworkingManager sharedInstance] getTeamDetailsForTeamWithId:teamId completion:^(NSError *error, ETTeam *team) {
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
            if ([team.teamIdentifier isEqualToString:weakSelf.match.homeTeamId])
            {
                weakSelf.homeTeamNameLabel.text = team.teamName;
                weakSelf.homeTeamImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:team.logoUrl]]];
                [weakSelf.homeTeamWebsiteButton setTitle:team.websiteUrl forState:UIControlStateNormal];
            }
            else if ([team.teamIdentifier isEqualToString:weakSelf.match.awayTeamId])
            {
                weakSelf.awayTeamNameLabel.text = team.teamName;
                weakSelf.awayTeamImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:team.logoUrl]]];
                [weakSelf.awayTeamWebsiteButton setTitle:team.websiteUrl forState:UIControlStateNormal];
            }
        }
    }];
}

- (IBAction)websiteButtonTapped:(id)sender
{
    UIButton *button = sender;
    NSURL *websiteUrl = [NSURL URLWithString:button.titleLabel.text];
    if ([[UIApplication sharedApplication] canOpenURL:websiteUrl])
    {
        [[UIApplication sharedApplication] openURL:websiteUrl];
    }
}

@end
