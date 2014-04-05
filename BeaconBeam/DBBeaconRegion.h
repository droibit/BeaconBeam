//
//  DBBeaconRegion.h
//  BeaconBeam
//
//  Created by kumagai on 2014/04/05.
//  Copyright (c) 2014年 kumagai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBBeaconRegion : NSObject

#pragma - Public Properties

@property (nonatomic, readonly) NSUUID *proximityUUID;
@property (assign, nonatomic) uint16_t major;
@property (assign, nonatomic) uint16_t minor;
@property (assign, nonatomic) int8_t measuredPower;

#pragma - Public Methods

- (id)initWithProximityUUID:(NSUUID *)proximityUUID
                      major:(uint16_t)major
                      minor:(uint16_t)minor
              measuredPower:(int8_t)power;

- (NSDictionary *)peripheralData;

@end
