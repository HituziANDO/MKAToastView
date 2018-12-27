MKAToastView
===

***MKAToastView is the view that disappears automatically after displaying a short message for a few seconds like Android's Toast.***


## Include in your iOS app

### CocoaPods
TBA

### Manual Installation
TBA

## Usage

1. Import the module
	
	**Objective-C**
	
	```objc
	#import <MKAToastView/MKAToastView.h>
	```

	**Swift**
	
	```swift
	import MKAToastView
	```

1. Create and show the short message
	
	**Objective-C**
	
	```objc
	[MKAToast showInView:self.view
	         withMessage:@"Hello"
	            delegate:self
	        timeInterval:MKAToastShortTime];
	```
	
	**Swift**
	
	```swift
	MKAToast.show(in: self.view,
                  withMessage: "Hello",
                  delegate: self,
                  timeInterval: MKAToastShortTime)
	```
	
### Delegate

**Objective-C**

```objc
@interface ViewController () <MKAToastDelegate>

@end

@implementation ViewController

...

- (IBAction)helloButtonPressed:(id)sender {
    [MKAToast showInView:self.view
             withMessage:@"Hello"
                delegate:self
            timeInterval:MKAToastShortTime
              identifier:1];
}

...

#pragma mark - MKAToastDelegate

- (void)toastWillDisappear:(MKAToast *)toast {
    NSLog(@"Toast ID: %ld will disappear", (long) toast.identifier);
}

- (void)toastDidDisappear:(MKAToast *)toast {
    NSLog(@"Toast ID: %ld did disappear", (long) toast.identifier);
}

@end
```

**Swift**

```swift
class ViewController: UIViewController, MKAToastDelegate {
	
	...
	
	@IBAction func helloButtonPressed(_ sender: Any) {
        MKAToast.show(in: self.view,
                      withMessage: "Hello",
                      delegate: self,
                      timeInterval: MKAToastShortTime,
                      identifier: 1)
    }
    
    ...
    
    /// MARK: - MKAToastDelegate

    func toastWillDisappear(_ toast: MKAToast) {
        print("Toast ID: \(toast.identifier) will disappear");
    }

    func toastDidDisappear(_ toast: MKAToast) {
        print("Toast ID: \(toast.identifier) did disappear");
    }
}
```

More info, see my [sample project](https://github.com/HituziANDO/MKAToastView/tree/master/Sample).
