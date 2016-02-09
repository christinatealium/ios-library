Tealium iOS Library - 4.1.11 & 4.1.11c
====================================

**********************
![](../../wiki/images/warning_30.png) This library has been replaced by version 5.x [iOS](https://github.com/tealium/tealium-ios) and [tvOS](https://github.com/tealium/tealium-tvos) repositories. This version can still be used with Tealium services but no further development or bug fixes planned.
**********************

###Brief###
The frameworks included allow the native tagging of a mobile application once and then configuration of third-party analytic services remotely through [Tealium IQ](http://tealium.com/products/enterprise-tag-management/); all without needing to recode and redeploy an app for every update to these services.

First time implementations should read the [How Tealium Works](../../wiki/how-tealium-works) wiki page for a brief overview of how Tealium's SDK differs from conventional analytic SDKs. For any additional information, consult the [wiki home page](../../wiki/home).

The remainder of this document provides quick install instructions for implementing the less memory intensive Compact library.

###Table of Contents###

- [Requirements](#requirements)
- [Quick Start](#quick-start)
    - [1. Clone/Copy Library](#1-clonecopy-library)
    - [2. Add to Project](#2-add-to-project)
    - [3. Link Frameworks](#3-link-frameworks)
    - [4. Add Linker Flags](#4-add-linker-flags)
    - [5o. Import and Init - Objective-C](#5o-import-and-init-objective-c)
    - [5s. Import and Init - Swift](#5s-import-and-init-swift)
    - [6. Compile and Run](#6-compile-and-run)
    - [7. Dispatch Verification](#7-dispatch-verification)
- [What Next](#what-next)
- [Contact Us](#contact-us)

###Requirements###

- [XCode (6.0+ recommended)](https://developer.apple.com/xcode/downloads/)
- Minimum target iOS Version 5.1.1+

###Quick Start###
This guide presumes you have already created an [iOS app using XCode](https://developer.apple.com/library/iOS/referencelibrary/GettingStarted/RoadMapiOS/index.html).  Follow the below steps to add [Tealium's Compact library](../../wiki/compact-vs-full#compact) to it. Discussion on which version is ultimately best for you can be found in the [What Next](#what-next) section.

####1. Clone/Copy Library####
onto your dev machine by clicking on the *Clone to Desktop* or *Download ZIP* buttons on the main repo page.

![](../../wiki/images/iOS_GithubClone.png)

####2. Add To Project 

2a. From the *ios-library/TealiumCompact* folder, drag & drop the *TealiumLibrary.framework*(/tealiumcompact/tealiumlibrary.framework) into your XCode project's Navigation window.

![](../../wiki/images/iOS_DragDrop.png)

2b. Click "Finish" in the resulting dialog box.

![](../../wiki/images/iOS_XCodeCopyLinkBox.png)

####3. Link Frameworks
[Link the following Apple frameworks](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/AddingaLibrarytoaTarget.html) to your project:

- SystemConfiguration
- CoreTelephony (optional)

Your project-target-General tab should now look similar to:

![](../../wiki/images/iOSc_XCodeProjectGeneral.png)

####4. Add Linker Flags
Add the "-ObjC" linker flag to your project's Target-Build Settings:

![](../../wiki/images/iOS_LinkerFlags.png)


####5o. Import and Init Objective-C
5o1. Import the library into your project's .pch file into the following block:

```objective-c
#ifdef __OBJC__
    //...

    #import <TealiumLibrary/Tealium.h>
#endif
```

5o2. Init the library in your appDelegate.m class:
```objective-c
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    //...

    [Tealium initSharedInstance:@"tealiummobile" profile:@"demo" target:@"dev"];
    
    // (!) Don't forget to replace "tealiummobile", "demo" and "dev" with your own account-profile-target settings before creating your production build.

}
```

####5s. Import and Init Swift
5s1. Import Tealium-bridging-header.h

![](../../wiki/images/swift_bridging_header.png)

5s2. Update Project’s Build Settings: Swift Compiler - Code Generation:
- Install objective-C Header: Yes
- Objective-C Bridging Header: (path to the bridging-header)

![](../../wiki/images/swift_compiler_code.png)

5s3. Add Init statement: 

```swift
Tealium.initSharedInstance("tealiummobile", profile: "demo", target: "dev", options:TealiumOptions.TLNone, globalCustomData: nil)
```

![](../../wiki/images/swift_init.png)


####6. Compile and Run
Your app is now ready to compile and run.  In the console output you should see a variation of:

```
2015-05-28 10:06:21.078 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Init settings: {
    AccountInfo =     {
        Account = tealiummobile;
        Profile = demo;
        Target = dev;
    };
    Settings =     {
        AdditionalCustomData =         {
        };
        ExcludeClasses =         (
        );
        LogVerbosity = 1;
        UseExceptionTracking = 1;
        UseHTTPS = 1;
    };
}
2015-05-28 10:06:21.083 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Initializing...
2015-05-28 10:06:22.294 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Adding new command: _push
2015-05-28 10:06:22.294 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Adding new command: _http
2015-05-28 10:06:22.305 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: App Launch detected.
2015-05-28 10:06:22.360 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Queued auto link dispatch for TealiumLifecycle : launch : 2015-05-28T10:06:22. 1 dispatch queued.
2015-05-28 10:06:22.469 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Network is available.
2015-05-28 10:06:22.624 UICatalog_TealiumCompactLibrary[1208:1724372] TEALIUM 4.1.8c: Connection established with mobile.html at https://tags.tiqcdn.com/utag/tealiummobile/demo/dev/mobile.html?platform=iOS&os_version=8.3&library_version=4.1.8c&timestamp_unix=1432832782.
2015-05-28 10:06:23.938 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: UTAG found in mobile.html: true
2015-05-28 10:06:23.939 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Initialized.
2015-05-28 10:06:24.028 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: UIAutotracking:             ON (ignoring)
2015-05-28 10:06:24.029 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: IVar Tracking:              ON (ignoring)
2015-05-28 10:06:24.029 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Batch limit:                1
2015-05-28 10:06:24.029 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Wifi sending only:          OFF
2015-05-28 10:06:24.030 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Battery save feature:       ON
2015-05-28 10:06:24.030 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Offline dispatch cache:     -1
2015-05-28 10:06:24.030 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Queued dispatch expiration: -1
2015-05-28 10:06:24.031 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Mobile Companion:           ON (ignoring)
2015-05-28 10:06:24.031 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Sending 1 queued dispatch.
2015-05-28 10:06:24.075 UICatalog_TealiumCompactLibrary[1208:1724453] TEALIUM 4.1.8c: Successfully packaged auto link dispatch for TealiumLifecycle : launch : 2015-05-28T10:06:22
2015-05-28 10:06:24.339 UICatalog_TealiumCompactLibrary[1208:1724479] TEALIUM 4.1.8c: Finished running dispatch queue with 0 remaining dispatches.
2015-05-28 10:06:24.626 UICatalog_TealiumCompactLibrary[1208:1724482] TEALIUM 4.1.8c: Registering device for remote push notifications...
```

Congratulations! You have successfully implemented the Tealium Compact library into your project.  

If you have disabled internet connectivity to test offline caching, you will see a variation of:
```
2015-05-28 10:08:12.519 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Init settings: {
    AccountInfo =     {
        Account = tealiummobile;
        Profile = demo;
        Target = dev;
    };
    Settings =     {
        AdditionalCustomData =         {
        };
        ExcludeClasses =         (
        );
        LogVerbosity = 1;
        UseExceptionTracking = 1;
        UseHTTPS = 1;
    };
}
2015-05-28 10:08:12.522 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Initializing...
2015-05-28 10:08:12.785 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Adding new command: _push
2015-05-28 10:08:12.785 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Adding new command: _http
2015-05-28 10:08:12.794 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Network is not available.
2015-05-28 10:08:12.795 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: App Launch detected.
2015-05-28 10:08:12.851 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Queued auto link dispatch for TealiumLifecycle : launch : 2015-05-28T10:08:12. 1 dispatch queued.
2015-05-28 10:08:12.885 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: NO INTERNET connection detected.
2015-05-28 10:08:12.885 UICatalog_TealiumCompactLibrary[1214:1725071] TEALIUM 4.1.8c: Trying to reconnect (attempt 1 of 3)...
2015-05-28 10:08:13.959 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: NO INTERNET connection detected.
2015-05-28 10:08:13.960 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Trying to reconnect (attempt 2 of 3)...
2015-05-28 10:08:14.975 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: NO INTERNET connection detected.
2015-05-28 10:08:14.976 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Trying to reconnect (attempt 3 of 3)...
2015-05-28 10:08:15.991 UICatalog_TealiumCompactLibrary[1214:1725067] TEALIUM 4.1.8c: NO INTERNET connection detected.
2015-05-28 10:08:15.992 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Saved configuration loaded: true
2015-05-28 10:08:15.992 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: No new configuration data found from mobile.html. Library will continue running with last saved configuration.
2015-05-28 10:08:15.993 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: UIAutotracking:             ON (ignoring)
2015-05-28 10:08:15.993 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: IVar Tracking:              ON (ignoring)
2015-05-28 10:08:15.993 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Batch limit:                1
2015-05-28 10:08:15.994 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Wifi sending only:          OFF
2015-05-28 10:08:15.994 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Battery save feature:       ON
2015-05-28 10:08:15.996 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Offline dispatch cache:     -1
2015-05-28 10:08:15.996 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Queued dispatch expiration: -1
2015-05-28 10:08:15.997 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Mobile Companion:           ON (ignoring)
2015-05-28 10:08:15.997 UICatalog_TealiumCompactLibrary[1214:1725072] TEALIUM 4.1.8c: Initialized.
```

####6. Dispatch Verification
The two recommended methods for dispatch verification are:

- AudienceStream Live Events
- Vendor Dashboard

AudienceStream live events provides real time visualization of dispatched data if the Tealium DataCloud Tag has been added the same TIQ account-profile used to init the library:

![](../../wiki/images/EventStore.png)

An analytic vendor with real time processing, such as [Google Analytics](http://www.google.com/analytics/)), can also be used to verify dispatches if the data sources have been properly mapped to the target vendors' variables. 

Note: vendors without real-time processing may take up to several hours to update their reporting.


### What Next###
Now that you've successfully integrated the library, you should now determine if the [Compact or Full Library versions](../../wiki/compact-vs-full) best fit your needs. Below are the key differences:


|                                                                       | Compact | Full |
|-----------------------------------------------------------------------|:-------:|:-------:|
| Library Compile Size                                                  | ~600 KB | ~900 KB |
| Initialization Time                                                    | +<1 ms | +<1 ms |
| Runtime Memory Usage                                                  | +3.3 MB |+5.0 MB |
| [Custom Data Tracking](../../wiki/features#custom-data-tracking)          | Yes | Yes |
| [Device Data Tracking](../../wiki/features#device-data-tracking)          | Yes | Yes |
| [Lifecycle Tracking](../../wiki/features#lifecycle-tracking)              | Yes | Yes |
| [Offline Tracking](../../wiki/features#offline-tracking)                  | Yes | Yes |
| [Tag Bridge](../../wiki/advanced-guide#tag-bridge)                        | Yes | Yes |
| [Timestamp Tracking](../../wiki/features#timestamp-tracking)              | Yes | Yes |
| [AudienceStream Trace](../../wiki/advanced-guide#audiencestream-trace)    | No  | Yes |
| [Mobile Companion](../../wiki/advanced-guide#mobile-companion-full-only)  | No  | Yes |
| [UI Autotracking](../../wiki/features#optional-ui-tracking)               | No  | Yes |
| [Video Tracking](../../wiki/features#video-event-tracking)                | No  | Yes |
 

(A) Continue with the Compact version, add any needed [additional tracking calls](../../wiki/API-4.x#trackcalltypecustomdataobject) for events or view appearances.

(B) Switch to the Full version, see our [Basic Implementation Guide](../../wiki/basic-guide), paying attention to the additional setup requirements.

Still can't decide? Browse through our [wiki pages](../../wiki/home) for more info, or read a few mobile related posts in the [TealiumIQ Community](https://community.tealiumiq.com/series/3333) (consult your Tealium Account Manager for access).

###Contact Us###

Questions or comments?

- Post code questions in the [issues page.](../../issues)
- Contact your Tealium account manager

**********************
### UPGRADE NOTICE ###

####New Features
- 4.1.3 URL requests use NSURLSession for targets using iOS 7 and above
- 4.1.1 Remove custom data APIs added
- 4.1   [Tag Bridge API](../../wiki/features#tag-bridge-api) added
- 4.1   Swift Bridging Header provided
- 4.0   Remote configuration options found in TIQ's new mobile publish settings now supported
- 3.3.1 iOS 8.0+ support added
- 3.3   Autotracking [Class Exclusion](../../wiki/advanced-guide#exclude-classes-from-tracking) support added
- 3.2   Self thread managing added - library calls can safely be made from any thread.
- 3.2   [Audience Stream Trace](../../wiki/advanced-guide#audiencestream-trace) support added
- 3.1   [Class Level Methods](../../wiki/api-4.x#class-methods) replaced older shared instance calls
- 3.1   Import header renamed to ``<TealiumLibrary/Tealium.h>``
 
####Recent Code Updates
- 4.1.11 Tag Bridge remote command now always send a response
- 4.1.11 Added malloc NULL protection to machine name lookup
- 4.1.10 Re-enabled interface orientation datasource
- 4.1.10 Reduced re-try timer for adding remote commands via the [add remote command method](../../wiki/api-4.x#addremotecommandiddescriptiontargetqueueblock)
- 4.1.9 Improved exception handling in unarchiving serialized crash logs
- 4.1.8 Fixed potential symbol conflicts with reachability constants
- 4.1.7 Fixed small memory leak in network reachability manager
- 4.1.7 UIDevice information access now threadsafe
- 4.1.6 Fixed issues preventing crash track calls from processing
- 4.1.6 Dispatch queue processing/batching refactored, fixed recursion edge cases 
- 4.1.5 Custom data for object now returns a proper dictionary in the Compact Library
- 4.1.5 Improved dispatch processing speed and reduced memory pressure
- 4.1.4 Fixed crash in mobile publish settings parsing
- 4.1.3 Duplicate suppression fixed
- 4.1.3 Datasource updates
- 4.1.3 Autotracked view debug logging fixed
- 4.1.2 Exclude classes fix
- 4.1.1 Strict data source lowercasing removed
- 4.1.1 Queuing & dispatch system updates
- 4.1.1 Lifecycle data reporting fixes
- 4.1.1 Minor TagBridge compatibility fixes
- 4.1   Direct custom data accesses replaced with thread-safe [read and write methods](../../wiki/API-4.x#addcustomdatatoobject)
- 4.1   Dispatch data key lowercasing now strictly enforced
- 4.0.6 Armv7s slice reintroduced, improved Mobile Companion unlock, log outputs, thread handling and low-memory handling 
- 4.0.5 Improved configuration via TIQ & header documentation
- 4.0.4 Stability enchancements
- 4.0.2 & 4.0.3 iOS 8.1 Support and additional performance optimizations
- 4.0.1 Fixed bug in autotracking performance optimizations, disable & enable call fixes, manual track calls firing as expected with event call type overrides

####Known bugs this version
- Call_eventtype: exception (crash) calls are reported as autotracked:false - should be true

**********************


--------------------------------------------

Copyright (C) 2012-2015, Tealium Inc.
