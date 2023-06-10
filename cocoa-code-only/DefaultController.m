//
//  DefaultController.m
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import "DefaultController.h"

@implementation DefaultController

// https://stackoverflow.com/questions/702829/integrate-nsstepper-with-nstextfield
- (IBAction) controlDidChange: (id) sender
{
    NSLog(@"[DefaultController] controlDidChange()");
    
    [self setEditValue:[sender integerValue]];
    [self updateControls];
}

// https://stackoverflow.com/questions/702829/integrate-nsstepper-with-nstextfield
- (void) updateControls
{
    NSLog(@"[DefaultController] updateControls()");
    NSLog(@"[DefaultController] controlDidChange() editValue: %i", self->_editValue);
    
    self->_stepper.integerValue = self->_editValue;
    self->_textField.integerValue = self->_editValue;
}




- (void)menuItemCallback:(id)sender {
    NSLog(@"[DefaultController] menuItemCallback()! sender: '%@'", sender);
}

- (void)buttonPressed:(NSButton *)sender {
    NSLog(@"[DefaultController] Button pressed! Button: '%@'", sender.identifier);
    
    // For Strings you use %@
    // For int you use %i
    // For float you use %f
    // For double you use %lf
    
    if (sender.identifier == @"button_9") {
        NSLog(@"[DefaultController] Button button_9 detected");
        
        NSPopUpButton *popUpButton = (NSButton *)sender;
        if (popUpButton.pullsDown) {
            
            // Unlike popup lists, the title of a popup button displaying a
            // pulldown list is not based on the currently selected item and
            // thus remains fixed unless you change using the cell’s setTitle:method.
            
            // if the button is set to pulldown, then set the title manually
            // otherwise it wont change!
            id title = popUpButton.selectedItem.title;
            [popUpButton.cell setTitle: title];
        }
    }
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
        NSLog(@"[DefaultController] Slider value changed! Slider: '%@' sliderValue: %lf", sender.identifier, sliderValue);
    }
}

- (void)textfieldValueChanged:(NSTextField *)sender {
    
    NSString* value = sender.stringValue;
    NSLog(@"[DefaultController] Textfield value changed! Slider: '%@' value: %@", sender.identifier, value);
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    NSComboBox *comboBox = (NSComboBox *)[notification object];
    
    //NSLog(@"[comboBox stringValue] : %@", [salaryBy stringValue] );
    
    NSString *strValue = [comboBox itemObjectValueAtIndex:[comboBox indexOfSelectedItem]];
    
    NSLog(@"[comboBox stringValue]: %@", strValue);
    
    
}

//- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
//
//    NSLog(@"[AppDelegate] byItem() - column identifier: %@", tableColumn.identifier);
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
//    return item;
//}
//
///* View Based OutlineView: See the delegate method -tableView:viewForTableColumn:row: in NSTableView.
// */
//- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item API_AVAILABLE(macos(10.7)) {
//
//    NSLog(@"[AppDelegate] viewForTableColumn() column name: %@, width: %f", tableColumn.identifier, tableColumn.width);
//
//    NSTextField *textField = [[NSTextField alloc] init];
//    [textField setStringValue: @"Test"];
//
//    return textField;
//}
//
///* View Based OutlineView: See the delegate method -tableView:rowViewForRow: in NSTableView.
// */
// - (nullable NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item API_AVAILABLE(macos(10.7)) {
// NSLog(@"[DefaultNSOutlineViewDataSource] rowViewForItem()");
//
// return nil;
// }
//
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
