//
//  ETDateFormatter.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 19:48.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETDateFormatter : NSObject

+ (ETDateFormatter *)sharedFormatter;

- (NSString *)stringWithDateFormat:(NSString *)dateFormat fromDate:(NSDate *)date;

- (NSDate *)dateFromStringFormat:(NSString *)stringFormat fromString:(NSString *)string;

@end
