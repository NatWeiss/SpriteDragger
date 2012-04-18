
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

		// must be called before any othe call to the director
		[CCDirector setDirectorType:kCCDirectorTypeDisplayLink];

		// set cocos2d director options
		CCDirector* director = [CCDirector sharedDirector];
		[director setAnimationInterval:(1.0f / 60.0f)]; // how many frames per second (ideally)
		
		// manually create the embedded (apple) graphics library view
		glView = [[EAGLView alloc]
			initWithFrame:[window bounds]
			pixelFormat:kEAGLColorFormatRGBA8 // we conserve video memory here
			depthFormat:GL_DEPTH_COMPONENT24_OES // we need a depth buffer for better z ordering
			preserveBackbuffer:NO
			sharegroup:nil
			multiSampling:NO // turning on multiSampling seems to slow things down...
			numberOfSamples:0];

		// allow multiple touches
		[glView setMultipleTouchEnabled:YES];

		// attach the openglView to the director
		[director setOpenGLView:glView];
		
		// make the OpenGLView a child of the main window
		[window addSubview:glView];

		// make main window visible
		[window makeKeyAndVisible];
	}

	-(void) dealloc
	{
		// release our window
		[window release];
		[glView release];
		
		// remember to [super dealloc]
		[super dealloc];
	}

@end
