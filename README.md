RPDynamicWarningView
====================

Introduction
---------

A simple warning view that takes advantage of UIKit Dynamics. On this demo a warning is showed to the user, because we can't find his locaiton. With `RPDynamicWarningView` it would look like this:


<img src="https://raw.github.com/RuiAAPeres/RPDynamicWarningView/master/demo.gif">
          

Usage
---------

You can use the following method to initate your `RPDynamicWarningView`:

        - (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName;

If you want to remove it gracefully, for example when you aquire location, you can use the following method:

        - (void)stopDynamicLocationWithCompletionBlock:(void(^)(RPDynamicWarningView *dynamicLocationView))completionBlock;

The `completionBlock` will allow you to add specific logic when the animation is done (for example remove the view altogether) 
