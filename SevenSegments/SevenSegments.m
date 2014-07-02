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
	target = @"http://api.7segments.com";
	
	self = [super init];
	if (self)
	{
		self.token = token;
		self.customer = @{@"registered":customer};
		self.projectId = projectId == nil ? @"" : projectId;
	}
	return self;
}

- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer :(NSString*)projectId
{
	target = @"http://api.7segments.com";
	
	self = [super init];
	if (self)
	{
		self.token = token;
		self.customer = customer == nil ? @{} : customer;
		self.projectId = projectId == nil ? @"" : projectId;
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
	
	[self MakeAsynchronousHTTPRequestWithResponse:[self url:@"/crm/events"] :finalJSON completitionHandler:^(NSDictionary *result){
		NSLog(@"%@", result);
	}];
}

- (void)update:(NSDictionary *)properties
{
	NSDictionary *finalJSON = @{@"ids": self.customer,
								@"company_id": self.token, // Token
								@"properties":properties == nil ? @{} : properties}; // This is not gonna happend but for sure.
	
	[self MakeAsynchronousHTTPRequestWithResponse:[self url:@"/crm/customers"] :finalJSON completitionHandler:^(NSDictionary *result){
		NSLog(@"%@", result);
	}];
	
	// Do something with json
}

- (void)evaluate:(NSDictionary *)campaings :(NSDictionary *)properties
{
	NSDictionary *finalJSON = @{@"company_id": self.token,
								@"ids": self.customer,
								@"campaigns":campaings,
								@"properties":properties};
	
	[self MakeAsynchronousHTTPRequestWithResponse:[self url:@"/campaigns/automated/evaluate"] :finalJSON completitionHandler:^(NSDictionary *result){
		NSLog(@"%@", result);
	}];
}

- (NSString*)url:(NSString *)path
{
	return [NSString stringWithFormat:@"%@%@", target, path];
}


- (void)setAuthorized:(BOOL)authorized
{
	self.tokenAuthorized = authorized;
}

- (BOOL)getAuthorized
{
	return self.tokenAuthorized;
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
@end

