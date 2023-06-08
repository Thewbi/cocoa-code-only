//
//  DefaultController.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultController : NSObject

- (void)menuItemCallback:(id)sender;

- (void)buttonPressed:(NSButton *)sender;

- (void)sliderValueChanged:(NSSlider *)sender;

// Press Enter in the textfield to trigger this handler
- (void)textfieldValueChanged:(NSTextField *)sender;

@end

NS_ASSUME_NONNULL_END
