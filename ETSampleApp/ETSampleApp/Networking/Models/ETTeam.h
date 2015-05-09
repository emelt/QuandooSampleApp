//
//  ETTeam.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 22:20.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETTeam : NSObject

@property (copy, nonatomic, readonly) NSString *teamIdentifier;
@property (copy, nonatomic, readonly) NSString *teamName;
@property (copy, nonatomic, readonly) NSString *logoUrl;
@property (copy, nonatomic, readonly) NSString *websiteUrl;

@end
