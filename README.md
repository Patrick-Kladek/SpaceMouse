# SpaceMouse
A Swift Package for interacting with a 3Dconnexion Space Mouse

## Motivation

I was struggling to use the SpaceMouse SDK in a Swift Application. I've got it working in objc and decided to create a Swift Package, so it can be easily used in Swift.

## Prerequisites

You need to have the 3Dconnexion drivers installed in its default location `/Library/Frameworks/3DconnexionClient.framework`.
You might also need to disable App Sandbox & Hardend Runtime.

## Usage

In your AppDelegate connect the mouse

```swift
SpaceMouse.sharedInstance.delegate = self
SpaceMouse.sharedInstance.connect()
```

And implement the delegate

```swift
// MARK: - SpaceMouseDelegate

extension AppDelegate: SpaceMouseDelegate {
	func spaceMouse(_ mouse: SpaceMouse, didReceive event: MotionEvent) {
		print("mouse: \(mouse.clientID) event: \(event)")
	}
}
```

This will print all motion events to the console:

```
mouse: 57007 event:    0    0    0 /    0    0    0
mouse: 57007 event:   -2    0  -25 /    0    0    0
mouse: 57007 event:   -2    0  -39 /    0    0    0
mouse: 57007 event:   -8    0  -54 /    0    0    0
mouse: 57007 event:  -13    0  -51 /    0    0    0
mouse: 57007 event:  -14    0  -42 /    0    0    0
mouse: 57007 event:  -14    0  -27 /    0    0    0
mouse: 57007 event:  -13    0  -12 /    0    0    0
mouse: 57007 event:   -6    0    0 /    0    0    0
mouse: 57007 event:    0    0    0 /    0    0    0
```
