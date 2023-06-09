//
//  ViewController.m
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import "ViewController.h"

@implementation ViewController

@synthesize myOutlineView, myDataSource, itemType, itemName, unassignedGroup;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.myOutlineView setDelegate:self];
    [self.myOutlineView setDataSource:self];
    
    [self.myOutlineView registerForDraggedTypes: [NSArray arrayWithObject: @"public.content"]];
    
    // if unassignedGroup is null then instantiate it
    if (!self.unassignedGroup) {
        self.unassignedGroup = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    // if myDataSource is null then instantiate it, and add default group called Unassigned
    if (!self.myDataSource) {
        [self.unassignedGroup setObject:@"Unassigned" forKey:@"groupName"];
        [self.unassignedGroup setObject:[[NSMutableArray alloc] initWithCapacity:0] forKey:@"children"];
        self.myDataSource = [[NSMutableArray alloc] initWithObjects:unassignedGroup, nil];
    }
}

// delete-key function for removing samples or groups
-(IBAction)delete:(id)sender
{
    NSInteger index = [self.myDataSource indexOfObject:[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]];
    
    if (index > self.myDataSource.count) {
        for (id item in self.myDataSource) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                NSInteger childIndex = [[item objectForKey:@"children"] indexOfObject:[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]];
                if (childIndex > [[item objectForKey:@"children"] count]) continue;
                else [[item objectForKey:@"children"] removeObject:[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]];
            }
        }
    } else if ([[[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow] objectForKey:@"groupName"] isEqualToString:@"Unassigned"]) {
        return;
    } else {
        [self.myDataSource removeObject:[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]];
    }
    
    
    [self.myOutlineView reloadData];
}

// create item whether it be a sample or group and update NSOutlineView
- (IBAction)createItem:(id)sender
{
    // if the text field is empty, don't do anything
    if ([self.itemName.stringValue length] == 0)
        return;
    
    // if unassignedGroup is null then instantiate it
    if (!self.unassignedGroup) {
        self.unassignedGroup = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    // if myDataSource is null then instantiate it, and add default group called Unassigned
    if (!self.myDataSource) {
        [self.unassignedGroup setObject:@"Unassigned" forKey:@"groupName"];
        [self.unassignedGroup setObject:[[NSMutableArray alloc] initWithCapacity:0] forKey:@"children"];
        self.myDataSource = [[NSMutableArray alloc] initWithObjects:unassignedGroup, nil];
    }
    
    // if the user want's to add group, check if the group name exists and if not add it
    if ([[self.itemType titleOfSelectedItem] isEqualTo:@"Group"]) {
        for (NSDictionary *currentGroups in self.myDataSource) {
            if ([[currentGroups objectForKey:@"groupName"] isEqualToString:self.itemName.stringValue]) return;
        }
        NSMutableDictionary *group = [[NSMutableDictionary alloc] initWithCapacity:0];
        [group setObject:self.itemName.stringValue forKey:@"groupName"];
        [group setObject:[[NSMutableArray alloc] initWithCapacity:0] forKey:@"children"];
        [self.myDataSource addObject:group];
    } else {
        for (NSDictionary *currentGroups in self.myDataSource) {
            if ([[currentGroups objectForKey:@"children"] indexOfObject:self.itemName.stringValue] <= [[currentGroups objectForKey:@"children"] count]) return;
        }
        // get selection in outline view... if none then add to root.
        if (![self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]) {
            [[self.unassignedGroup objectForKey:@"children"] addObject:self.itemName.stringValue];
        } else {
            // selected item is a group so add in group
            if ([[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow] isKindOfClass:[NSDictionary class]]) {
                [[[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow] objectForKey:@"children"] addObject:self.itemName.stringValue];
            } else {
                for (id item in self.myDataSource) {
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        NSInteger childIndex = [[item objectForKey:@"children"] indexOfObject:[self.myOutlineView itemAtRow:self.myOutlineView.selectedRow]];
                        if (childIndex > [[item objectForKey:@"children"] count]) continue;
                        else [[item objectForKey:@"children"] insertObject:self.itemName.stringValue atIndex:(childIndex+1)];
                    }
                }
            }
        }
    }
    
    [self.myOutlineView reloadData];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

// return YES if item is expandable, i.e. is a group in this example
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[NSDictionary class]]) {
        return YES;
    } else {
        return NO;
    }
}

// return the # of children, or rows for root.
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [self.myDataSource count];
    }
    
    return [[item objectForKey:@"children"] count];
}

// for each item return the object...if it's a child, then get the child object from NSDictionary and return that
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [self.myDataSource objectAtIndex:index];
    }
    
    return [[item objectForKey:@"children"] objectAtIndex:index];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if ([item isKindOfClass:[NSDictionary class]]) {
        cellView.textField.stringValue = [item objectForKey:@"groupName"];
    } else {
        cellView.textField.stringValue = item;
    }
    return cellView;
    
//        NSTextField *textField = [[NSTextField alloc] init];
//        [textField setStringValue: @"Test"];
//
//        return textField;

}

#pragma mark Drag & Drop

// check if the item is draggable and store in pasteboard
- (id<NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView pasteboardWriterForItem:(id)item
{
    // check if item is draggable kind...in this example, groups are not draggable
    if (![item isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSPasteboardItem *pboardItem = [[NSPasteboardItem alloc] init];
    [pboardItem setString:item forType:@"public.text"];
    
    return pboardItem;
}

// if the index is a valid # and the item is not null, allow drag operation
- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id<NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(NSInteger)index
{
    BOOL canDrag = index >= 0 && item;
    
    if (canDrag) {
        return NSDragOperationMove;
    } else {
        return NSDragOperationNone;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id<NSDraggingInfo>)info item:(id)item childIndex:(NSInteger)index
{
    NSPasteboard *pastboard = [info draggingPasteboard];
    NSString *identifier = [pastboard stringForType:@"public.text"];
    
    // remove object from source group
    for (NSMutableDictionary *sourceGroup in self.myDataSource) {
        NSInteger childIndex = [[sourceGroup objectForKey:@"children"] indexOfObject:identifier];
        if (childIndex > [[sourceGroup objectForKey:@"children"] count]) continue;
        else {
            [[sourceGroup objectForKey:@"children"] removeObjectAtIndex:childIndex];
            // if source and target group are the same, decrement the index counter as we already removed that item
            if ([sourceGroup isEqualTo:item]) index--;
        }
    }
    
    // insert object into target group group
    [[item objectForKey:@"children"] insertObject:identifier atIndex:index];
    
    [self.myOutlineView reloadData];
    
    return YES;
}

@end
