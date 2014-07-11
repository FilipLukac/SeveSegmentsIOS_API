//
//  ViewController.m
//  SevenSegments
//
//  Created by Chipso on 02/07/14.
//  Copyright (c) 2014 Chipso. All rights reserved.
//

#import "ViewController.h"
#import "SevenSegments.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Initialize with token and customer ID - passing string
	SevenSegments *sevenString = [[SevenSegments alloc] initWithToken:@"7fa0a2c4-fead-11e3-b648-4061862b98a0" customerString:@"3456" :nil];
	
	
	
	
	[sevenString update:@{@"first_name":@"Alexander", @"last_name":@"Pastornicky"}];
	
	// Initialize with token and customer dictionary - passing dictionary
	
	// SevenSegments *seventDict = [[SevenSegments alloc] initWithToken:@"7fa0a2c4-fead-11e3-b648-4061862b98a0" customerDict:@{@"registered": @"1234"} :@"123"];
	
	
	
	// Testing track
	//[sevenString track:@"testingNovyEvent" :@{@"size":@"43"}];
	//[seventDict track:@"nakup" :@{@"znacka": @"adidas", @"velkost": @"43"}];
	
	
	// Testing update user
	//[sevenString update:@{@"last_name":@"Janko", @"first_name":@"LUKACCC"}];
	//[seventDict update:@{@"last_name":@"Hrasko", @"first_name":@"Janko"}];

		
	// Testing evaluate
	//[sevenString evaluate:@{@"campaingName" :@"123"} :@{@"max_size": @"20000"}];
	//[seventDict evaluate:@{@"campaingName" :@"123"} :@{@"max_size": @"20000"}];

	
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
