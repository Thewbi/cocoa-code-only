//
//  main.m
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

//#import <UIKit/UIKit.h>
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "DefaultController.h"
#import "DefaultNSOutlineViewDataSource.h"
//#import "ViewController.h"

#import "AppDelegate.h"

/*
int main(int argc, const char * argv[]) {
    
    NSLog(@"main() ...");
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
*/

/*
int main(int argc, const char * argv[])
{
    return NSApplicationMain(argc, argv);
}
 */

int main(int argc, const char * argv[]) {
    
    NSLog(@"main() ...");
    
//todo: everything was moved from the controller into the delegate
  //  separate those classes again
    
    @autoreleasepool {
        
        id appDelegate = [[AppDelegate alloc] init];
        [NSApp setDelegate: appDelegate];
        
        id appName = [[NSProcessInfo processInfo] processName];
        
        //
        // MenuBar
        //
        
        id quitTitle = [@"Quit " stringByAppendingString:appName];
        id quitMenuItem = [[NSMenuItem alloc] initWithTitle:quitTitle
                                                     action:@selector(terminate:) keyEquivalent:@"q"];
        
        id appMenu = [NSMenu new];
        [appMenu addItem:quitMenuItem];
        
        id appMenuItem = [NSMenuItem new];
        [appMenuItem setSubmenu:appMenu];
        
        id menubar = [NSMenu new];
        [menubar addItem:appMenuItem];
        
        [NSApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
        [NSApp setMainMenu:menubar];
        
        //
        // ViewController
        //
        
        //id viewController = [[ViewController alloc] init];
        
        //
        // Main Window
        //
        
        id window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 640, 480)
                                                styleMask:NSWindowStyleMaskTitled
                                                  backing:NSBackingStoreBuffered defer:NO];
        [window cascadeTopLeftFromPoint: NSMakePoint(200, 400)];
        [window setTitle: appName];
        [window makeKeyAndOrderFront: nil];
        //[window setViewController: viewController];
        
        [appDelegate setWindow: window];
        
        //
        // custom UI controll (callback handler for widget events)
        //
        
        id controller = [DefaultController alloc];
 
        //
        // Button
        //
        // https://stackoverflow.com/questions/10251703/programmatically-create-and-position-an-nsbutton-in-a-macos-app
        // https://stackoverflow.com/questions/48102130/create-nsbutton-manually-call-function
        //
        
        int button_x = 20;
        int button_y = 10;
        
        int button_width = 130;
        int button_height = 25;
        
        NSButton *button_1 = [[NSButton alloc] initWithFrame:NSMakeRect(button_x, button_y, button_width, button_height)];
        
        [button_1 setTitle: @"Button title!"];
        [button_1 setIdentifier: @"button_1"];
        [button_1 setButtonType:NSButtonTypeMomentaryLight];
        [button_1 setBezelStyle:NSBezelStyleRounded];
        
        // event handling
        [button_1 setTarget:controller];
        //[button_1 setTarget:appDelegate];
        [button_1 setAction:@selector(buttonPressed:)];
        
        // add the button to the window
        [[window contentView] addSubview: button_1];
        
        //
        // Slider
        //
        
        int slider_x = 20;
        int slider_y = 50;
        
        int slider_width = 130;
        int slider_height = 25;
        
        NSSlider *slider_1 = [[NSSlider alloc] initWithFrame:NSMakeRect(slider_x, slider_y, slider_width, slider_height)];
        
        [slider_1 setIdentifier: @"slider_1"];
        
        // event handling
        [slider_1 setTarget:controller];
        //[slider_1 setTarget:appDelegate];
        [slider_1 setContinuous:YES];
        [slider_1 setAction:@selector(sliderValueChanged:)];
        
        // add the slider to the window
        [[window contentView] addSubview: slider_1];
        
        //
        // Text field
        //
        // https://developer.apple.com/library/archive/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextFieldsAndViews/TextFieldsAndViews.html
        //
        
        int textfield_x = 20;
        int textfield_y = 90;
        
        int textfield_width = 130;
        int textfield_height = 25;
        
        NSTextField *textfield_1 = [[NSTextField alloc] initWithFrame:NSMakeRect(textfield_x, textfield_y, textfield_width, textfield_height)];
        
        [textfield_1 setIdentifier: @"textfield_1"];
        
        // event handling
        [textfield_1 setTarget:controller];
        //[textfield_1 setTarget:appDelegate];
        [textfield_1 setAction:@selector(textfieldValueChanged:)];
        
        // add the slider to the window
        [[window contentView] addSubview: textfield_1];
        
        //
        // NSOutlineView
        //
        // https://developer.apple.com/documentation/appkit/nsoutlineview?language=objc
        // https://stackoverflow.com/questions/19464136/view-based-nsoutlineview-without-nib
        //
        
        id outlineDataSource = [[DefaultNSOutlineViewDataSource alloc] init];
        
        int outline_x = 20;
        int outline_y = 270;
        //int outline_y = 20;
        
        int outline_width = 400;
        int outline_height = 200;
        
        /**/
        
        
        //NSOutlineView *outline_1 = [[NSOutlineView alloc] initWithFrame: NSMakeRect(outline_x, outline_y, outline_width, outline_height)];
        NSOutlineView* outline_1 = [[NSOutlineView alloc] init];
        [outline_1 setIdentifier: @"outline_1"];
        
        outline_1.selectionHighlightStyle = NSTableViewSelectionHighlightStyleSourceList;
        outline_1.floatsGroupRows = NO;
        outline_1.indentationPerLevel = 16.f;
        outline_1.indentationMarkerFollowsCell = NO;
        outline_1.wantsLayer = YES;
        outline_1.layer.backgroundColor = [NSColor secondarySelectedControlColor].CGColor;
        
        [outline_1 setDataSource: outlineDataSource];
        [outline_1 setDelegate: outlineDataSource];
        //[outline_1 setDataSource: appDelegate];
        //[outline_1 setDelegate: appDelegate];
        //[outline_1 setBounds: NSMakeRect(outline_x, outline_y, outline_width, outline_height)];
        
        // https://stackoverflow.com/questions/22149164/nsoutlineview-source-list-without-a-nib
        NSTableColumn *c = [[NSTableColumn alloc] initWithIdentifier: @"children"];
        //NSTableCellView *c = [[NSTableCellView alloc] initWithIdentifier: @"children"];
        [c setEditable: NO];
        [c setMinWidth: 150.0];
        c.headerCell.stringValue = @"children";
        [outline_1 addTableColumn: c];
        [outline_1 setOutlineTableColumn: c];
        
        NSTableColumn *p = [[NSTableColumn alloc] initWithIdentifier: @"parent"];
        [p setEditable: NO];
        [p setMinWidth: 150.f];
        p.headerCell.stringValue = @"parent";
        //p.dataCell = NSCell.
        [outline_1 addTableColumn: p];
        [outline_1 setOutlineTableColumn: p];
        
//        NSTableColumn* col1 = [[NSTableColumn alloc] initWithIdentifier:@"col1"];
//        col1.editable = NO;
//        col1.minWidth = 150.f;
//        col1.headerCell.stringValue = [NSString stringWithFormat:@"DUT%lu", 1];
//        [outline_1 addTableColumn: col1];
//        [outline_1 setOutlineTableColumn: col1];
        
//        [outline_1 display];
//        [outline_1 reloadData];
        
        //[appDelegate setOutlineView: outline_1];
        
        // add the outline to the window
        //[[window contentView] addSubview: outline_1];
        
        NSClipView* clipview = [[NSClipView alloc] init];
        clipview.autoresizesSubviews = YES;
        clipview.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        clipview.documentView = outline_1;
        
        NSScrollView* container = [[NSScrollView alloc] initWithFrame: NSMakeRect(outline_x, outline_y, outline_width, outline_height)];
        container.hasVerticalScroller = YES;
        container.hasHorizontalScroller = YES;
        container.wantsLayer = YES;
        container.identifier = @"test";
        container.contentView = clipview;
        
        [[window contentView] addSubview: container];
        
//        [outline_1 display];
//        [outline_1 reloadData];
         
        /*
        // https://gist.github.com/adison/41bcfe6d8608505844ed109bfb1d08f7
        NSScrollView* container = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        container.hasVerticalScroller = YES;
        container.hasHorizontalScroller = YES;
        container.wantsLayer = YES;
        container.identifier = @"test";
        
        NSClipView* clipview = [[NSClipView alloc] init];
        clipview.autoresizesSubviews = YES;
        clipview.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
        NSOutlineView* outline = [[NSOutlineView alloc] init];
        outline.selectionHighlightStyle = NSTableViewSelectionHighlightStyleSourceList;
        outline.floatsGroupRows = NO;
        outline.indentationPerLevel = 16.f;
        outline.indentationMarkerFollowsCell = NO;
        outline.wantsLayer = YES;
        outline.layer.backgroundColor = [NSColor secondarySelectedControlColor].CGColor;
        
        // outline code
        NSTableColumn* col1 = [[NSTableColumn alloc] initWithIdentifier:@"col1"];
        col1.editable = NO;
        col1.minWidth = 300000.f;
        col1.headerCell.stringValue = [NSString stringWithFormat:@"DUT%lu", 1];
        [outline addTableColumn:col1];
        [outline setOutlineTableColumn:col1];
        
        container.contentView = clipview;
        clipview.documentView = outline;
        
        [[window contentView] addSubview: container];
         */
        
        //
        // TODO
        //
        
        // menu bar
        // radio buttons
        // check boxes
        // combo box
        // item list
        // tree
        // table
        
        //
        // Application
        //
        
        [NSApp activateIgnoringOtherApps:YES];
        
        //[NSApp setDelegate: appDelegate];
        [NSApp run];
    }
    return 0;
}


