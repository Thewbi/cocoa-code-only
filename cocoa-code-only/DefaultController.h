//
//  DefaultController.h
//  WindowTest2
//
//  Created by Wolfgang Bischoff on 21.05.23.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultController : NSObject {
 
    @public long editValue;
    
    // https://stackoverflow.com/questions/1643007/iboutlet-and-ibaction
    /*IBOutlet*/ //NSStepper * stepper;
    /*IBOutlet*/ //@public NSTextField * textField;
    
}

@property (assign) long editValue;
@property (nonatomic, weak) NSTextField *textField;
@property (nonatomic, weak) NSStepper *stepper;

- (void)menuItemCallback:(id)sender;

- (void)buttonPressed:(NSButton *)sender;

- (void)sliderValueChanged:(NSSlider *)sender;

// Press Enter in the textfield to trigger this handler
- (void)textfieldValueChanged:(NSTextField *)sender;

- (void)comboBoxSelectionDidChange:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
