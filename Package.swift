// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SpaceMouse",
	platforms: [.macOS(.v11)],
	products: [
		.library(
			name: "SpaceMouse",
			targets: ["SpaceMouse"]),
	],
	targets: [
		.target(
			name: "SpaceMouse",
			publicHeadersPath: "include",
			cSettings: [
				.unsafeFlags([
					"-F", "/Library/Frameworks",
				])
			],
			linkerSettings: [
				.unsafeFlags([
					"-F", "/Library/Frameworks",
					"-weak_framework", "3DConnexionClient"])
			]
		),
	]
)
