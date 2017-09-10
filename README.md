
# react-native-class-exists

Works currently with:

| iOS | Android | Windows |
| --- | ------- | ------- |
| Yes |    No   |   No    |

#### Why would I use this?
The situation may arise where you want to incorporate 'new features' that may not run on all your users devices. For instance, a user with iOS 9 will not be able to use SiriKit, whereas a user with iOS 10 will. You can check at run time whether a class exists using this module. You can also use this module to check for device capabilities. For instance, being able to check if a user's device supports ARKit (even if they have iOS 11+, their hardware may not support it).

## Getting started

`$ npm install react-native-class-exists --save`

### Mostly automatic installation

`$ react-native link react-native-class-exists`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-class-exists` and add `RNClassExists.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNClassExists.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNClassExistsPackage;` to the imports at the top of the file
  - Add `new RNClassExistsPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-class-exists'
  	project(':react-native-class-exists').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-class-exists/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-class-exists')
  	```

## Static Functions:
| function | arguments           | notes |
| -------- | --------------------| ----- |
| exists() | className, callback | If you just want to check if a certain class exists at runtime, this is how you do it. |
| classMethodResponse() | className, methodName, responseType, callback | Sometimes you want to be able to do more than just check if a class exists at runtime. Sometimes you need to call a class method and get a return value. This is how you do it. As of now, we only wrote the code to allow you to call static class methods with no arguments. Look below for a list of supported return types |

| Supported Return Types for classMethodResponse (ObjC types) | Javascript form returned |
| ----------------------------------------------------------- | ------------------------ |
| BOOL | Boolean |
| NSNumber | Number |
| int | Number |
| float | Number |
| double | Number |
| NSString or String | String |
Remember to include the correct returnType for the method you will be calling




## Usage Examples
#### Checking if UIAlertController works (introduced in iOS 8)
```javascript
import React, { Component } from 'react'
import { Platform } from 'react-native'
import ClassExists from 'react-native-class-exists'

export default class App extends React.Component {
    componentDidMount() {
      if (Platform.OS == 'ios') {
        ClassExists.exists("UIAlertController", exists=>{
            console.log(exists ? "It exists! " : "Does not exist")
        })
      }
    }
}
```

#### Checking if the user can make payments (checking for the class isn't enough. So we can check for the class, AND run a method if it exists, as well as get a return value)
```javascript
if (Platform.OS == 'ios') {
  ClassExists.classMethodResponse("SKPaymentQueue", "canMakePayments", "BOOL", (success, response)=>{
    if (success && response) {
      console.log("User can make payments")
    } else {
      console.log("User cannot make payments")
    }
  })
}
```

#### Checking if the user's device will run ARKit (Augmented Reality Kit from iOS 11+)
```javascript
if (Platform.OS == 'ios') {
  ClassExists.classMethodResponse("ARConfiguration", "isSupported", "BOOL", (success, response)=>{
    if (success) {
      if (response) {
        console.log("User can use ARKit")
      } else {
        console.log("User has software for ARKit, but device doesn't support it. (Probably iOS 11+, but not on a newer device)")
      }
    } else {
      console.log("User cannot use ARKit")
    }
  })
}
```
