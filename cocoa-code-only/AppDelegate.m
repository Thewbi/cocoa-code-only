//
//  AppDelegate.m
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSOutlineView *outlineView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"[AppDelegate] applicationDidFinishLaunching() ...");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    NSLog(@"[AppDelegate] applicationWillTerminate() ...");
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    NSLog(@"[AppDelegate] applicationSupportsSecureRestorableState() ...");
    return YES;
}

- (id)init {
    NSLog(@"[AppDelegate] init()");
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
