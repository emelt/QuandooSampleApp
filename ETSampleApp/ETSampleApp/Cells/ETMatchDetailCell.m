//
//  ETMatchDetailCell.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:27.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETMatchDetailCell.h"
#import "ETDateFormatter.h"
#import "ETMatch.h"

static const CGFloat kETEstimatedRowHeight = 150.0f;

@interface ETMatchDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

@end

@implementation ETMatchDetailCell

- (void)updateWithMatch:(ETMatch *)match
{
    NSDictionary *defaultAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:16]};
    
    NSMutableAttributedString *scoreString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld:%ld", (long)match.homeTeamScore, (long)match.awayTeamScore] attributes:defaultAttributes];
    
    if (match.homeTeamPenalties || match.awayTeamPenalties)
    {
        NSDictionary *italicAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Italic" size:16], NSForegroundColorAttributeName : [UIColor colorWithWhite:0.0f alpha:0.8f]};
        
        [scoreString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%ld:%ld)", (long)match.homeTeamScore, (long)match.awayTeamScore] attributes:italicAttributes]];
    }
    
    self.scoreLabel.attributedText = scoreString;
    self.startDateLabel.text = [[ETDateFormatter sharedFormatter] stringWithDateFormat:@"dd-MM-YYYY hh:mm" fromDate:match.startDate];
    self.venueLabel.text = match.venue;
    
    if (match.group)
    {
        self.groupLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Group: %@", nil), match.group];
    }
    else
    {
        self.groupLabel.text = NSLocalizedString(@"Group: N/A", nil);
    }
}

+ (CGFloat)estimatedRowHeight
{
    return kETEstimatedRowHeight;
}

@end
