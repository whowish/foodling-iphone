//
//  MainController.m
//  foodling
//
//  Created by Apirom Na Nakorn on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainController.h"


@implementation MainController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	CGRect frame = CGRectMake(0, 0, 320, 460); // Replacing with your dimensions
	self.view = [[UIView alloc] initWithFrame:frame];
	
	pageStack = [[NSMutableArray alloc] init];
	
	map = [[MapController alloc] initWithNibName:@"MapController" bundle:nil];
	dish = [[DishController alloc] initWithNibName:@"DishController" bundle:nil];
	list = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	
	[map setRoot:self];
	[dish setRoot:self];
	[list setRoot:self];
	
	NSLog(@"Loaded");
	[self bringUp:(UIViewController*)map andClearStack:NO];
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[pageStack release];
	[map release];
	[dish release];
	[list release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (void) toDish
{
	[self bringLeft:dish andClearStack:NO];
}


- (void) toList
{
	[self bringLeft:list andClearStack:NO];
}


- (void) bring:(UIViewController*) target fromX:(int) x fromY:(int) y toX:(int) toX toY:(int) toY andClearStack:(bool) clear
{
	
	NSLog(@"Bring %@ from %d,%d to %d,%d", target, x, y, toX, toY);
	target.view.frame = CGRectMake(x, y, 320, 460);
	
	[UIView setAnimationsEnabled:YES];
	[UIView beginAnimations:nil context:nil];
	
	UIViewController* previous = NULL;
	if ([pageStack count] > 0) previous = (UIViewController*)[pageStack lastObject];
	
	[UIView animateWithDuration:10.0
						  delay:0.0
						options:UIViewAnimationCurveEaseInOut
					 animations:^{
						 target.view.frame = CGRectMake(toX, toY, 320, 460);
					 }
					 completion:^(BOOL finished) {
						 
						 if (previous != NULL) {
							 [previous.view removeFromSuperview];
							 [previous viewDidDisappear:YES];
						 }
						 
						 [target viewDidAppear:YES];
						 
						 NSLog(@"Finish");
						 
					 }]; 
	
	
	
	[self.view addSubview:target.view];
	
	[target viewWillAppear:YES];
	if ([pageStack count] > 0) [((UIViewController*)[pageStack lastObject]) viewWillDisappear:YES];
	
	if (clear == YES) [pageStack removeAllObjects];
	
	[pageStack addObject:target];
}

- (void) bringUp:(UIViewController*) target andClearStack:(bool) clear
{
	[self bring:target fromX:0 fromY:460 toX:0 toY:0 andClearStack:clear];
}

- (void) bringLeft:(UIViewController*) target andClearStack:(bool) clear
{
	[self bring:target fromX:320 fromY:0 toX:0 toY:0 andClearStack:clear];
}


- (void) backfromX:(int) x fromY:(int) y toX:(int) toX toY:(int) toY
{
	if ([pageStack count] <= 1) {
		NSLog(@"Cannot back since there are no controllers left.");
		return;
	}
	
	UIViewController* current = (UIViewController*)[pageStack lastObject];
	[pageStack removeLastObject];
	
	UIViewController* previous = [pageStack lastObject];
	
	previous.view.frame = CGRectMake(0, 0, 320, 460);
	current.view.frame = CGRectMake(x, y, 320, 460);
	
	[self.view insertSubview:previous.view belowSubview:current.view];
	
	[UIView setAnimationsEnabled:YES];
	[UIView beginAnimations:nil context:nil];
	
	[UIView animateWithDuration:10.0
						  delay:0.0
						options:UIViewAnimationCurveEaseInOut
					 animations:^{
						 current.view.frame = CGRectMake(toX, toY, 320, 460);
					 }
					 completion:^(BOOL finished) {
						 [current.view removeFromSuperview];
						 [current viewDidDisappear:YES];
						 [previous viewDidAppear:YES];
					 }]; 
	
	[previous viewWillAppear:YES];
	[current viewWillDisappear:YES];
}


- (void) backDown
{
	[self backfromX:0 fromY:0 toX:0 toY:460];
}

- (void) backRight
{
	[self backfromX:0 fromY:0 toX:320 toY:0];
}








@end
