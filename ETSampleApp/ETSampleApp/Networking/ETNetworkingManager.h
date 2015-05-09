//
//  ETNetworkingManager.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:56.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ETRequestCompletion)(NSError *error, id data);

typedef NS_ENUM(NSInteger, ETNetworkError)
{
    ETNetworkErrorUnknown =	-1,
    ETNetworkErrorCancelled = -100,
    ETNetworkErrorAPI = -200,
    ETNetworkErrorInvalid =	-300,
};

@interface ETNetworkingManager : NSObject

@property (strong, nonatomic, readonly) NSURL *baseURL;

- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)addRequest:(NSURLRequest *)request
        completion:(ETRequestCompletion)completion;

@end
