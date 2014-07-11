//
//  SevenSegments.m
//  HttpRequest
//
//  Created by Chipso on 30/06/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import "SevenSegments.h"

@implementation SevenSegments

- (id)initWithToken:(NSString *)token customerString:(NSString *)customer :(NSString*)projectId
{
	self = [super init];
	if (self)
	{
		self.token = token;
		self.customer = @{@"registered":customer};
		self.projectId = projectId == nil ? @"" : projectId;
		
		_engine = [[MKNetworkEngine alloc] initWithHostName:target];
	}
	return self;
}

- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer :(NSString*)projectId
{
	self = [super init];
	if (self)
	{
		self.token = token;
		self.customer = customer == nil ? @{} : customer;
		self.projectId = projectId == nil ? @"" : projectId;
		_engine = [[MKNetworkEngine alloc] initWithHostName:target];

	}
	return self;
}

- (void)track:(NSString *)event :(NSDictionary *)properties
{
	NSDictionary *finalJSON = @{@"company_id": self.token, // Authorization Token
								@"type":event, // Event name
								@"customer_ids": self.customer, // Customer ids specified in initialize
								@"project_id": self.projectId, // project id if defined, otherwise null
								@"properties":properties == nil ? @{} : properties}; // properties
	
 	MKNetworkOperation *op = [_engine operationWithPath:@"/crm/events" params:finalJSON httpMethod:@"POST"];
	op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
	[op setFreezable:TRUE];
	[op addCompletionHandler:
     ^(MKNetworkOperation *operation)
     {
		 [self completitionHandler:[operation responseJSON]];
     }
	 errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
	 {
		 [self errorHandler:error];
	 }];
	
    [_engine enqueueOperation:op];
}

- (void)update:(NSDictionary *)properties
{
	NSDictionary *finalJSON = @{@"ids": self.customer,
								@"company_id": self.token, // Token
								@"properties":properties == nil ? @{} : properties}; // This is not gonna happend but for sure.
	
 	MKNetworkOperation *op = [_engine operationWithPath:@"/crm/customers" params:finalJSON httpMethod:@"POST"];
	op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
	[op setFreezable:TRUE];
	[op addCompletionHandler:
     ^(MKNetworkOperation *operation)
     {
		 [self completitionHandler:[operation responseJSON]];
     }
				errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
	 {
		 [self errorHandler:error];
	 }];
	
    [_engine enqueueOperation:op];
	
	
}

- (void)evaluate:(NSDictionary *)campaings :(NSDictionary *)properties
{
	NSDictionary *finalJSON = @{@"company_id": self.token,
								@"ids": self.customer,
								@"campaigns":campaings,
								@"properties":properties};
	
	MKNetworkOperation *op = [_engine operationWithPath:@"/campaigns/automated/evaluate" params:finalJSON httpMethod:@"POST"];
	op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
	[op setFreezable:TRUE];
	[op addCompletionHandler:
     ^(MKNetworkOperation *operation)
     {
		 [self completitionHandler:[operation responseJSON]];
     }
	errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
	 {
		 [self errorHandler:error];
	 }];
	
    [_engine enqueueOperation:op];
}

- (NSString*)url:(NSString *)path
{
	return [NSString stringWithFormat:@"%@%@", target, path];
}


- (void)completitionHandler:(MKNetworkOperation*)operation
{
	
}

- (void)errorHandler:(NSError*)error
{
	
}

- (void)MakeAsynchronousHTTPRequestWithResponse:(NSString *)url :(NSDictionary *)data completitionHandler:(void (^)(NSDictionary *result))completionHandler
{
	NSURL *connectionUrl = [NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:connectionUrl
														   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	NSError *error;
	NSData *requestData = [NSJSONSerialization dataWithJSONObject:data
														  options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
															error:&error];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: requestData];
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
		completionHandler(jsonArray);
	}];
}

- (NSDictionary*)MakeHTTPRequestWithResponse:(NSString *)url :(NSDictionary *)data
{
	
	NSURL *connectionUrl = [NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:connectionUrl
														   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	NSError *error;
	NSData *requestData = [NSJSONSerialization dataWithJSONObject:data
														  options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
															error:&error];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: requestData];
	NSURLResponse *urlResponse = nil;
	NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
	NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:response1 options:kNilOptions error:&error];
	
	return jsonArray;
}

- (BOOL)hasInternetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end

