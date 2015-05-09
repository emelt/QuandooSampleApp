//
//  ETNetworkingManager.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:56.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETNetworkingManager_ETProtected.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "ETNetworkingManager.h"

static NSString * const kETNetworkingErrorDomain = @"com.emel.networking.requestError";

typedef void(^AFRequestCompletionSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^AFRequestCompletionFail)(AFHTTPRequestOperation *operation, NSError *error);

@interface ETNetworkingManager ()

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) AFHTTPRequestOperationManager *networkingManager;
@end

@implementation ETNetworkingManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super init];
    
    if (self)
    {
        _baseURL = url;
        _networkingManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)addRequest:(NSURLRequest *)request
        completion:(ETRequestCompletion)completion
{
    if (!request)
    {
        if (completion)
        {
            completion([NSError errorWithDomain:kETNetworkingErrorDomain code:ETNetworkErrorInvalid userInfo:nil], nil);
        }
        return;
    }
    
    AFHTTPRequestOperation *op = [self.networkingManager HTTPRequestOperationWithRequest:request
                                                                                 success:[self afRequestCompletionSuccessBlockWithOperationCompletion:completion]
                                                                                 failure:[self afRequestCompletionFailBlockWithOperationCompletion:completion]];
    op.responseSerializer = self.responseSerializer;
    
    [self.networkingManager.operationQueue addOperation:op];
    
#ifdef DEBUG
        NSString *postData = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
        NSLog(@"\n--- Network \n Sending:\n %@ (%@) \n\nHeaders: %@\n\nData: %@\n\n", request.URL, request.HTTPMethod, [request allHTTPHeaderFields], postData);
#endif
    
    return;
}

- (AFRequestCompletionSuccess)afRequestCompletionSuccessBlockWithOperationCompletion:(ETRequestCompletion)operationCompletion
{
    AFRequestCompletionSuccess ret = ^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"\n--- Network success: %@ \n\nHeaders: %@\n\nData: %@\n\n", operation.request.URL, operation.response.allHeaderFields, responseObject);
#endif
        operationCompletion(operation.error , responseObject);
    };
    
    return ret;
}

- (AFRequestCompletionFail)afRequestCompletionFailBlockWithOperationCompletion:(ETRequestCompletion)operationCompletion
{
    AFRequestCompletionFail ret = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
#ifdef DEBUG
        NSLog(@"\n--- Network fail: %@ \n\nHeaders: %@\n\nError: %@\n\n", operation.request.URL, operation.response.allHeaderFields, error);
#endif
        
        operationCompletion(error, operation.responseObject);
    };
    
    return ret;
}

@end
