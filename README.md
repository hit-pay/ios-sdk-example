# HitPay iOS SDK (Point-Of-Sale Only)

[![CI Status](https://img.shields.io/travis/tuannguyenanh177/HitPay-iOS-SDK.svg?style=flat)](https://travis-ci.org/tuannguyenanh177/HitPay-iOS-SDK)
[![Version](https://img.shields.io/cocoapods/v/HitPay-iOS-SDK.svg?style=flat)](https://cocoapods.org/pods/HitPay-iOS-SDK)
[![License](https://img.shields.io/cocoapods/l/HitPay-iOS-SDK.svg?style=flat)](https://cocoapods.org/pods/HitPay-iOS-SDK)
[![Platform](https://img.shields.io/cocoapods/p/HitPay-iOS-SDK.svg?style=flat)](https://cocoapods.org/pods/HitPay-iOS-SDK)

## About the SDK

This iOS SDK is specifically designed for Point-of-Sales apps that wish to integrate Card Reader and Paynow transactions into their application.

NOTE: If you are looking for online payment acceptance please refer to these REST API [docs](https://hit-pay.com/docs.html)

## Example App
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Functionality

- **Authentication** Allow your merchant to log in to their hitpay account.
- **Connect Card Reader** Allow your merchant to connect their card reader to start accepting card payments
- **Accept Card Payment** Allow your merchant to initiate a payment using the connected card reader
- **Accept PayNow** Allow your merchant to initiate a payment using the PayNow QR code
- **Refund Transaction** Allow merchant to perform a full refund on any transactions


## Installation

HitPay-iOS-SDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HitPay-iOS-SDK'
```

### Set Environment

```swift
// AppDelegate.swift
HitPay.shared.setEnv(isProd: false)
```

### Authentication

```swift
HitPay.shared.initiateAuthentication(from: self) { [weak self] in
  // Authentication done
}

// Sign out
HitPay.shared.signOut()
```

### **Connect Card Reader**

```swift
// Enable to disable terminal simulation.
HitPay.shared.setTerminal(simulated: false)

HitPay.shared.initiateTerminalSetup(from: self) { [weak self] in
	// Setup completed
}

```

### Accept Card Payment

```swift
HitPay.shared.makeTerminalPayment(amount: amount, currency: "sgd") { success, error in
  if success {
    // Successful payment
  } else {
    // Faied. Check for error
  }
}

// Cancel current terminal payment
HitPay.shared.cancelTerminalPayment { success, error in
  if success {
    // Successful cancel payment
  } else {
    // Faied. Check for error
  }
}
```

### Accept PayNow QR

```swift
HitPay.shared.makePayNowPayment(amount: amount, currency: "sgd", generateImage: true) { qrCode, qrImage, success, error in
  // "qrCode" represents the string value of the QRCode to be displayed.
  // "qrImage" represents UIImage of the QRCode if generateImage set to true
}
```

### Refund Transaction

```swift
HitPay.shared.refundCharge(charge_id: charge_id) { success, error in
  // Full refund done for the given charge id
}
```


## Contact
Support: support@hit-pay.com

Author: tuannguyenanh177@gmail.com

## License

HitPay-iOS-SDK is available under the MIT license. See the LICENSE file for more info.
