//
//  ETTeamNetworkingManager.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 22:29.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETNetworkingManager_ETProtected.h"
#import "ETTeamNetworkingManager.h"
#import "ETNetworkingCommons.h"
#import "ETTeam.h"

static NSString * const kETTeamString = @"teams";

@implementation ETTeamNetworkingManager

+ (instancetype)sharedInstance
{
    static ETTeamNetworkingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:kETBaseNetworkingURLString];
        sharedInstance = [[ETTeamNetworkingManager alloc] initWithBaseURL:baseUrl];
    });
    
    return sharedInstance;
}

- (void)getTeamDetailsForTeamWithId:(NSString *)matchId completion:(ETTeamDetailRequestCompletion)completion
{
    NSString *relativeURL = [NSString stringWithFormat:@"%@/%@?%@=%@", kETTeamString, matchId, kETApiKey, kETApiKeyValue];
    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:kETHTTPMethodGET
                                                                      URLString:[[NSURL URLWithString:relativeURL relativeToURL:self.baseURL] absoluteString]
                                                                     parameters:nil
                                                                          error:nil];
    
    
    [self addRequest:urlRequest completion:^(NSError *error, id data)
     {
         if (completion)
         {
             ETTeam *team = nil;
             if (data)
             {
                 team = [[ETTeam alloc] initWithDictionary:data];
             }
             completion(error, team);
         }
     }];
}

//Other team related methods go here...
//....

@end
