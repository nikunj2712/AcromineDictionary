//
//  WebServiceManager.m
//  Acronyms
//
//  Created by Nikunj on 07/03/16.
//  Copyright © 2016 Nikunj Bhagat. All rights reserved.
//

#import "WebServiceManager.h"
#import "AFNetworking/AFNetworking.h"

@implementation WebServiceManager

+(WebServiceManager *)sharedWebServiceManager{
    static dispatch_once_t oncePred=0;
    static WebServiceManager *_sharedObj = nil;
    dispatch_once(&oncePred, ^{
        _sharedObj = [[WebServiceManager alloc]init];
    });
    return _sharedObj;
}

+(void)fetchFullFormForAcronym:(NSString *)strAcronym withResponse:(void(^)(NSArray *arrayData))responseArray{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *strFullURL = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",strAcronym];
    
    NSURL *URL = [NSURL URLWithString:strFullURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
           NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];

            NSArray *arrayFullForms = [[dataJSON valueForKey:@"lfs"] firstObject];
            
            NSLog(@"arrayFullForms = %@",[arrayFullForms description]);
            
            NSMutableArray *arrayJustMeanings  = [[NSMutableArray alloc]init];
           
            for (NSDictionary *currentFullForm in arrayFullForms) {
                [arrayJustMeanings addObject:[currentFullForm valueForKey:@"lf"]];
            }
            
            if (arrayJustMeanings.count>0) {
                responseArray(arrayJustMeanings);
            }
            else{
                responseArray(arrayJustMeanings);
            }
        }
    }];
    [dataTask resume];
}

@end
