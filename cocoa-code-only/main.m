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
#import "CustomOutlineViewController.h"
#import "ViewController.h"

#import "DefaultNSOutlineViewDataSource.h"

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
    
    @autoreleasepool {
        
        id appDelegate = [[AppDelegate alloc] init];
        [NSApp setDelegate: appDelegate];
        
        id appName = [[NSProcessInfo processInfo] processName];
        
        //
        // custom UI controll (callback handler for widget events)
        //
        
        id defaultController = [DefaultController alloc];
        id customOutlineViewController = [CustomOutlineViewController alloc];
        
        //
        // MenuBar
        //
        
        id menuItem1Title = @"Menu Item 1";
        id menuItem1MenuItem = [[NSMenuItem alloc] initWithTitle:menuItem1Title
                                                     action:@selector(menuItemCallback:) keyEquivalent:@"q"];
        [menuItem1MenuItem setTarget:defaultController];
        
        id quitTitle = [@"Quit " stringByAppendingString:appName];
        id quitMenuItem = [[NSMenuItem alloc] initWithTitle:quitTitle
            action:@selector(terminate:) keyEquivalent:@"q"];
        
        id appMenu = [NSMenu new];
        [appMenu addItem:menuItem1MenuItem];
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
        [button_1 setTarget:defaultController];
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
        [slider_1 setTarget:defaultController];
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
        [textfield_1 setTarget:defaultController];
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
        
        int outline_width = 400;
        int outline_height = 200;
        
        NSOutlineView* outline_1 = [[NSOutlineView alloc] init];
        [outline_1 setIdentifier: @"outline_1"];
        
        outline_1.selectionHighlightStyle = NSTableViewSelectionHighlightStyleSourceList;
        outline_1.floatsGroupRows = NO;
        outline_1.indentationPerLevel = 16.f;
        outline_1.indentationMarkerFollowsCell = NO;
        outline_1.wantsLayer = YES;
        outline_1.layer.backgroundColor = [NSColor secondarySelectedControlColor].CGColor;
        
        [outline_1 setDataSource: outlineDataSource];
        
        //
        // Put a controller into the outline view. This step is optional and there
        // are different implementations to choose from. Try leaving the controller
        // away entirely and also try the different implementations
        //
        // this controller set into the outline view causes default outline view looks
        //[outline_1 setDelegate: defaultController];
        //
        // custom implementation for callback functions and an edit field as cell item
        [outline_1 setDelegate: customOutlineViewController];
        
        // https://stackoverflow.com/questions/22149164/nsoutlineview-source-list-without-a-nib
        NSTableColumn *c = [[NSTableColumn alloc] initWithIdentifier: @"children"];        [c setEditable: NO];
        [c setMinWidth: 150.0];
        c.headerCell.stringValue = @"children";
        [outline_1 addTableColumn: c];
        [outline_1 setOutlineTableColumn: c];
        
        NSTableColumn *p = [[NSTableColumn alloc] initWithIdentifier: @"parent"];
        [p setEditable: NO];
        [p setMinWidth: 150.f];
        p.headerCell.stringValue = @"parent";
        [outline_1 addTableColumn: p];
        [outline_1 setOutlineTableColumn: p];
        
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
        
        //
        // radio buttons
        //
        
        // Radio Button group 2
        
        // https://developer.apple.com/documentation/appkit/nsmatrix?language=objc
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Button/Concepts/RadioButtons.html#//apple%5Fref/doc/uid/20000252
        
        // a view defines the scope that combines radio buttons into a radio button group
        // RadioButtons share state amongst only one radio button group
        // If you want several group of radio buttons, each group needs their own view
        NSView *radioButtonGroup_1 = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 400)];
        
        int button_2_x = 20;
        int button_2_y = 130;
        
        int button_2_width = 130;
        int button_2_height = 25;
        
        NSButton *button_2 = [[NSButton alloc] initWithFrame:NSMakeRect(button_2_x, button_2_y, button_2_width, button_2_height)];
        NSButton *button_3 = [[NSButton alloc] initWithFrame:NSMakeRect(button_2_x, button_2_y, button_2_width, button_2_height + 40)];
        NSButton *button_4 = [[NSButton alloc] initWithFrame:NSMakeRect(button_2_x, button_2_y, button_2_width, button_2_height + 80)];
        
        [button_2 setTitle: @"button_2"];
        [button_2 setIdentifier: @"button_2"];
        [button_2 setButtonType:NSButtonTypeRadio];
        
        [button_3 setTitle: @"button_3"];
        [button_3 setIdentifier: @"button_3"];
        [button_3 setButtonType:NSButtonTypeRadio];
        
        [button_4 setTitle: @"button_4"];
        [button_4 setIdentifier: @"button_4"];
        [button_4 setButtonType:NSButtonTypeRadio];
        
        // event handling
        [button_2 setTarget:defaultController];
        [button_2 setAction:@selector(buttonPressed:)];
        [button_3 setTarget:defaultController];
        [button_3 setAction:@selector(buttonPressed:)];
        [button_4 setTarget:defaultController];
        [button_4 setAction:@selector(buttonPressed:)];
        
        // add the buttons to the radioButtonGroup
        [radioButtonGroup_1 addSubview: button_2];
        [radioButtonGroup_1 addSubview: button_3];
        [radioButtonGroup_1 addSubview: button_4];
        
        // add the radioButtonGroup to the window
        [[window contentView] addSubview: radioButtonGroup_1];
        
        // Radio Button group 2
        
        // a view defines the scope that combines radio buttons into a radio button group
        // RadioButtons share state amongst only one radio button group
        // If you want several group of radio buttons, each group needs their own view
        NSView *radioButtonGroup_2 = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 400)];
        
        int button_5_x = 150;
        int button_5_y = 130;
        
        int button_5_width = 130;
        int button_5_height = 25;
        
        NSButton *button_5 = [[NSButton alloc] initWithFrame:NSMakeRect(button_5_x, button_5_y, button_5_width, button_5_height)];
        NSButton *button_6 = [[NSButton alloc] initWithFrame:NSMakeRect(button_5_x, button_5_y, button_5_width, button_5_height + 40)];
        NSButton *button_7 = [[NSButton alloc] initWithFrame:NSMakeRect(button_5_x, button_5_y, button_5_width, button_5_height + 80)];
        
        [button_5 setTitle: @"button_5"];
        [button_5 setIdentifier: @"button_5"];
        [button_5 setButtonType:NSButtonTypeRadio];
        
        [button_6 setTitle: @"button_6"];
        [button_6 setIdentifier: @"button_6"];
        [button_6 setButtonType:NSButtonTypeRadio];
        
        [button_7 setTitle: @"button_7"];
        [button_7 setIdentifier: @"button_7"];
        [button_7 setButtonType:NSButtonTypeRadio];
        
        // event handling
        [button_5 setTarget:defaultController];
        [button_5 setAction:@selector(buttonPressed:)];
        [button_6 setTarget:defaultController];
        [button_6 setAction:@selector(buttonPressed:)];
        [button_7 setTarget:defaultController];
        [button_7 setAction:@selector(buttonPressed:)];
        
        // add the buttons to the radioButtonGroup
        [radioButtonGroup_2 addSubview: button_5];
        [radioButtonGroup_2 addSubview: button_6];
        [radioButtonGroup_2 addSubview: button_7];
        
        // add the radioButtonGroup to the window
        [[window contentView] addSubview: radioButtonGroup_2];
        
        //
        // check boxes
        //
        
        int button_8_x = 20;
        int button_8_y = 200;
        
        int button_8_width = 130;
        int button_8_height = 25;
        
        NSButton *button_8 = [[NSButton alloc] initWithFrame:NSMakeRect(button_8_x, button_8_y, button_8_width, button_8_height)];
        [button_8 setTitle: @"button_8"];
        [button_8 setIdentifier: @"button_8"];
        [button_8 setButtonType:NSButtonTypeSwitch];
        
        // event handling
        [button_8 setTarget:defaultController];
        [button_8 setAction:@selector(buttonPressed:)];
        
        // add the button to the window
        [[window contentView] addSubview: button_8];
        
        //
        // combo box / drop down
        //
        
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MenuList/Articles/ManagingPopUpItems.html
        // https://developer.apple.com/forums/thread/44190
        
        int button_9_x = 20;
        int button_9_y = 230;
        
        int button_9_width = 130;
        int button_9_height = 25;
        
        NSPopUpButton *popUpButton = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(button_9_x, button_9_y, button_9_width, button_9_height)];
        [popUpButton setTitle: @"button_9"];
        [popUpButton setIdentifier: @"button_9"];
        
        // Unlike popup lists, the title of a popup button displaying a pulldown
        // list is not based on the currently selected item and thus remains fixed
        // unless you change using the cell’s setTitle:method.
        popUpButton.pullsDown = true;
        //popUpButton.pullsDown = false;
        
        NSArray *popUpButtonItems = [NSArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", @"Item 4", nil];
        [popUpButton removeAllItems];
        [popUpButton addItemsWithTitles:popUpButtonItems];
        
        // event handling
        [popUpButton setTarget:defaultController];
        [popUpButton setAction:@selector(buttonPressed:)];
        
        // add the button to the window
        [[window contentView] addSubview: popUpButton];
        
        //
        // up/down spin input text field
        //
        
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MenuList/Articles/ManagingPopUpItems.html
        // https://developer.apple.com/forums/thread/44190
        
        int button_11_x = 280;
        int button_11_y = 230;
        
        int button_11_width = 130;
        int button_11_height = 25;
        
        NSPopUpButton *popUpUpDownButton = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(button_11_x, button_11_y, button_11_width, button_11_height)];
        [popUpUpDownButton setTitle: @"button_11"];
        [popUpUpDownButton setIdentifier: @"button_11"];
        
        // Unlike popup lists, the title of a popup button displaying a pulldown
        // list is not based on the currently selected item and thus remains fixed
        // unless you change using the cell’s setTitle:method.
        //popUpButton.pullsDown = true;
        popUpUpDownButton.pullsDown = false;
        
        NSArray *popUpUpDownButtonItems = [NSArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", @"Item 4", nil];
        [popUpUpDownButton removeAllItems];
        [popUpUpDownButton addItemsWithTitles:popUpUpDownButtonItems];
        
        // event handling
        [popUpUpDownButton setTarget:defaultController];
        [popUpUpDownButton setAction:@selector(buttonPressed:)];
        
        // add the button to the window
        [[window contentView] addSubview: popUpUpDownButton];
        
        //
        // UIStepper
        //
        
        // https://stackoverflow.com/questions/702829/integrate-nsstepper-with-nstextfield
        
        int textfield_2_x = 420;
        int textfield_2_y = 230;
        
        int textfield_2_width = 130;
        int textfield_2_height = 25;
        
        NSTextField *textfield_2 = [[NSTextField alloc] initWithFrame:NSMakeRect(textfield_2_x, textfield_2_y, textfield_2_width, textfield_2_height)];
        
        [textfield_2 setIdentifier: @"textfield_2"];
        
        //[defaultController textField:[textfield_2]];
        //[[defaultController textField] bind:textfield_2];
        
        //defaultController->textField = textfield_2;
        [defaultController setTextField: textfield_2];
        
        [textfield_2 setTarget:defaultController];
        [textfield_2 setAction:@selector(controlDidChange:)];
        
        // add the slider to the window
        [[window contentView] addSubview: textfield_2];
        
        int button_12_x = 550;
        int button_12_y = 230;
        
        int button_12_width = 20;
        int button_12_height = 25;
        
        NSStepper *stepper = [[NSStepper alloc] initWithFrame:NSMakeRect(button_12_x, button_12_y, button_12_width, button_12_height)];
        
        [[window contentView] addSubview:stepper];
        
        [defaultController setStepper: stepper];
        
        [stepper setTarget:defaultController];
        [stepper setAction:@selector(controlDidChange:)];
        
        [stepper setMinValue:0];
        [stepper setMaxValue:9];
        
        //
        // NSComboBox
        //
        
        // https://developer.apple.com/documentation/appkit/nscombobox?language=objc
        
        int button_10_x = 150;
        int button_10_y = 230;
        
        int button_10_width = 130;
        int button_10_height = 25;
        
        NSComboBox *comboBox = [[NSComboBox alloc] initWithFrame:NSMakeRect(button_10_x, button_10_y, button_10_width, button_10_height)];
        //[comboBox setTitle: @"button_10"];
        [comboBox setIdentifier: @"button_10"];
        
        NSArray *comboBoxItems = [NSArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", @"Item 4", nil];
        comboBox.usesDataSource = false;
        [comboBox addItemWithObjectValue: @"a"];
        [comboBox addItemsWithObjectValues: comboBoxItems];
        
        // pre select item
        [comboBox selectItemAtIndex:0];
        
        // event handling
        comboBox.delegate = defaultController;
        
        // add the button to the window
        [[window contentView] addSubview: comboBox];
        
        //
        // progress bar
        //
        
        // https://github.com/AppTyrant/NSProgressIndicator-ProgressBinding
        // https://github.com/NikolaGrujic91/Cocoa-macOS-Determinate-Progress-Bar/tree/master/Cocoa%20Progress%20Bar
        
        // without __block, the variable cannot be modified from within
        // the block used in the timer below
        double indicator_min = 0.0;
        double indicator_max = 100.0;
        double indicator_inc = 20.0;
        __block double indicator_curr_val = 0.0;
        __block bool increment = true;
        
        //NSProgress *progress = [[NSProgressIndicator alloc] init];
        
        int progress_indicator_1_x = 20;
        int progress_indicator_1_y = 250;
        
        int progress_indicator_1_width = 450;
        int progress_indicator_1_height = 25;
        
        NSProgressIndicator *progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(progress_indicator_1_x, progress_indicator_1_y, progress_indicator_1_width, progress_indicator_1_height)];
        //[progressIndicator startAnimation:nil];
        //[progressIndicator stopAnimation:nil];
        
        progressIndicator.minValue = indicator_min;
        progressIndicator.maxValue = indicator_max;
        //progressIndicator.doubleValue = progress.fractionCompleted;
        
        [progressIndicator setUsesThreadedAnimation: YES];
        //[progressIndicator setIndeterminate: YES];
        [progressIndicator setIndeterminate: NO];
        //[progressIndicator startAnimation: progress];
        //[progressIndicator startAnimation: nil];
        [progressIndicator setHidden: NO];
        
        indicator_curr_val = 50.0;
        [progressIndicator setDoubleValue: indicator_curr_val];
        
        indicator_curr_val += 30.0;
        [progressIndicator incrementBy: 30.0];
        
        // add the button to the window
        [[window contentView] addSubview: progressIndicator];
        
        // https://gist.github.com/davbeck/3661211
        // https://stackoverflow.com/questions/14924892/nstimer-with-anonymous-function-block
        NSTimer *progress_indicator_1_timer = [
            NSTimer scheduledTimerWithTimeInterval: 1.0
            target: [NSBlockOperation blockOperationWithBlock: ^{
                
                // this is an anonymous function aka. block this executed by the timer each tick
                
                //NSLog(@"progress_indicator_1_timer()");
                //[progressIndicator incrementBy: 5];
                
                indicator_curr_val = indicator_curr_val + ( increment ? indicator_inc : (-1.0)*indicator_inc );
                
                if (indicator_curr_val >= indicator_max)
                {
                    indicator_curr_val = indicator_max;
                    increment = false;
                }
                
                if (indicator_curr_val <= indicator_min)
                {
                    indicator_curr_val = indicator_min;
                    increment = true;
                }
                
                [progressIndicator setDoubleValue: indicator_curr_val];
            
            }]
            selector: @selector(main)
            userInfo: nil
            repeats: YES];
        
        //
        // TODO
        //
        
        // spinner for numbers (NSStepper)
        // item list
        // tree
        // table (https://github.com/NikolaGrujic91/Cocoa-macOS-Examples)
        // message boxes (https://github.com/NikolaGrujic91/Cocoa-macOS-Examples)
        // (modal) dialogs
        // status bar
        
        //
        // Application
        //
        
        [NSApp activateIgnoringOtherApps:YES];
        
        [NSApp run];
    }
    return 0;
}
