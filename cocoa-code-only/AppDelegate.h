//
//  AppDelegate.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSOutlineViewDelegate, NSOutlineViewDataSource> {
    NSArray *list;
    //@property (weak) IBOutlet NSOutlineView *outlineView;
    //IBOutlet NSOutlineView *outlineView;
}

-(void)buttonPressed:(NSButton *)sender;

-(void)sliderValueChanged:(NSSlider *)sender;

// Press Enter in the textfield to trigger this handler
-(void)textfieldValueChanged:(NSTextField *)sender;

@end

