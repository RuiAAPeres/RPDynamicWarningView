RPDynamicWarningView
====================

Introduction
---------

A simple warning view that takes advantage of UIKit Dynamics. On this demo a warning is showed to the user, because we can't find his locaiton. With `RPDynamicWarningView` it would look like this:


<img src="https://raw.github.com/RuiAAPeres/RPDynamicWarningView/master/demo.gif">
          

Usage
---------

You can use the following method to initate your `RPDynamicWarningView`:

```objective-c
- (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName;
```

If you want to remove it gracefully, for example when you aquire location, you can use the following method:

```objective-c
- (void)stopDynamicLocationWithCompletionBlock:(void(^)(RPDynamicWarningView *dynamicLocationView))completionBlock;
```

The `completionBlock` will allow you to add specific logic when the animation is done (for example remove the view altogether) 

Credits
---------

[Henrique Macedo](https://twitter.com/henrikemacedo) is the designer who created the marker image and the overall UI Design for this particular view (notice the letter pressing, as well).