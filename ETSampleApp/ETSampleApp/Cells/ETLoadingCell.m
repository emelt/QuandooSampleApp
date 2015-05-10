//
//  ETLoadingCell.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 10/05/2015 18:32.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETLoadingCell.h"

@interface ETLoadingCell ()

@property (weak, nonatomic) IBOutlet UILabel *endOfDataLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatior;

@end

@implementation ETLoadingCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.loading = YES;
    self.endOfDataLabel.text = NSLocalizedString(@"End Of Data", nil);
}

- (void)setLoading:(BOOL)loading
{
    if (_loading == loading)
    {
        return;
    }
    
    _loading = loading;
    self.activityIndicatior.hidden = !loading;
    self.endOfDataLabel.hidden = loading;
}

@end
