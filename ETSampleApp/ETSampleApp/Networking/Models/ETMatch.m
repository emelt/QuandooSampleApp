//
//  ETMatch.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:24.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "NSDictionary+ETAdditions.h"
#import "ETDateFormatter.h"
#import "ETMatch.h"

static NSString * const kHomeScoreKey = @"homeScore";
static NSString * const kAwayScoreKey = @"awayScore";
static NSString * const kHomePenaltiesKey = @"homePenalties";
static NSString * const kAwayPenaltiesKey = @"awayPenalties";
static NSString * const kStartTimeKey = @"startTime";
static NSString * const kVenueKey = @"venue";
static NSString * const kGroupKey = @"group";
static NSString * const kMatchIdKey = @"id";
static NSString * const kHomeIdKey = @"homeTeamId";
static NSString * const kAwayIdKey = @"awayTeamId";

@implementation ETMatch

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _homeTeamScore = [dictionary integerForKey:kHomeScoreKey];
        _awayTeamScore = [dictionary integerForKey:kAwayScoreKey];
        _homeTeamPenalties = [dictionary integerForKey:kHomePenaltiesKey];
        _awayTeamPenalties = [dictionary integerForKey:kAwayPenaltiesKey];
        NSString *dateString = [dictionary objectForKey:kStartTimeKey];
        _startDate = [[ETDateFormatter sharedFormatter] dateFromStringFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" fromString:dateString] ;
        _venue = [dictionary stringForKey:kVenueKey];
        _group = [dictionary stringForKey:kGroupKey];
        _matchId = [dictionary stringForKey:kMatchIdKey];
        _homeTeamId = [dictionary stringForKey:kHomeIdKey];
        _awayTeamId = [dictionary stringForKey:kAwayIdKey];
    }
    
    return self;
}

@end
