//
//  ETTeam.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 22:20.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "NSDictionary+ETAdditions.h"
#import "ETTeam.h"

static NSString * const kNameKey = @"name";
static NSString * const kTeamIdKey = @"id";
static NSString * const kLogoKey = @"logo";
static NSString * const kWebsiteKey = @"website";

@implementation ETTeam

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _teamName = [dictionary stringForKey:kNameKey];
        _teamIdentifier = [dictionary stringForKey:kTeamIdKey];
        _logoUrl = [dictionary stringForKey:kLogoKey];
        _websiteUrl = [dictionary stringForKey:kWebsiteKey];
    }
    
    return self;
}

@end
