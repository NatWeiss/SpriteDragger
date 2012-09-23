
#import "App.h"

@implementation App

	-(void) startApp
	{
		// override this method with a category
	}

	-(void) applicationDidFinishLaunching:(UIApplication*)application
	{
		// setup the graphical display
		[self setupGraphics];
		
		// start the app
		[self startApp];
	}
	
	-(void) setupGraphics
	{
		// create the window
		window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

		// set cocos2d director options
		CCDirector* director = [CCDirector sharedDirector];
		[director setAnimationInterval:(1.0f / 60.0f)]; // how many frames per second (ideally)
		
		// manually create the embedded (apple) graphics library view
		CCGLView* __glView = [[CCGLView alloc]
			initWithFrame:[window bounds]
			pixelFormat:kEAGLColorFormatRGBA8
			depthFormat:GL_DEPTH_COMPONENT24_OES
			preserveBackbuffer:NO
			sharegroup:nil
			multiSampling:NO
			numberOfSamples:0];

		// attach the openglView to the director
		[director setView:__glView];
		[director setDelegate:self];
		director.wantsFullScreenLayout = YES;

		// allow multiple touches
		[__glView setMultipleTouchEnabled:YES];

		// use RootViewController manage EAGLView
		navController = [[UINavigationController alloc] initWithRootViewController:director];
		navController.navigationBarHidden = YES;

		// set root view controller seems to work fine on all ios versions,
		// except on ios6 it doesn't send shouldAutorotate...
		[window setRootViewController:navController];
		//[window addSubview:navController.view];

		// make main window visible
		[window makeKeyAndVisible];
	}

	-(void) dealloc
	{
		// release our window
		[window release];
		[navController release];
		
		// remember to [super dealloc]
		[super dealloc];
	}

@end
