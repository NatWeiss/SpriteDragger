
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface App : NSObject <UIApplicationDelegate, CCDirectorDelegate>
	{
		UIWindow* window;
		UINavigationController* navController;
	}
	
	-(void) setupGraphics;
	
@end

