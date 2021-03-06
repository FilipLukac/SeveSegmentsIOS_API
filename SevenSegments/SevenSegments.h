//
//  SevenSegments.h
//  HttpRequest
//
//  Created by Chipso on 30/06/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "MKNetworkEngine.h"




#define target @"api.7segments.com" // Default target for our API

@interface SevenSegments : NSObject
{
	@private
		MKNetworkEngine *_engine;
}

/*
	initWithToken - initialize an instance with customer string
	@params:
		NSString* token - Authorization token. Cannot be nil
		NSString* customer - Customer String ( id ). Cannot be nil
		NSString* projectId - Project ID
	@return:
		id - an instance of @class SevenSegments ( object )
 */

- (id) initWithToken:(NSString*)token customerString:(NSString *)customer projectId:(NSString*)projectId;

/*
	(id) initWithToken - initialize an instance with customer's array ( Dictionary of properties )
	@params:
		NSString* token - Authorization token. Cannot be nil
		NSString* customer - Customer String ( id )
		NSString* projectId - Project ID	@return:
	@return
		id - an instance of @class SevenSegments ( object )
	
 */

- (id) initWithToken:(NSString*)token customerDict:(NSDictionary*)customer projectId:(NSString*)projectId;

/*
	track - Track events
	@params:
		NSString* event - Type or name of tracking event, cannot be nil
		NSDictionary* properties - Event properties
 */
- (void) track:(NSString*)event;
- (void) track:(NSString*)event properties:(NSDictionary*)properties;

/*
	update - Update customer's properties
	@params:
		NSDictionary* properties - Customer's properties, cannot be nil
 
 */

- (void) update:(NSDictionary*)properties;

- (void) evaluate:(NSDictionary*)campaing properties:(NSDictionary*)properties;


// Override those two methods for your purposes.

- (void)completitionHandler:(MKNetworkOperation*)operation;
- (void)errorHandler:(NSError*)error;

// Helpers
/*
	url - Combine target with path
	@params:
		NSString* path - path to our api for example /crm/events
	@return:
		NSString - String contains target with path
 */

/*
 
	MakeHTTPRequestWithResponse - Make synchronous request to url with json body
	@params:
		NSString *url - String representing url 
		NSDictionary* data - Dictionary contains json data
	@return:
		NSDictionary - Returning array with response
 */


/*
	MakeAsynchronousHTTPRequestWithResponse - Make non-blocking (asyncrhonous) request to url with json body
	@params:
		NSString *url - String representing url
		NSDictionary* data - Dictionary contains json data
	@callback:
		NSDictionary *result - response is passing to callback
 */


@property(strong, nonatomic, readwrite) NSString* token; // holding token
@property(strong, nonatomic, readwrite) NSDictionary* customer; // holding customer
@property(strong, nonatomic, readwrite) NSString* projectId; // holding projectId
@end
