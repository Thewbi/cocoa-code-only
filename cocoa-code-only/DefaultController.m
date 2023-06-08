////
////  DefaultController.m
////  WindowTest2
////
////  Created by Wolfgang Bischoff on 21.05.23.
////
//
//#import "DefaultController.h"
//
//@implementation DefaultController
//
//-(void)buttonPressed:(NSButton *)sender {
//    NSLog(@"[DefaultController] Button pressed! Button: '%@'", sender.identifier);
//    
//    // For Strings you use %@
//    // For int  you use %i
//    // For float you use %f
//    // For double you use %lf
//}
//
//-(void)sliderValueChanged:(NSSlider *)sender {
//    
//    // https://stackoverflow.com/questions/3919905/subclassing-nsslider-need-a-workaround-for-missing-mouse-up-events-cocoa-osx
//    NSEvent *event = [[NSApplication sharedApplication] currentEvent];
//    BOOL startingDrag = event.type == NSEventTypeLeftMouseDown;
//    BOOL endingDrag = event.type == NSEventTypeLeftMouseUp;
//    BOOL dragging = event.type == NSEventTypeLeftMouseDragged;
//    
//    NSAssert(startingDrag || endingDrag || dragging, @"unexpected event type caused slider change: %@", event);
//    
//    if (startingDrag) {
//        //NSLog(@"slider value started changing");
//        // do whatever needs to be done when the slider starts changing
//    }
//    
//    // do whatever needs to be done for "uncommitted" changes
//    //NSLog(@"slider value: %f", [sender doubleValue]);
//    
//    if (endingDrag) {
//        //NSLog(@"slider value stopped changing");
//        // do whatever needs to be done when the slider stops changing
//        
//        double sliderValue = sender.doubleValue;
//        NSLog(@"[DefaultController] Slider value changed! Slider: '%@' sliderValue: %lf", sender.identifier, sliderValue);
//    }
//}
//
//-(void)textfieldValueChanged:(NSTextField *)sender {
//    
//    NSString* value = sender.stringValue;
//    NSLog(@"[DefaultController] Textfield value changed! Slider: '%@' value: %@", sender.identifier, value);
//}
//
//@end
