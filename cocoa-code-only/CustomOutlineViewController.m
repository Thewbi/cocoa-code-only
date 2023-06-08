//
//  CustomOutlineViewController.m
//  cocoa-code-only
//
//  Created by Wolfgang Bischoff on 08.06.23.
//

#import "CustomOutlineViewController.h"

@implementation CustomOutlineViewController

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    
    NSLog(@"[AppDelegate] byItem() - column identifier: %@", tableColumn.identifier);
    
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
    
    return item;
}

/* View Based OutlineView: See the delegate method -tableView:viewForTableColumn:row: in NSTableView.
 */
- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item API_AVAILABLE(macos(10.7)) {
    
    NSLog(@"[AppDelegate] viewForTableColumn() column name: %@, width: %f", tableColumn.identifier, tableColumn.width);
    
    NSTextField *textField = [[NSTextField alloc] init];
    [textField setStringValue: @"Test"];
    
    return textField;
}

/* View Based OutlineView: See the delegate method -tableView:rowViewForRow: in NSTableView.
 */
- (nullable NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item API_AVAILABLE(macos(10.7)) {
    NSLog(@"[DefaultNSOutlineViewDataSource] rowViewForItem()");
    
    return nil;
}

/* View Based OutlineView: This delegate method can be used to know when a new 'rowView' has been added to the table. At this point, you can choose to add in extra views, or modify any properties on 'rowView'.
 */
- (void)outlineView:(NSOutlineView *)outlineView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7)) {
    NSLog(@"[DefaultNSOutlineViewDataSource] didAddRowView()");
}

/* View Based OutlineView: This delegate method can be used to know when 'rowView' has been removed from the table. The removed 'rowView' may be reused by the table so any additionally inserted views should be removed at this point. A 'row' parameter is included. 'row' will be '-1' for rows that are being deleted from the table and no longer have a valid row, otherwise it will be the valid row that is being removed due to it being moved off screen.
 */
- (void)outlineView:(NSOutlineView *)outlineView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7)) {
    NSLog(@"[DefaultNSOutlineViewDataSource] didRemoveRowView()");
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {
    NSLog(@"[AppDelegate] willDisplayCell()");
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {
    NSLog(@"[DefaultNSOutlineViewDataSource] shouldEditTableColumn()");
    
    return false;
}

- (BOOL)selectionShouldChangeInOutlineView:(NSOutlineView *)outlineView {
    NSLog(@"[DefaultNSOutlineViewDataSource] selectionShouldChangeInOutlineView()");
    
    return false;
}

@end
