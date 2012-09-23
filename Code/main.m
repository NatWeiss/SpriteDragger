
#import "App.h"

int main(int argc, char* argv[])
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"SpriteDragger");
	[pool release];
    return retVal;
}
