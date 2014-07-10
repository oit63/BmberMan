//
//  AppDelegate.h
//  BmberMan
//
//  Created by 李海洋 on 12-9-17.
//  Copyright __njcit__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
