//
// © 2024-present https://github.com/cengiz-pz
//

#import "active_view_controller.h"

@implementation ActiveViewController : NSObject

+ (UIViewController*) getActiveViewController {
	UIWindow *keyWindow = nil;
	for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
		if (scene.activationState == UISceneActivationStateForegroundActive) {
			for (UIWindow *window in scene.windows) {
				if (window.isKeyWindow) {
					keyWindow = window;
					break;
				}
			}
		}
	}
	
	if (!keyWindow) {
		keyWindow = UIApplication.sharedApplication.windows.firstObject;
	}
	
	UIViewController *activeVC = keyWindow.rootViewController;
	while (activeVC.presentedViewController) {
		activeVC = activeVC.presentedViewController;
	}
	
	if ([activeVC isKindOfClass:[UINavigationController class]]) {
		activeVC = [(UINavigationController *)activeVC topViewController];
	} else if ([activeVC isKindOfClass:[UITabBarController class]]) {
		activeVC = [(UITabBarController *)activeVC selectedViewController];
		if ([activeVC isKindOfClass:[UINavigationController class]]) {
			activeVC = [(UINavigationController *)activeVC topViewController];
		}
	}
	
	return activeVC;
}

@end