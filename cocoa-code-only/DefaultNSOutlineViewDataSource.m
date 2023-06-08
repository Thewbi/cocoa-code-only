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

    // https://stackoverflow.com/questions/6664898/nsoutlineview-example/9387255#9387255
    NSDictionary *firstParent = @{@"parent": @"Foo", @"children": @[@"Foox", @"Fooz", @"Fooz", @"Fooz", @"Fooz", @"Fooz", @"Fooz"]};
    NSDictionary *secondParent = @{@"parent": @"Bar", @"children": @[@"Barx", @"Barz", @"Barz", @"Barz", @"Barz", @"Barz", @"Barz", @"Barz"]};

- (id)init {
    NSLog(@"[DefaultNSOutlineViewDataSource] init()");
    
    self = [super init];
    if (self) {
        list = @[firstParent, secondParent];
    }
    return self;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return false;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    
    NSLog(@"[DefaultNSOutlineViewDataSource] child()ofItem()");

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
    
    if ([item isKindOfClass:[NSDictionary class]]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    NSLog(@"[DefaultNSOutlineViewDataSource] numberOfChildrenOfItem()");

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

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
