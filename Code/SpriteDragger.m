
#import "SpriteDragger.h"
#import "TouchLayer.h"

@implementation SpriteDragger

	// this overrides App's startApp method
	-(void) startApp
	{
		// create a generic scene
		CCScene* scene = [CCScene node];
		
		// add the layer
		id layer = [[TouchLayer alloc] init];
		[scene addChild:layer z:1];
		[layer release]; // addChild retained
		
		// run the first scene
		[[CCDirector sharedDirector] runWithScene:scene];
	}

@end
