
#import "SpriteDragger.h"

@implementation App (SpriteDragger)

	// this overrides App's startApp method
	-(void) startApp
	{
		// create a generic scene
		CCScene* scene = [CCScene node];
		
		// add the layer
		id layer = [[SpriteDragger alloc] init];
		[scene addChild:layer z:1];
		[layer release]; // addChild retained
		
		// run the first scene
		[[CCDirector sharedDirector] runWithScene:scene];
	}

@end

@implementation SpriteDragger

	-(id) init
	{
		self = [super init];
		if( self != nil )
		{
			// create background
			colorLayer = [[CCLayerColor alloc] initWithColor:ccc4(255, 255, 255, 255)];
			[self addChild:colorLayer z:1];

			// create sprite
			CGSize iSize = [[CCDirector sharedDirector] winSize];
			sprite = [[CCSprite alloc] initWithFile:@"Sprite.png"];
			sprite.position = ccp(iSize.width / 2.0f, iSize.height / 2.0f);
			sprite.anchorPoint = ccp(0.5f, 0.55f); // nudge the anchor point upward because of the shadow
			[self addChild:sprite z:2];
			
			// enable touches so we can drag
			self.isTouchEnabled = YES;
		}
		return self;
	}
	
	-(void) dealloc
	{
		// unset this so we unregister with the touch dispatcher
		self.isTouchEnabled = NO;
		
		// release our sprite and layer so that it gets dealloced
		[sprite release];
		[colorLayer release];
		
		// always call [super dealloc]
		[super dealloc];
	}

	-(CGPoint) touchToPoint:(UITouch*)touch
	{
		// convert the touch object to a position in our cocos2d space
		return [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
	}
	
	-(BOOL) isTouchingSprite:(UITouch*)touch
	{
		// here's one way, but includes the rectangular white space around our sprite
		//return CGRectContainsPoint([sprite boundingBox], [self touchToPoint:touch]);
		
		// this way is more intuitive for the user because it ignores the white space.
		// it works by calculating the distance between the sprite's center and the touch point,
		// and seeing if that distance is less than the sprite's radius
		return (ccpDistance(sprite.position, [self touchToPoint:touch]) < 100.0f);
	}
	
	-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
	{
		// ccTouchBegan needs to return YES if we want to handle the touch
		// and start to receive ccTouchMoved messages
		if( [self isTouchingSprite:touch] )
		{
			// calculate offset from sprite to touch point
			touchOffset = ccpSub(sprite.position, [self touchToPoint:touch]);
			return YES;
		}
		
		// return NO because we don't want to handle this touch
		return NO;
	}
	
	-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent*)event
	{
		// set the new sprite position
		sprite.position = ccpAdd([self touchToPoint:touch], touchOffset);
	}
	
	-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent*)event
	{
		// set the new sprite position
		sprite.position = ccpAdd([self touchToPoint:touch], touchOffset);

		// animate letting go of the sprite
		[sprite runAction:[CCSequence actions:
			[CCScaleBy actionWithDuration:0.125f scale:1.111f],
			[CCScaleBy actionWithDuration:0.125f scale:0.9f],
			nil]];
	}

	-(void) registerWithTouchDispatcher
	{
		// we must implement this method so that we start to receive ccTouch messages
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:(kCCMenuTouchPriority - 2) swallowsTouches:YES];
	}

@end
