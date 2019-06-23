# EthereumSignerApp

A simple app to sign text messages with Ethereum private key and to verify them.


## Development
- Swift 4.2
- XCode 10
- Min iOS Deployment Target 10.0

## Features
- The app allows a user to enter Ethereum private key, and to display the account balance on the Rinkeby network.

- It also allows a user to sign any message with the user’s private key
- It also allows a user to check if a provided signature with the initial message is something that a user signed before by scanning QRCode.

**Note: Run project on an iOS Device to use scanning functionality.**

## Technical Notes

### Architecture
The app is follows architectural pattern MVVM along with Service layer.

The app has built-in QRCode component which can be reused into other project. The component provides feature of generating & scanning QRCodes.

### Code Coverage
- Test cases for all ViewModels
- Test cases for Service Layer


### Third Party Libraries Used
- [web3swift](https://github.com/BANKEX/web3swift.git) (For Interacting with Rinkeby network and signing messages)

## Versioning

Version 1.0
For more information on versioning, see [Semantic Versioning](http://semver.org/).
