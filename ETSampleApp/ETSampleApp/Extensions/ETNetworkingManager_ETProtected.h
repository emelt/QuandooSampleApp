//
//  ETNetworkingManager_ETProtected.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 18:02.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "AFURLResponseSerialization.h"
#import "AFURLRequestSerialization.h"
#import "ETNetworkingManager.h"

@interface ETNetworkingManager ()

@property (strong, nonatomic) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;
@property (strong, nonatomic) AFJSONResponseSerializer <AFURLResponseSerialization> *responseSerializer;

@end
