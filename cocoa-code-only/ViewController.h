//
//  ViewController.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : NSViewController <NSOutlineViewDelegate, NSOutlineViewDataSource>

// https://github.com/kennethphough/outlineview_practice/blob/master/outlineview_practice/ViewController.h
@property (nonatomic, weak) IBOutlet NSOutlineView *myOutlineView;
@property (nonatomic, weak) IBOutlet NSPopUpButton *itemType;
@property (nonatomic, weak) IBOutlet NSTextField *itemName;

@property (nonatomic, strong) NSMutableArray *myDataSource;
@property (nonatomic, strong) NSMutableDictionary *unassignedGroup;

- (IBAction)createItem:(id)sender;
-(IBAction)delete:(id)sender;

@end

NS_ASSUME_NONNULL_END
