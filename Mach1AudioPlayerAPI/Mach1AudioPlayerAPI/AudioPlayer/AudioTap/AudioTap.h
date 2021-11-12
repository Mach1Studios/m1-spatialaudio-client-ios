#import <AVFoundation/AVFoundation.h>

#ifndef AudioTap_h
#define AudioTap_h

@interface AudioTap: NSObject

- (instancetype)init:(int)numberOfChannels;
- (MTAudioProcessingTapCallbacks)callbacks;

@property(nonatomic, assign) float one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, sqrtNumberChannels;
@property(nonatomic, assign) int numberOfChannels;

@end

#endif /* AudioTap_h */
