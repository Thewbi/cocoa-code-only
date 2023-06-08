//
//  DefaultNSOutlineViewDataSource.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultNSOutlineViewDataSource : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate> {
    
    NSArray *list;
    
}

@end

NS_ASSUME_NONNULL_END
