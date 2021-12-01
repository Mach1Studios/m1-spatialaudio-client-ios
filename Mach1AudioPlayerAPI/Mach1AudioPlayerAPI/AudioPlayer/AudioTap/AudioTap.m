#import "AudioTap.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation AudioTap

@synthesize sqrtNumberChannels;
@synthesize numberOfChannels;
@synthesize spatialMixerCoeffs;

- (instancetype) init:(int)numberOfChannels {
    self = [super init];
    if (self) {
        self.sqrtNumberChannels = sqrtf(numberOfChannels);
        self.numberOfChannels = numberOfChannels;
        self.spatialMixerCoeffs = [[NSMutableArray<NSNumber *> alloc] init];
        for (int i = 0; i < numberOfChannels * 2 + 2; i++) {
            [self.spatialMixerCoeffs addObject: @1.0];
        }
    }
    return self;
}

- (MTAudioProcessingTapCallbacks)callbacks {
    MTAudioProcessingTapCallbacks callbacks;
    callbacks.version = kMTAudioProcessingTapCallbacksVersion_0;
    callbacks.clientInfo = (__bridge void *)(self);
    callbacks.init = init;
    callbacks.prepare = prepare;
    callbacks.process = process;
    callbacks.unprepare = unprepare;
    callbacks.finalize = finalize;
    return callbacks;
}

void init(MTAudioProcessingTapRef tap, void *clientInfo, void **tapStorageOut) {
    *tapStorageOut = clientInfo;
}

void finalize(MTAudioProcessingTapRef tap) {}

void prepare(MTAudioProcessingTapRef tap, CMItemCount maxFrames, const AudioStreamBasicDescription *processingFormat) {}

void unprepare(MTAudioProcessingTapRef tap) {}

void process(MTAudioProcessingTapRef tap,
             CMItemCount numberFrames,
             MTAudioProcessingTapFlags flags,
             AudioBufferList *bufferListInOut,
             CMItemCount *numberFramesOut,
             MTAudioProcessingTapFlags *flagsOut) {
    OSStatus status;
    status = MTAudioProcessingTapGetSourceAudio(tap, numberFrames, bufferListInOut, flagsOut, NULL, numberFramesOut);
    AudioTap *context = (__bridge AudioTap *)MTAudioProcessingTapGetStorage(tap);
    for (int j=0; j<*numberFramesOut; j++) {
        float leftGeometricMean = 0;
        float rightGeometricMean = 0;
        for (int i = 0; i < context.numberOfChannels; i++) {
            float *channel = (float*)bufferListInOut->mBuffers[i].mData;
            leftGeometricMean += channel[j] * context.spatialMixerCoeffs[i * 2].floatValue;
            rightGeometricMean += channel[j] * context.spatialMixerCoeffs[i * 2 + 1].floatValue;
        }
        leftGeometricMean = (leftGeometricMean / context.sqrtNumberChannels) * context.spatialMixerCoeffs[context.numberOfChannels * 2].floatValue;
        rightGeometricMean = (rightGeometricMean / context.sqrtNumberChannels) * context.spatialMixerCoeffs[context.numberOfChannels * 2 + 1].floatValue;
        for (int i = 2; i < context.numberOfChannels; i++) {
            float *thirdChannelOnwards = (float*)bufferListInOut->mBuffers[i].mData;
            thirdChannelOnwards[j] = 0;
        }
        float *leftOut = (float*)bufferListInOut->mBuffers[0].mData;
        float *rightOut = (float*)bufferListInOut->mBuffers[1].mData;
        leftOut[j] = leftGeometricMean;
        rightOut[j] = rightGeometricMean;
      }
}

@end
