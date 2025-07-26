//
// © 2024-present https://github.com/cengiz-pz
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include "core/config/project_settings.h"

#import "share_plugin_implementation.h"
#import "active_view_controller.h"

String const DATA_KEY_TITLE = "title";
String const DATA_KEY_SUBJECT = "subject";
String const DATA_KEY_CONTENT = "content";
String const DATA_KEY_FILE_PATH = "file_path";
String const DATA_KEY_MIME_TYPE = "mime_type";

String const MIME_TYPE_TEXT = "text/plain";
String const MIME_TYPE_IMAGE = "image/*";

String const SIGNAL_NAME_SHARE_COMPLETED = "share_completed";


void SharePlugin::_bind_methods() {
	ClassDB::bind_method(D_METHOD("share"), &SharePlugin::share);

	ADD_SIGNAL(MethodInfo(SIGNAL_NAME_SHARE_COMPLETED));
}

Error SharePlugin::share(const Dictionary &sharedData) {
	NSLog(@"SharePlugin::share");

	UIViewController *viewController = [ActiveViewController getActiveViewController];
	if (!viewController) {
		NSLog(@"No active view controller found");
		return OK;
	}

	// Items to share
	NSString *textToShare = toNsString(sharedData[DATA_KEY_CONTENT]);

	UIImage *imageToShare;
	NSURL *fileURL;

	if (sharedData.has(DATA_KEY_FILE_PATH) && sharedData.has(DATA_KEY_MIME_TYPE)) {
		NSString *mimeType = toNsString(sharedData[DATA_KEY_MIME_TYPE]);
		if ([mimeType isEqualToString:toNsString(MIME_TYPE_IMAGE)]) {
			imageToShare = [UIImage imageWithContentsOfFile: toNsString(sharedData[DATA_KEY_FILE_PATH])];
		}
		else {
			fileURL = [NSURL fileURLWithPath: toNsString(sharedData[DATA_KEY_FILE_PATH])];
		}
	}
	
	// Array of items to share
	NSMutableArray *itemsToShare = [NSMutableArray array];
	
	// Add text
	if (textToShare) {
		[itemsToShare addObject:textToShare];
	}
	
	// Add image
	if (imageToShare) {
		[itemsToShare addObject:imageToShare];
	}
	
	// Add file
	if (fileURL) {
		[itemsToShare addObject:fileURL];
	}

	// Check if there are items to share
	if (itemsToShare.count == 0) {
		NSLog(@"No items to share");
		return OK;
	}

	// Initialize UIActivityViewController
	UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
	
	// Exclude specific activity types (all available in iOS 14.3)
	activityVC.excludedActivityTypes = @[
		UIActivityTypePrint,
		UIActivityTypeAssignToContact,
		UIActivityTypeAddToReadingList,
		UIActivityTypeMarkupAsPDF
	];
	
	// For iPad: Configure popover presentation
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		activityVC.popoverPresentationController.sourceView = viewController.view;
		activityVC.popoverPresentationController.sourceRect = CGRectMake(viewController.view.bounds.size.width / 2.0, viewController.view.bounds.size.height / 2.0, 1.0, 1.0);
	}
	
	// Present the share sheet on the main thread
	dispatch_async(dispatch_get_main_queue(), ^{
		[viewController presentViewController:activityVC animated:YES completion:nil];
	});
	
	// Handle completion (optional)
	activityVC.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
		if (completed) {
			NSLog(@"Share completed via %@", activityType);
		} else {
			NSLog(@"Share cancelled or failed with error: %@", activityError.localizedDescription);
		}
	};

	return OK;
}

NSString* SharePlugin::toNsString(const String &godotString) {
	return [NSString stringWithUTF8String: godotString.utf8().get_data()];
}

SharePlugin::SharePlugin() {
	NSLog(@"SharePlugin constructor");
}

SharePlugin::~SharePlugin() {
	NSLog(@"SharePlugin destructor");
}
