//
//  DBPreferencesController.h
//  BeaconBeam
//
//  Created by kumagai on 2014/04/05.
//  Copyright (c) 2014年 kumagai. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DBPreferencesController : NSWindowController<NSWindowDelegate, NSTextFieldDelegate>

#pragma mark - Outlet Properties

@property (weak) IBOutlet NSTextField *uuidTextField;
@property (weak) IBOutlet NSTextField *majorTextField;
@property (weak) IBOutlet NSTextField *minorTextField;
@property (weak) IBOutlet NSTextField *powerTextField;

#pragma mark - Global Constant

extern NSString *const kDBPreferenceBeaconKey;
extern NSString *const kDBPreferenceUUIDKey;
extern NSString *const kDBPreferenceMajorKey;
extern NSString *const kDBPreferenceMinorKey;
extern NSString *const kDBPreferenceMesuredPowerKey;

extern NSString *const kDBPreferenceUUID ;
extern const NSInteger kDBPreferenceMajor;
extern const NSInteger kDBPreferenceMinor;
extern const NSInteger kDBPreferenceMesuredPower;

@end
