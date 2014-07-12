//
//  SevenSegments.m
//  HttpRequest
//
//  Created by Chipso on 30/06/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import "SevenSegments.h"

@implementation SevenSegments

- (id)initWithToken:(NSString *)token customerString:(NSString *)customer projectId:(NSString*)projectId
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

- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer projectId:(NSString*)projectId
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

- (void)track:(NSString *)event properties:(NSDictionary *)properties
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
		 [self completitionHandler:operation];
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
		 [self completitionHandler:operation];
     }
				errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
	 {
		 [self errorHandler:error];
	 }];
	
    [_engine enqueueOperation:op];
	
	
}

- (void)evaluate:(NSDictionary *)campaings properties:(NSDictionary *)properties
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
		 [self completitionHandler:operation];
     }
	errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
	 {
		 [self errorHandler:error];
	 }];
	
    [_engine enqueueOperation:op];
}

- (void)completitionHandler:(MKNetworkOperation*)operation
{
	NSLog(@"%@", [operation responseJSON]);
}

- (void)errorHandler:(NSError*)error
{
	NSLog(@"%@", error);
}


@end

