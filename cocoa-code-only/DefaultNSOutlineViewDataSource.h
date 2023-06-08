//
//  DefaultNSOutlineViewDataSource.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

// <NSTableViewDelegate, NSTableViewDataSource>
//@interface DefaultNSOutlineViewDataSource : NSOutlineView <NSOutlineViewDataSource, NSOutlineViewDelegate> {
@interface DefaultNSOutlineViewDataSource : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate> {

//id data = [
//    ["FirstName": "Debasis", "LastName": "Das"],
//    ["FirstName": "Nishant", "LastName": "Singh"],
//    ["FirstName": "John", "LastName": "Doe"],
//    ["FirstName": "Jane", "LastName": "Doe"],
//    ["FirstName": "Mary", "LastName": "Jane"]
//];
    
    int        _age;
    
    NSArray *list;
}

//- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item;
//
//- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;
//
//- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item;
//
//- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;
//
//- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item API_AVAILABLE(macos(10.7));
//
//- (nullable NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item API_AVAILABLE(macos(10.7));
//
//- (void)outlineView:(NSOutlineView *)outlineView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7));
//
//- (void)outlineView:(NSOutlineView *)outlineView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row API_AVAILABLE(macos(10.7));
//
//- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item;
//
//- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item;
//
//- (BOOL)selectionShouldChangeInOutlineView:(NSOutlineView *)outlineView;

@end

NS_ASSUME_NONNULL_END
