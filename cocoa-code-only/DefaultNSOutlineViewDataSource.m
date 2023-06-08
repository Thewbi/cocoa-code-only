//
//  DefaultNSOutlineViewDataSource.m
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import "DefaultNSOutlineViewDataSource.h"



// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/OutlineView/Articles/UsingOutlineDataSource.html#//apple_ref/doc/uid/20000725
// https://stackoverflow.com/questions/26330468/nsoutlineview-object-value-is-being-returned-but-only-the-placeholder-title/26331214#26331214

@implementation DefaultNSOutlineViewDataSource

    //IBOutlet NSTableView* yourTableView;

    // https://stackoverflow.com/questions/6664898/nsoutlineview-example/9387255#9387255
    NSDictionary *firstParent = @{@"parent": @"Foo", @"children": @[@"Foox", @"Fooz"]};
    NSDictionary *secondParent = @{@"parent": @"Bar", @"children": @[@"Barx", @"Barz"]};

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
    NSLog(@"[DefaultNSOutlineViewDataSource] init()");
    
    
    
    self = [super init];
    if (self) {
        //CMExample *largeTableExample = [[CMExample alloc] initWithName:@"Large Table"];
        //CMTopLevelCategory *tablesCategory = [[CMTopLevelCategory alloc] initWithName:@"Tables" examples:@[ largeTableExample ]];
        
        //_topLevelCategories = @[ tablesCategory ];
        
        
        //NSArray *list = @[firstParent, secondParent];
        
        list = @[firstParent, secondParent];
        
        //[self setDataSource:self];
        //[self setDelegate:self];
    }
    return self;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return false;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    
    NSLog(@"[DefaultNSOutlineViewDataSource] child()ofItem()");
    
//    if (item) {
////        if ([item isKindOfClass:CMTopLevelCategory.class]) {
////            CMTopLevelCategory *topLevelCategory = item;
////            return [topLevelCategory.examples objectAtIndex:index];
////        }
//        return nil;
//    } else {
//        //return [self.topLevelCategories objectAtIndex:index];
//        return nil;
//    }
//    return nil;
    
    if (item == nil) {
        // item is nil when the outline view wants to inquire for root level items
        return [list objectAtIndex:index];
    }
    
    if ([item isKindOfClass:[NSDictionary class]]) {
        return [[item objectForKey:@"children"] objectAtIndex:index];
    }
    
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    NSLog(@"[DefaultNSOutlineViewDataSource] isItemExpandable()");
    //return [item isKindOfClass:CMTopLevelCategory.class];
    //return false;
    
    if ([item isKindOfClass:[NSDictionary class]]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    NSLog(@"[DefaultNSOutlineViewDataSource] numberOfChildrenOfItem()");
//    if (item) {
//        if ([item isKindOfClass:CMTopLevelCategory.class]) {
//            CMTopLevelCategory *topLevelCategory = item;
//            return [topLevelCategory.examples count];
//        }
//    } else {
//        return [self.topLevelCategories count];
//    }
    
    
    
    if (item) {
        
        
        
        if ([item isKindOfClass:[NSDictionary class]]) {
            
            NSInteger number = [[item objectForKey:@"children"] count];
            NSLog(@"[AppDelegate] numberOfChildrenOfItem() mid level items requested! amount: %li", number);
            
            return number;
        }
        
    } else {
        NSInteger number = [list count];
        
        // https://stackoverflow.com/questions/6664898/nsoutlineview-example/9387255#9387255
        // item is nil when the outline view wants to inquire for root level items
        NSLog(@"[AppDelegate] numberOfChildrenOfItem() root level items requested! amount: %li", (long)number);
        
        
        return number;
    }
    
    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    NSLog(@"[DefaultNSOutlineViewDataSource] byItem()");
//    if ([item isKindOfClass:CMTopLevelCategory.class]) {
//        CMTopLevelCategory *topLevelCategory = item;
//        if ([tableColumn.identifier isEqualToString:CMNameColumnIdentifier]) {
//            return topLevelCategory.name;
//        } else if ([tableColumn.identifier isEqualToString:CMCountColumnIdentifier]) {
//            return [NSNumber numberWithUnsignedInteger:[topLevelCategory.examples count]];
//        }
//    } else if ([item isKindOfClass:CMExample.class]) {
//        CMExample *example = item;
//        if ([tableColumn.identifier isEqualToString:CMNameColumnIdentifier]) {
//            return example.name;
//        }
//    }
    
    //return @"default value";
    
    if ([[tableColumn identifier] isEqualToString:@"children"]) {
        
        if ([item isKindOfClass:[NSDictionary class]]) {
            
            NSString *value = [NSString stringWithFormat:@"%lu", (unsigned long)[[item objectForKey:@"children"] count]];
            
            NSLog(@"[AppDelegate] - value: %@", value);
            
            return value;
        }
        
        return @"0";
        
    } else if ([[tableColumn identifier] isEqualToString:@"parent"]) {
        
        if ([item isKindOfClass:[NSDictionary class]]) {
            
            id value = [item objectForKey:@"parent"];
            
            NSLog(@"[AppDelegate] - value: %@", value);
            
            return value;
        }
    }
    
    //return @"default value";
    return item;
}



- (BOOL)outlineView:(NSOutlineView *)outlineView shouldExpandItem:(id)item
{
    return YES;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldCollapseItem:(id)item
{
    return NO;
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}




/* View Based OutlineView: See the delegate method -tableView:viewForTableColumn:row: in NSTableView.
 */
- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item API_AVAILABLE(macos(10.7)) {
    NSLog(@"[DefaultNSOutlineViewDataSource] viewForTableColumn()");
    
//    NSLog(@"Here %f", tableColumn.width);
//    NSTableCellView *result = [[NSTableCellView alloc] init];
//    NSTextField *textField = [[NSTextField alloc] init];
//    [textField setStringValue:@"Test"];
//    [result addSubview:textField];
//    return result;
//
//    return nil;
    
    NSTextField *textField = [[NSTextField alloc] init];
    [textField setStringValue: @"Test"];
    
    return textField;
}

/* View Based OutlineView: See the delegate method -tableView:rowViewForRow: in NSTableView.
 
- (nullable NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item API_AVAILABLE(macos(10.7)) {
    NSLog(@"[DefaultNSOutlineViewDataSource] rowViewForItem()");
    
    return nil;
}*/

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
//    NSLog(@"[DefaultNSOutlineViewDataSource] willDisplayCell()");
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
