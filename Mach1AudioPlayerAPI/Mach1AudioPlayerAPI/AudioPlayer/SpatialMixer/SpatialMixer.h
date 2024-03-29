#import <AVFoundation/AVFoundation.h>

#ifndef AudioTap_h
#define AudioTap_h

@interface SpatialMixer: NSObject

- (instancetype)init:(int)numberOfChannels;
- (MTAudioProcessingTapCallbacks)callbacks;

@property(nonatomic, assign) float sqrtNumberChannels;
@property(nonatomic, assign) int numberOfChannels;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *spatialMixerCoeffs;

@end

#endif /* AudioTap_h */
