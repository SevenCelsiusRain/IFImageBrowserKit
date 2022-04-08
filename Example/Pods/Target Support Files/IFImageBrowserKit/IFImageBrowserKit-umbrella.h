#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IFIBAuxiliaryViewHandler.h"
#import "IFIBLoadingView.h"
#import "IFIBToastView.h"
#import "IFIBAnimatedTransition.h"
#import "IFIBCollectionView.h"
#import "IFIBCollectionViewLayout.h"
#import "IFIBContainerView.h"
#import "IFIBDataMediator.h"
#import "IFIBScreenRotationHandler.h"
#import "IFImageBrowser+Internal.h"
#import "NSObject+IFImageBrowser.h"
#import "IFIBCopywriter.h"
#import "IFIBIconManager.h"
#import "IFIBPhotoAlbumManager.h"
#import "IFIBSentinel.h"
#import "IFIBUtilities.h"
#import "IFImageBrowser.h"
#import "IFIBImageCache+Internal.h"
#import "IFIBImageCache.h"
#import "IFIBImageCell+Internal.h"
#import "IFIBImageCell.h"
#import "IFIBImageData+Internal.h"
#import "IFIBImageData.h"
#import "IFIBImageLayout.h"
#import "IFIBImageScrollView.h"
#import "IFIBInteractionProfile.h"
#import "IFImage.h"
#import "YYAnimatedImageView+IFSwizzle.h"
#import "IFIBCellProtocol.h"
#import "IFIBDataProtocol.h"
#import "IFIBGetBaseInfoProtocol.h"
#import "IFIBOperateBrowserProtocol.h"
#import "IFIBOrientationReceiveProtocol.h"
#import "IFImageBrowserDataSource.h"
#import "IFImageBrowserDelegate.h"
#import "IFIBSheetView.h"
#import "IFIBToolViewHandler.h"
#import "IFIBTopView.h"
#import "IFIBDefaultWebImageMediator.h"
#import "IFIBWebImageMediator.h"

FOUNDATION_EXPORT double IFImageBrowserKitVersionNumber;
FOUNDATION_EXPORT const unsigned char IFImageBrowserKitVersionString[];

