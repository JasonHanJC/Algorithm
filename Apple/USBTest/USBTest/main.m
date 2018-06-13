//
//  main.m
//  USBTest
//
//  Created by Juncheng Han on 2/28/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <CoreFoundation/CoreFoundation.h>

#include <IOKit/IOKitLib.h>
#include <IOKit/IOMessage.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>

//#define USE_ASYNC_IO    //Comment this line out if you want to use
////synchronous calls for reads and writes
//#define kTestMessage        "Bulk I/O Test"
//#define k8051_USBCS         0x7f92
//#define kOurVendorID        1351    //Vendor ID of the USB device
//#define kOurProductID           8193    //Product ID of device BEFORE it
////is programmed (raw device)
//#define kOurProductIDBulkTest   4098    //Product ID of device AFTER it is
////programmed (bulk test device)

typedef struct {
    io_service_t service;
    io_object_t notification;
} MyDriverData;

// Notification for usb plugged in or remove
IONotificationPortRef notificationPort = NULL;

void DeviceNotification(void* refCon, io_service_t service, natural_t messageType, void *messageArgument) {
    MyDriverData * myDriverData = (MyDriverData *)refCon;
    kern_return_t kr;
    
    // only handle driver termination notifications
    if (messageType == kIOMessageServiceIsTerminated) {
        io_name_t name;
        IORegistryEntryGetName(service, name);
        
        printf("Device removed: %s\n", name);
        
        // remove the driver state change notification
        kr = IOObjectRelease(myDriverData->notification);
        // remove the driver device object
        kr = IOObjectRelease(myDriverData->service);
        
        // release structure
        free(myDriverData);
    }
}

void DeviceAdded(void * refCon, io_iterator_t iter) {
    
    io_service_t device = 0;
    /* iterate */
    while ((device = IOIteratorNext(iter)))
    {
        io_name_t       deviceName;
        CFStringRef     className;
        MyDriverData *myDriverData;
        kern_return_t kr;
        
        
        className = IOObjectCopyClass(device);
        
        if (CFEqual(className, CFSTR(kIOUSBDeviceClassName))) {
            // get usb device name
            kr = IORegistryEntryGetName(device, deviceName);
            if (kr != KERN_SUCCESS) {
                deviceName[0] = '\0';
            }
        }
        
        // Dump our data to stderr just to see what it looks like.
        fprintf(stderr, "Device added: %s\n", deviceName);
        
        CFRelease(className);
        
        // allocate driver data
        myDriverData = (MyDriverData *)malloc(sizeof(MyDriverData));
        
        myDriverData->service = device;
        
        // install a callback to receive notification of driver state changes.
        kr = IOServiceAddInterestNotification(notificationPort, device, kIOGeneralInterest, DeviceNotification, myDriverData, &myDriverData->notification);
    
        
        // IOObjectRelease(device);
    }
    
}

int main(int argc, const char * argv[]) {
    
    // CFMutableDictionaryRef and CFDictionaryRef are pointers to __CFDictionary
    CFDictionaryRef matchingDict = NULL;
    io_iterator_t iter = 0;
    kern_return_t kr;
    
    
    // notification need runloop
    CFRunLoopSourceRef runLoopSource;
    

    /* set up a matching dictionary for every usb class */
    matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
    if (matchingDict == NULL)
    {
        return -1; // fail
    }
    
    // init notification port
    notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
    runLoopSource = IONotificationPortGetRunLoopSource(notificationPort);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopDefaultMode);
    
    kr = IOServiceAddMatchingNotification(notificationPort, kIOFirstMatchNotification, matchingDict, DeviceAdded, NULL, &iter);
    
    // Iterate once to get already-present devices and arm the notification
    DeviceAdded(NULL, iter);
    
    // Start the run loop. Now we'll receive notifications.
    fprintf(stderr, "Starting run loop.\n\n");
    CFRunLoopRun();
    
    IONotificationPortDestroy(notificationPort);
    
    
//    /* Now we have a dictionary, get an iterator.*/
//    // this function will release the matchingDict, so you don't need to use CFRelease
//    kr = IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &iter);
//    if (kr != KERN_SUCCESS)
//    {
//        return -1;
//    }
    

    
    /* Done, release the iterator */
    // if need updating the adding and removal, don't release the iter.
//    IOObjectRelease(iter);
    return 0;
}





