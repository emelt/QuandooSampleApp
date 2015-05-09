//
//  ETMatchNetworkingManager.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 17:43.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETNetworkingManager.h"

@class ETMatch;

typedef void(^ETMatchListRequestCompletion)(NSError *error, NSArray *matches);
typedef void(^ETMatchDetailRequestCompletion)(NSError *error, ETMatch *match);

@interface ETMatchNetworkingManager : ETNetworkingManager

+ (instancetype)sharedInstance;

- (void)getMatchesStartingFromIndex:(NSInteger)startIndex completion:(ETMatchListRequestCompletion)completion;

- (void)getMatchDetailsForMatchWithId:(NSString *)matchId completion:(ETMatchDetailRequestCompletion)completion;

@end
