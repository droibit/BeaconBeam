//
//  DBBeaconRegion.m
//  BeaconBeam
//
//  Created by kumagai on 2014/04/05.
//  Copyright (c) 2014年 kumagai. All rights reserved.
//

#import "DBBeaconRegion.h"

static NSString *const kDBperipheralDataKey = @"kCBAdvDataAppleBeaconKey";
static const NSInteger kDBBeaconRegionBytesLength = 21;

@implementation DBBeaconRegion

- (id)initWithProximityUUID:(NSUUID *)proximityUUID
                      major:(uint16_t)major
                      minor:(uint16_t)minor
              measuredPower:(int8_t)power
{
    self = [super init];
    if (self) {
        _proximityUUID = proximityUUID;
        _major = major;
        _minor = minor;
        _measuredPower = power;
    }
    return self;
}

- (NSDictionary *)peripheralData
{
    unsigned char advertisementInBytes[kDBBeaconRegionBytesLength] = {0};
    
    [self.proximityUUID getUUIDBytes:(unsigned char *)&advertisementInBytes];
    
    advertisementInBytes[16] = (unsigned char)(self.major >> 8);
    advertisementInBytes[17] = (unsigned char)(self.major & 255);
    
    advertisementInBytes[18] = (unsigned char)(self.minor >> 8);
    advertisementInBytes[19] = (unsigned char)(self.minor & 255);
    
    advertisementInBytes[20] = self.measuredPower;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementInBytes
                                                         length:kDBBeaconRegionBytesLength];
    
    return [NSDictionary dictionaryWithObject:advertisement
                                       forKey:kDBperipheralDataKey];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"UUID: %@\nMajor: %d, Minor: %d\nMesured Power: %c",
                self.proximityUUID.UUIDString, self.major, self.minor, self.measuredPower];
}

@end
