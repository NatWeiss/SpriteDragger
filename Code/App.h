//
//  See the file 'LICENSE.iPhoneGameKit' for the license governing this code.
//      The license can also be obtained online at:
//          http://www.iPhoneGameKit.com/license
//

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

