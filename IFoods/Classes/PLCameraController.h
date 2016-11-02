/*
#import <UIKit/UIKit.h>

@class AVCapture, PLPreviewView;

@interface PLCameraController : NSObject
{
    AVCapture *_avCapture;
    PLPreviewView *_previewView;
    BOOL _isPreviewing;
    BOOL _isLocked;
    int _cameraMode;
    int _captureOrientation;
    int _focusCount;
    int _autofocusCount;
    unsigned int _previousSimpleRemotePriority;
    id _delegate;
    GLfloat _startTime;
    struct {
        unsigned int supportsVideo:1;
        unsigned int supportsAccurateStillCapture:1;
        unsigned int supportsFocus:1;
        unsigned int capturingVideo:1;
        unsigned int deferStopPreview:1;
        unsigned int deferStartVideoCapture:1;
        unsigned int inCall:1;
        unsigned int continuousAutofocusDuringCapture:1;
        unsigned int focusDisabled:1;
        unsigned int focusedAtPoint:1;
        unsigned int wasInterrupted:1;
        unsigned int resumePreviewing:1;
        unsigned int isReady:1;
        unsigned int didSetPreviewLayer:1;
        unsigned int didNotifyCaptureEnded:1;
        unsigned int dontShowFocus:1;
        unsigned int isChangingMode:1;
        unsigned int lowResolutionCapture:1;
        unsigned int delegateModeDidChange:1;
        unsigned int delegateTookPicture:1;
        unsigned int delegateReadyStateChanged:1;
        unsigned int delegateVideoCaptureDidStart:1;
        unsigned int delegateVideoCaptureDidStop:1;
        unsigned int delegateVideoAdded:1;
        unsigned int delegateFocusFinished:1;
    } _cameraFlags;
}

+ (id)sharedInstance;
- (id)init;
- (void)dealloc;
- (void)_inCallStatusChanged:(BOOL)fp8;
- (BOOL)inCall;
- (void)_setIsReady;
- (BOOL)isReady;
- (BOOL)canCaptureVideo;
- (int)cameraMode;
- (void)_setCameraMode:(int)fp8 force:(BOOL)fp12;
- (void)setCameraMode:(int)fp8;
- (void)_applicationSuspended;
- (void)_applicationResumed;
- (void)_tookPicture:(struct CGImage *)fp8 jpegData:(struct __CFData *)fp12 imageProperties:(struct __CFDictionary *)fp16;
- (void)_tookPhoto:(id)fp8;
- (void)_previewStarted:(id)fp8;
- (void)_previewStopped:(id)fp8;
- (void)_setVideoPreviewLayer;
- (BOOL)_setupCamera;
- (void)viewDidAppear;
- (void)_tearDownCamera;
- (void)setDelegate:(id)fp8;
- (id)delegate;
- (id)previewView;
- (void)startPreview;
- (void)_destroyAVCapture;
- (void)stopPreview;
- (void)resumePreview;
- (BOOL)supportsAccurateStillCapture;
- (void)capturePhoto:(BOOL)fp8;
- (BOOL)isCapturingVideo;
- (void)_captureStarted:(id)fp8;
- (id)_createPreviewImage;
- (void *)_createPreviewIOSurface;
- (void)_captureCompleted:(id)fp8;
- (void)_didStopCapture;
- (void)_wasInterrupted:(id)fp8;
- (void)_interruptionEnded:(id)fp8;
- (BOOL)canStartVideoCapture;
- (BOOL)startVideoCaptureAtPath:(id)fp8;
- (void)_stopVideoCaptureAndPausePreview:(id)fp8;
- (void)stopVideoCaptureAndPausePreview:(BOOL)fp8;
- (id)videoCapturePath;
- (BOOL)focusAtPoint:(struct CGPoint)fp8;
- (void)restartAutoFocus;
- (void)autofocus;
- (void)lockFocus;
- (BOOL)isFocusing;
- (void)setDontShowFocus:(BOOL)fp8;
- (void)setFocusDisabled:(BOOL)fp8;
- (void)setCaptureAtFullResolution:(BOOL)fp8;
- (void)_commonFocusFinished;
- (void)_focusOperationFinished;
- (void)_autofocusOperationFinished;
- (void)_focusCompleted:(id)fp8;
- (void)_focusWasCancelled:(id)fp8;
- (void)_focusStarted:(id)fp8;
- (void)_focusHasChanged:(id)fp8;
- (int)videoCaptureOrientation;
- (void)irisWillClose;
- (void)_serverDied:(id)fp8;

@end


@interface camAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	PLCameraController *cameraController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
*/
#import <UIKit/UIKit.h>

@class AVCapture, PLPreviewView;

@protocol PLCameraControllerDelegate;

@interface PLCameraController : NSObject
{
    AVCapture *_avCapture;
    PLPreviewView *_previewView;
    BOOL _isPreviewing;
    BOOL _isLocked;
    int _cameraMode;
    int _captureOrientation;
    int _focusCount;
    int _autofocusCount;
    unsigned int _previousSimpleRemotePriority;
    id <PLCameraControllerDelegate> _delegate;
    GLfloat _startTime;
    struct {
        unsigned int supportsVideo:1;
        unsigned int supportsAccurateStillCapture:1;
        unsigned int supportsFocus:1;
        unsigned int capturingVideo:1;
        unsigned int deferStopPreview:1;
        unsigned int deferStartVideoCapture:1;
        unsigned int inCall:1;
        unsigned int continuousAutofocusDuringCapture:1;
        unsigned int focusDisabled:1;
        unsigned int focusedAtPoint:1;
        unsigned int wasInterrupted:1;
        unsigned int resumePreviewing:1;
        unsigned int isReady:1;
        unsigned int didSetPreviewLayer:1;
        unsigned int didNotifyCaptureEnded:1;
        unsigned int dontShowFocus:1;
        unsigned int isChangingMode:1;
        unsigned int lowResolutionCapture:1;
        unsigned int delegateModeDidChange:1;
        unsigned int delegateTookPicture:1;
        unsigned int delegateReadyStateChanged:1;
        unsigned int delegateVideoCaptureDidStart:1;
        unsigned int delegateVideoCaptureDidStop:1;
        unsigned int delegateVideoAdded:1;
        unsigned int delegateFocusFinished:1;
    } _cameraFlags;
}

+ (id)sharedInstance;
- (id)init;
- (void)dealloc;
- (void)_inCallStatusChanged:(BOOL)fp8;
- (BOOL)inCall;
- (void)_setIsReady;
- (BOOL)isReady;
- (BOOL)canCaptureVideo;
- (int)cameraMode;
- (void)_setCameraMode:(int)fp8 force:(BOOL)fp12;
- (void)setCameraMode:(int)fp8;
- (void)_applicationSuspended;
- (void)_applicationResumed;
- (void)_tookPicture:(struct CGImage *)fp8 jpegData:(struct __CFData *)fp12 imageProperties:(struct __CFDictionary *)fp16;
- (void)_tookPhoto:(id)fp8;
- (void)_previewStarted:(id)fp8;
- (void)_previewStopped:(id)fp8;
- (void)_setVideoPreviewLayer;
- (BOOL)_setupCamera;
- (void)viewDidAppear;
- (void)_tearDownCamera;
- (void)setDelegate:(id)fp8;
- (id)delegate;
- (id)previewView;
- (void)startPreview;
- (void)_destroyAVCapture;
- (void)stopPreview;
- (void)resumePreview;
- (BOOL)supportsAccurateStillCapture;
- (void)capturePhoto:(BOOL)fp8;
- (BOOL)isCapturingVideo;
- (void)_captureStarted:(id)fp8;
- (id)_createPreviewImage;
- (void *)_createPreviewIOSurface;
- (void)_captureCompleted:(id)fp8;
- (void)_didStopCapture;
- (void)_wasInterrupted:(id)fp8;
- (void)_interruptionEnded:(id)fp8;
- (BOOL)canStartVideoCapture;
- (BOOL)startVideoCaptureAtPath:(id)fp8;
- (void)_stopVideoCaptureAndPausePreview:(id)fp8;
- (void)stopVideoCaptureAndPausePreview:(BOOL)fp8;
- (id)videoCapturePath;
- (BOOL)focusAtPoint:(struct CGPoint)fp8;
- (void)restartAutoFocus;
- (void)autofocus;
- (void)lockFocus;
- (BOOL)isFocusing;
- (void)setDontShowFocus:(BOOL)fp8;
- (void)setFocusDisabled:(BOOL)fp8;
- (void)setCaptureAtFullResolution:(BOOL)fp8;
- (void)_commonFocusFinished;
- (void)_focusOperationFinished;
- (void)_autofocusOperationFinished;
- (void)_focusCompleted:(id)fp8;
- (void)_focusWasCancelled:(id)fp8;
- (void)_focusStarted:(id)fp8;
- (void)_focusHasChanged:(id)fp8;
- (int)videoCaptureOrientation;
- (void)irisWillClose;
- (void)_serverDied:(id)fp8;

@end


@interface camAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	PLCameraController *cameraController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end