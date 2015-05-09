//
//  ETMatch.h
//  ETSampleApp
//
//  Created by Emel Topaloglu on 09/05/2015 16:24.
//  Copyright (c) 2015 Emel Topaloglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETMatch : NSObject

@property (assign, nonatomic, readonly) NSInteger homeTeamScore;
@property (assign, nonatomic, readonly) NSInteger awayTeamScore;
@property (assign, nonatomic, readonly) NSInteger homeTeamPenalties;
@property (assign, nonatomic, readonly) NSInteger awayTeamPenalties;
@property (strong, nonatomic, readonly) NSDate *startDate;
@property (copy, nonatomic, readonly) NSString *homeTeamId;
@property (copy, nonatomic, readonly) NSString *awayTeamId;
@property (copy, nonatomic, readonly) NSString *venue;
@property (copy, nonatomic, readonly) NSString *group;
@property (copy, nonatomic, readonly) NSString *matchId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
