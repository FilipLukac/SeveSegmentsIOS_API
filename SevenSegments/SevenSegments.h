//
//  SevenSegments.h
//  HttpRequest
//
//  Created by Chipso on 30/06/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import <Foundation/Foundation.h>


#define target @"http://api.7segments.com" // Default target for our API

@interface SevenSegments : NSObject
{
}

/*
	initWithToken - initialize an instance with customer string
	@params:
		NSString* token - Authorization token. Cannot be nil
		NSString* customer - Customer String ( id )
		NSString* projectId - Project ID
	@return:
		id - an instance of @class SevenSegments ( object )
 */

- (id) initWithToken:(NSString*)token customerString:(NSString *)customer :(NSString*)projectId;

/*
	(id) initWithToken - initialize an instance with customer's array ( Dictionary of properties )
	@params:
		NSString* token - Authorization token. Cannot be nil
		NSString* customer - Customer String ( id )
		NSString* projectId - Project ID	@return:
		id - an instance of @class SevenSegments ( object )
	
 */

- (id) initWithToken:(NSString*)token customerDict:(NSDictionary*)customer :(NSString*)projectId;

/*
	track - Track events
	@params:
		NSString* event - Type or name of tracking event, cannot be nil
		NSDictionary* properties - Event properties
 */

- (void) track:(NSString*)event :(NSDictionary*)properties;

/*
	update - Update customer's properties
	@params:
		NSDictionary* properties - Customer's properties, cannot be nil
 
 */

- (void) update:(NSDictionary*)properties;


- (void) evaluate:(NSDictionary*)campaing :(NSDictionary*)properties;


// Helpers
/*
	url - Combine target with path
	@params:
		NSString* path - path to our api for example /crm/events
	@return:
		NSString - String contains target with path
 */

- (NSString*)url :(NSString*)path;

/*
 
	MakeHTTPRequestWithResponse - Make synchronous request to url with json body
	@params:
		NSString *url - String representing url 
		NSDictionary* data - Dictionary contains json data
	@return:
		NSDictionary - Returning array with response
 */

- (NSDictionary*)MakeHTTPRequestWithResponse: (NSString*)url :(NSDictionary*)data;

/*
	MakeAsynchronousHTTPRequestWithResponse - Make non-blocking (asyncrhonous) request to url with json body
	@params:
		NSString *url - String representing url
		NSDictionary* data - Dictionary contains json data
	@callback:
		NSDictionary *result - response is passing to callback
 */

- (void)MakeAsynchronousHTTPRequestWithResponse:(NSString *)url :(NSDictionary *)data completitionHandler:(void (^)(NSDictionary *result))completionHandler;

@property(strong, nonatomic, readwrite) NSString* token; // holding token
@property(strong, nonatomic, readwrite) NSDictionary* customer; // holding customer
@property(strong, nonatomic, readwrite) NSString* projectId; // holding projectId
@end
