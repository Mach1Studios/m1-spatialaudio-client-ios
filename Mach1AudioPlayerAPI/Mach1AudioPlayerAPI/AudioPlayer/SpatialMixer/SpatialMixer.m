#import "SpatialMixer.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation SpatialMixer

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
    
    SpatialMixer *context = (__bridge SpatialMixer *)MTAudioProcessingTapGetStorage(tap);

    // Setting up a temporary ad-hoc motion filter until `mach1Decode.setFilterSpeed()` is abstracted for objective-c
    // TODO: Remove this motion filter after objective-c includes are prepared
    float filteredCoeffs[36];
    for (int i = 0; i < context.numberOfChannels; i++) {
        filteredCoeffs[i * 2] = context.spatialMixerCoeffs[context.numberOfChannels * 2].floatValue;
        filteredCoeffs[i * 2 + 1] = context.spatialMixerCoeffs[context.numberOfChannels * 2 + 1].floatValue;
    }
    
    for (int j=0; j<*numberFramesOut; j++) {
        float outputMeanLeft = 0;
        float outputMeanRight = 0;
        
        // Updating an ad-hoc motion filter
        for (int i = 0; i < context.numberOfChannels; i++) {
            filteredCoeffs[i * 2] = 0.99 * filteredCoeffs[i * 2] + 0.01 * context.spatialMixerCoeffs[context.numberOfChannels * 2].floatValue;
            filteredCoeffs[i * 2 + 1] = 0.99 * filteredCoeffs[i * 2 + 1] + 0.01 * context.spatialMixerCoeffs[context.numberOfChannels * 2 + 1].floatValue;
        }
        
        // Mixes spatial audio buffers into a single stereo output audio stream
        for (int i = 0; i < context.numberOfChannels; i++) {
            float *channel = (float*)bufferListInOut->mBuffers[i].mData;
            outputMeanLeft += channel[j] * filteredCoeffs[i * 2];
            outputMeanRight += channel[j] * filteredCoeffs[i * 2 + 1];
        }
        
        // Applies an additional gain padding
        //TODO: check output gain and maybe remove additional gain reduction division above
        outputMeanLeft = (outputMeanLeft / context.sqrtNumberChannels);
        outputMeanRight = (outputMeanRight / context.sqrtNumberChannels);
        
        // Clears the audio streams multichannel data
        for (int i = 2; i < context.numberOfChannels; i++) {
            float *thirdChannelOnwards = (float*)bufferListInOut->mBuffers[i].mData;
            thirdChannelOnwards[j] = 0;
        }
        
        float *leftOut = (float*)bufferListInOut->mBuffers[0].mData;
        float *rightOut = (float*)bufferListInOut->mBuffers[1].mData;
        leftOut[j] = outputMeanLeft;
        rightOut[j] = outputMeanRight;
        
      }
}

@end
