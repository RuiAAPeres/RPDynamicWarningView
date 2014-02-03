RPDynamicWarningView
====================

Overview
---------

A simple warning view that takes advantage of UIKit Dynamic. This is inspired on the jumping icon that you would see on a Mac's dock, when the app wants to get your attention. (For example: open a project in Xcode and remove the physical project afterwards: your will see the Xcode icon jumping from the dock). 

On this demo a warning is showed, because we can't find the user's locaiton. With `RPDynamicWarningView` it would look like this:


<img src="https://raw.github.com/RuiAAPeres/RPDynamicWarningView/master/demo.gif">
          

You can use this project with any image and text you would like. The goal is to draw the user's attention to it, without blocking the UI (avoiding `UIAlertView`).

Usage
---------

You can use the following method to initate your `RPDynamicWarningView`:

```objective-c
- (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName;
```

If you want to remove it gracefully, for example when you acquire location, you can use the following method:

```objective-c
- (void)stopDynamicLocationWithCompletionBlock:(void(^)(RPDynamicWarningView *dynamicLocationView))completionBlock;
```

The `completionBlock` will allow you to add specific logic when the animation is done (for example remove the view altogether) 

Installing
---------
You can use by downloading the demo, or use cocoapods:

`pod 'RPDynamicWarningView', '~> 1.0'`

Credits
---------

[Henrique Macedo](https://twitter.com/henrikemacedo) is the designer who created the marker image and the overall UI Design for this particular view (notice the letter pressing, as well).
