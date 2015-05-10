//
//  ETMatchNetworkingManager.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 17:43.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//


#import "ETNetworkingManager_ETProtected.h"
#import "ETMatchNetworkingManager.h"
#import "ETNetworkingCommons.h"
#import "ETMatch.h"

static NSString * const kETMatchString = @"matches";

static NSString * const kETLimitKey = @"limit";
static NSString * const kETOffsetKey = @"offset";
static NSString * const kETDefaultItemCountPerPage = @"20";

@implementation ETMatchNetworkingManager

+ (instancetype)sharedInstance
{
    static ETMatchNetworkingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:kETBaseNetworkingURLString];
        sharedInstance = [[ETMatchNetworkingManager alloc] initWithBaseURL:baseUrl];
    });
    
    return sharedInstance;
}

- (void)getMatchesStartingFromIndex:(NSInteger)startIndex completion:(ETMatchListRequestCompletion)completion
{
    NSDictionary *additionalParameters = @{kETLimitKey:kETDefaultItemCountPerPage,
                                           kETOffsetKey:[NSString stringWithFormat:@"%ld",(long)startIndex]};
    
    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:kETHTTPMethodGET
                                                                      URLString:[[NSURL URLWithString:kETMatchString relativeToURL:self.baseURL] absoluteString]
                                                                     parameters:additionalParameters
                                                                          error:nil];
    
    [self addRequest:urlRequest completion:^(NSError *error, id data)
     {
         if (completion)
         {
             NSMutableArray *newMatches = [NSMutableArray array];
             NSArray *matches = data;
             for (NSDictionary *matchDictionary in matches)
             {
                 ETMatch *match = [[ETMatch alloc] initWithDictionary:matchDictionary];
                 [newMatches addObject:match];
             }
             completion(error, newMatches);
         }
     }];
    
}

//Other match related methods go here...
//....

@end
