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
	SevenSegments *seven = [[SevenSegments alloc] initWithToken:@"7fa0a2c4-fead-11e3-b648-4061862b98a0" customerString:@"1234" :nil];
	
	[seven track:@"testingNovyEvent" :@{@"size":@"43"}];
	
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
