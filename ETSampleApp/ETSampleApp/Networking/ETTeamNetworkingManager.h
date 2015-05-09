//
//  ETTeamNetworkingManager.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 22:29.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETNetworkingManager.h"

@class ETTeam;

typedef void(^ETTeamDetailRequestCompletion)(NSError *error, ETTeam *team);

@interface ETTeamNetworkingManager : ETNetworkingManager

- (void)getTeamDetailsForTeamWithId:(NSString *)matchId completion:(ETTeamDetailRequestCompletion)completion;

@end
