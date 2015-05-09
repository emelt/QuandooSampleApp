//
//  ETDateFormatter.m
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 19:48.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import "ETDateFormatter.h"

@interface ETDateFormatter ()

@property (strong, nonatomic) NSDateFormatter *outputDateFormatter;

@end

@implementation ETDateFormatter

+ (ETDateFormatter *)sharedFormatter
{
    static ETDateFormatter *sharedFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[ETDateFormatter alloc] init];
    });
    
    return sharedFormatter;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _outputDateFormatter = [[NSDateFormatter alloc]init];
        
        // DateFormatter's default locale is device's language.
        _outputDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
    }
    
    return self;
}

#pragma mark - Public methods

- (NSString *)stringWithDateFormat:(NSString *)dateFormat fromDate:(NSDate *)date
{
    self.outputDateFormatter.dateFormat = dateFormat;
    return [self.outputDateFormatter stringFromDate:date];
}

- (NSDate *)dateFromStringFormat:(NSString *)stringFormat fromString:(NSString *)string
{
    self.outputDateFormatter.dateFormat = stringFormat;
    return [self.outputDateFormatter dateFromString:string];
}

@end
