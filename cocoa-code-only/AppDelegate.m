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

//IBOutlet NSTableView* yourTableView;


// https://stackoverflow.com/questions/6664898/nsoutlineview-example/9387255#9387255
//NSDictionary *firstParent = @{@"parent": @"Foo", @"children": @[@"Foox", @"Fooz"]};
//NSDictionary *secondParent = @{@"parent": @"Bar", @"children": @[@"Barx", @"Barz"]};

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



//- (void)awakeFromNib
//{
////    // this is the simplest data source you might get
////    dataSource = [NSArray arrayWithObjects:@"John", @"Mary", @"George", nil]; // are we leaking ?
////    // if I am debugging, show the entire data structure in the console:
////#if DEBUG
////    NSLog(@"%@", dataSource);
////#endif
//    // if I am debugging, inform the that the nib is awoke. very basic, I will extend it later.
////#if DEBUG
//    NSLog(@"nib awaken");
////#endif
//}








-(void)buttonPressed:(NSButton *)sender {
    NSLog(@"[AppDelegate] Button pressed! Button: '%@'", sender.identifier);
    
    // For Strings you use %@
    // For int  you use %i
    // For float you use %f
    // For double you use %lf
}

-(void)sliderValueChanged:(NSSlider *)sender {
    
    // https://stackoverflow.com/questions/3919905/subclassing-nsslider-need-a-workaround-for-missing-mouse-up-events-cocoa-osx
    NSEvent *event = [[NSApplication sharedApplication] currentEvent];
    BOOL startingDrag = event.type == NSEventTypeLeftMouseDown;
    BOOL endingDrag = event.type == NSEventTypeLeftMouseUp;
    BOOL dragging = event.type == NSEventTypeLeftMouseDragged;
    
    NSAssert(startingDrag || endingDrag || dragging, @"unexpected event type caused slider change: %@", event);
    
    if (startingDrag) {
        //NSLog(@"slider value started changing");
        // do whatever needs to be done when the slider starts changing
    }
    
    // do whatever needs to be done for "uncommitted" changes
    //NSLog(@"slider value: %f", [sender doubleValue]);
    
    if (endingDrag) {
        //NSLog(@"slider value stopped changing");
        // do whatever needs to be done when the slider stops changing
        
        double sliderValue = sender.doubleValue;
        NSLog(@"[AppDelegate] Slider value changed! Slider: '%@' sliderValue: %lf", sender.identifier, sliderValue);
    }
}

-(void)textfieldValueChanged:(NSTextField *)sender {
    
    NSString* value = sender.stringValue;
    NSLog(@"[AppDelegate] Textfield value changed! Slider: '%@' value: %@", sender.identifier, value);
}



//- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item {
//    NSLog(@"[DefaultNSOutlineViewDataSource] numberOfChildrenOfItem() id: %@", item);
//
//    return 1;
//}
//
//- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item {
//    NSLog(@"[DefaultNSOutlineViewDataSource] child()ofItem()");
//
//    return nil;
//}
//
//- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
//    NSLog(@"[DefaultNSOutlineViewDataSource] isItemExpandable()");
//
//    return false;
//}

- (id)init {
    NSLog(@"[AppDelegate] init()");
    
    
    
    self = [super init];
    if (self) {
        //CMExample *largeTableExample = [[CMExample alloc] initWithName:@"Large Table"];
        //CMTopLevelCategory *tablesCategory = [[CMTopLevelCategory alloc] initWithName:@"Tables" examples:@[ largeTableExample ]];
        
        //_topLevelCategories = @[ tablesCategory ];
        
        
        //NSArray *list = @[firstParent, secondParent];
        
        //list = @[firstParent, secondParent];
        
        //[self setDataSource:self];
        //[self setDelegate:self];
    }
    return self;
}

////- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
////    return false;
////}
//
//- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
//    
//    NSLog(@"[AppDelegate] child() ofItem()");
//    
//    //    if (item) {
//    ////        if ([item isKindOfClass:CMTopLevelCategory.class]) {
//    ////            CMTopLevelCategory *topLevelCategory = item;
//    ////            return [topLevelCategory.examples objectAtIndex:index];
//    ////        }
//    //        return nil;
//    //    } else {
//    //        //return [self.topLevelCategories objectAtIndex:index];
//    //        return nil;
//    //    }
//    //    return nil;
//    
//    if (item == nil) {
//        // item is nil when the outline view wants to inquire for root level items
//        return [list objectAtIndex:index];
//    }
//    
//    if ([item isKindOfClass:[NSDictionary class]]) {
//        return [[item objectForKey:@"children"] objectAtIndex:index];
//    }
//    
//    return nil;
//}
//
//- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
//    NSLog(@"[AppDelegate] isItemExpandable()");
//    //return [item isKindOfClass:CMTopLevelCategory.class];
//    //return false;
//    
//    if ([item isKindOfClass:[NSDictionary class]]) {
//        return YES;
//    } else {
//        return NO;
//    }
//    
//   // return true;
//}
//
//- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
//    NSLog(@"[AppDelegate] numberOfChildrenOfItem()");
//    //    if (item) {
//    //        if ([item isKindOfClass:CMTopLevelCategory.class]) {
//    //            CMTopLevelCategory *topLevelCategory = item;
//    //            return [topLevelCategory.examples count];
//    //        }
//    //    } else {
//    //        return [self.topLevelCategories count];
//    //    }
//    
//    
//    
//    if (item) {
//        
//        
//        
//        if ([item isKindOfClass:[NSDictionary class]]) {
//            
//            NSInteger number = [[item objectForKey:@"children"] count];
//            NSLog(@"[AppDelegate] numberOfChildrenOfItem() mid level items requested! amount: %li", number);
//            
//            return number;
//        }
//        
//    } else {
//        NSInteger number = [list count];
//        
//        // https://stackoverflow.com/questions/6664898/nsoutlineview-example/9387255#9387255
//        // item is nil when the outline view wants to inquire for root level items
//        NSLog(@"[AppDelegate] numberOfChildrenOfItem() root level items requested! amount: %li", (long)number);
//        
//        
//        return number;
//    }
//    
//    return 0;
//}
//
//- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
//    
//    NSLog(@"[AppDelegate] byItem() - column identifier: %@", tableColumn.identifier);
//    //    if ([item isKindOfClass:CMTopLevelCategory.class]) {
//    //        CMTopLevelCategory *topLevelCategory = item;
//    //        if ([tableColumn.identifier isEqualToString:CMNameColumnIdentifier]) {
//    //            return topLevelCategory.name;
//    //        } else if ([tableColumn.identifier isEqualToString:CMCountColumnIdentifier]) {
//    //            return [NSNumber numberWithUnsignedInteger:[topLevelCategory.examples count]];
//    //        }
//    //    } else if ([item isKindOfClass:CMExample.class]) {
//    //        CMExample *example = item;
//    //        if ([tableColumn.identifier isEqualToString:CMNameColumnIdentifier]) {
//    //            return example.name;
//    //        }
//    //    }
//    
//    //return @"default value";
//    
//    if ([[tableColumn identifier] isEqualToString:@"children"]) {
//        
//        if ([item isKindOfClass:[NSDictionary class]]) {
//            
//            NSString *value = [NSString stringWithFormat:@"%lu", (unsigned long)[[item objectForKey:@"children"] count]];
//            
//            NSLog(@"[AppDelegate] - value: %@", value);
//            
//            return value;
//        }
//        
//        return @"0";
//        
//    } else if ([[tableColumn identifier] isEqualToString:@"parent"]) {
//        
//        if ([item isKindOfClass:[NSDictionary class]]) {
//            
//            id value = [item objectForKey:@"parent"];
//            
//            NSLog(@"[AppDelegate] - value: %@", value);
//            
//            return value;
//        }
//    }
//    
//    //return @"default value";
//    return item;
//}
//
//
//
////- (BOOL)outlineView:(NSOutlineView *)outlineView shouldExpandItem:(id)item
////{
////    return YES;
////}
////
////- (BOOL)outlineView:(NSOutlineView *)outlineView shouldCollapseItem:(id)item
////{
////    return NO;
////}
////
////- (void)dealloc
////{
////    NSLog(@"deallocating %@", self);
////}
//
//
//
//
///* View Based OutlineView: See the delegate method -tableView:viewForTableColumn:row: in NSTableView.
// */
//- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item API_AVAILABLE(macos(10.7)) {
//    //NSLog(@"[DefaultNSOutlineViewDataSource] viewForTableColumn()");
//    //return nil;
//    
//    NSLog(@"[AppDelegate] viewForTableColumn() column name: %@, width: %f", tableColumn.identifier, tableColumn.width);
////    NSTableCellView *result = [[NSTableCellView alloc] init];
////    NSTextField *textField = [[NSTextField alloc] init];
////    [textField setStringValue:@"Test"];
////    [result addSubview:textField];
////
////    return result;
//    
//    NSTextField *textField = [[NSTextField alloc] init];
//    [textField setStringValue: @"Test"];
//    
//    return textField;
//}

///* View Based OutlineView: See the delegate method -tableView:rowViewForRow: in NSTableView.
// */
// - (nullable NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item API_AVAILABLE(macos(10.7)) {
// NSLog(@"[DefaultNSOutlineViewDataSource] rowViewForItem()");
//
// return nil;
// }

///* View Based OutlineView: This delegate method can be used to know when a new 'rowView' has been added to the table. At this point, you can choose to add in extra views, or modify any properties on 'rowView'.
// */
//- (void)outlineView:(NSOutlineView *)outlineView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7)) {
//    NSLog(@"[DefaultNSOutlineViewDataSource] didAddRowView()");
//}
//
///* View Based OutlineView: This delegate method can be used to know when 'rowView' has been removed from the table. The removed 'rowView' may be reused by the table so any additionally inserted views should be removed at this point. A 'row' parameter is included. 'row' will be '-1' for rows that are being deleted from the table and no longer have a valid row, otherwise it will be the valid row that is being removed due to it being moved off screen.
// */
//- (void)outlineView:(NSOutlineView *)outlineView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7)) {
//    NSLog(@"[DefaultNSOutlineViewDataSource] didRemoveRowView()");
//}
//
//- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {
//    NSLog(@"[AppDelegate] willDisplayCell()");
//}
//
//- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {
//    NSLog(@"[DefaultNSOutlineViewDataSource] shouldEditTableColumn()");
//
//    return false;
//}
//
//- (BOOL)selectionShouldChangeInOutlineView:(NSOutlineView *)outlineView {
//    NSLog(@"[DefaultNSOutlineViewDataSource] selectionShouldChangeInOutlineView()");
//
//    return false;
//}

@end
