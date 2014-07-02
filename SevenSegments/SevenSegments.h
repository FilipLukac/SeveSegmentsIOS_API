//
//  SevenSegments.h
//  HttpRequest
//
//  Created by Chipso on 30/06/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SevenSegments : NSObject
{
	NSString *target;
	BOOL customerIsString;
}

/*
	initWithToken
	@params:
		NSString* token - authorization
		NSString* customer - customer string or id
		NSString* projectId - projectId
 */

- (id)initWithToken:(NSString*)token customerString:(NSString *)customer :(NSString*)projectId;
- (id)initWithToken:(NSString*)token customerDict:(NSDictionary*)customer :(NSString*)projectId;




// Trackers
- (void)track:(NSString*)event :(NSDictionary*)properties;
- (void)update:(NSDictionary*)properties;
- (void)evaluate:(NSDictionary*)campaing :(NSDictionary*)properties;


// Helpers
- (NSString*)url :(NSString*)path;
- (void) setAuthorized:(BOOL)authorized;
- (BOOL) getAuthorized;
- (NSDictionary*)MakeHTTPRequestWithResponse: (NSString*)url :(NSDictionary*)data;
- (void)MakeAsynchronousHTTPRequestWithResponse:(NSString *)url :(NSDictionary *)data completitionHandler:(void (^)(NSDictionary *result))completionHandler;

@property(strong, nonatomic, readwrite) NSString* token; // holding token
@property(strong, nonatomic, readwrite) NSDictionary* customer; // holding customer
@property(strong, nonatomic, readwrite) NSString* projectId; // holding customer
@property(assign, nonatomic, readwrite) BOOL tokenAuthorized;

@end
