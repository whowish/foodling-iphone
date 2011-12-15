//
//  MainController.h
//  foodling
//
//  Created by Apirom Na Nakorn on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MapController;
@class DishController;
@class ListController;


@interface MainController : UIViewController {
	NSMutableArray* pageStack;
	MapController *map;
	DishController *dish;
	ListController *list;
}

- (void) toDish;
- (void) toList;

- (void) bring:(UIViewController*) target fromX:(int) x fromY:(int) y toX:(int) toX toY:(int) toY andClearStack:(bool) clear;

- (void) bringUp:(UIViewController*) target andClearStack:(bool) clear;
- (void) bringLeft:(UIViewController*) target andClearStack:(bool) clear;


- (void) backfromX:(int) x fromY:(int) y toX:(int) toX toY:(int) toY;

- (void) backDown;
- (void) backRight;

@end

@end
