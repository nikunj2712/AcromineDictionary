//
//  WebServiceManager.h
//  Acronyms
//
//  Created by Nikunj on 07/03/16.
//  Copyright © 2016 Nikunj Bhagat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceManager : NSObject

+(WebServiceManager *)sharedWebServiceManager;


+(void)fetchFullFormForAcronym:(NSString *)strAcronym withResponse:(void(^)(NSArray *arrayData))responseArray;

@end
