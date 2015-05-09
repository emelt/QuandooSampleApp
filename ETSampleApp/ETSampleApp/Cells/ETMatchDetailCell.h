//
//  ETMatchDetailCell.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:27.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETMatch;

@interface ETMatchDetailCell : UITableViewCell

- (void)updateWithMatch:(ETMatch *)match;

@end
