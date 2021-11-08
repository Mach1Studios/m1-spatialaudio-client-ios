#import <AVFoundation/AVFoundation.h>

#ifndef AudioTap_h
#define AudioTap_h

@interface AudioTap: NSObject

- (instancetype)init:(int)channel numberOfChannels:(int)numberOfChannels;
- (MTAudioProcessingTapCallbacks)callbacks;

@property(nonatomic, assign) float leftVolume;
@property(nonatomic, assign) float rightVolume;
@property(nonatomic, assign) int channel;
@property(nonatomic, assign) int numberOfChannels;

@end

#endif /* AudioTap_h */
