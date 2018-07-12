MKAToastView
===

Android-like Toast view.

# Usage

```ObjC
#import "MKAToastView.h"

...

// Show.
[MKAToastView showInView:self.view withMessage:@"Hello World!" 
                delegate:nil timeInterval:MKAToastViewShortTime];

```

### Delegate

```ObjC
@interface ViewController () <MKAToastViewDelegate>

@end

@implementation ViewController

...

- (IBAction)showButtonClicked:(id)sender {
	// Show.
	[MKAToastView showInView:self.view 
	             withMessage:@"Hello World!" 
	                delegate:self 
	            timeInterval:MKAToastViewShortTime
	              identifier:1];
}

...

- (void)toastViewWillDisappear:(MKAToastView *)toastView {
	if (toastView.identifier == 1) {
		NSLog(@"%s", __func__);
	}
}

- (void)toastViewDidDisappear:(MKAToastView *)toastView {
	if (toastView.identifier == 1) {
		NSLog(@"%s", __func__);
	}
}

@end
```

# License
MIT License
