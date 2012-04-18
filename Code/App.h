
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface App : NSObject <UIApplicationDelegate>
	{
		UIWindow* window;
		EAGLView* glView;
	}
	
	-(void) setupGraphics;
	
@end

