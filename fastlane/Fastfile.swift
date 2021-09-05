// Fastfile.swift
// Copyright (c) 2021 Tim Oliver
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

class Fastfile: LaneFile {
    
    func unitTestLane() {
        desc("Runs the unit tests to ensure the build is working")
        // Run the unit tests
        runTests()
    }
    
    /// Runs a lane to performs a basic build of the app and then runs all of the unit tests
    func testLane() {
        desc("Build a signed copy of this app, and then run its unit tests")
        
        // Install any needed CocoaPods dependencies
        cocoapods(cleanInstall: true, useBundleExec: true)
        
        // Make a temporary keychain to store our signing credentials
        setUpKeychain()
        
        // Install the Apple signing identity from GitHub secrets
        installSigningIdentity()
        
        // Run the unit tests
        runTests()
    }
    
}

extension Fastfile {
    
    /// Create a temporary keychain to store the signing credentials
    func setUpKeychain() {
        // Delete the keychain if it already exists
        let keychainURL = FileManager.default
            .homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Keychains/\(keychainName)-db")
        if FileManager.default.fileExists(atPath: keychainURL.path) {
            deleteKeychain(name: .userDefined(keychainName))
        }
        
        // Create the new keychain
        createKeychain(name: .userDefined(keychainName),
                       password: environmentVariable(get: "MATCH_KEYCHAIN_PASSWORD"),
                       defaultKeychain: true,
                       unlock: true,
                       timeout: 600, // 10 minutes
                       lockAfterTimeout: false,
                       requireCreate: true)
    }
    
    /// Extract the signing identity from GitHub secrets and install it in our keychain
    func installSigningIdentity() {
        // Decode the signing cert from GitHub secrets
        let certificateString = environmentVariable(get: "SIGNING_CERT")
        guard let data = Data(base64Encoded: certificateString, options: .ignoreUnknownCharacters),
              data.count > 0 else {
            fatalError("Was unable to decode signing certificate")
        }
        
        // Save the decoded certificate to disk
        let certificateURL = URL(fileURLWithPath: "Certificate.p12")
        do { try data.write(to: certificateURL) }
        catch { fatalError("Unable to save signing identity to disk") }
        
        // Import into the keychain
        importCertificate(certificatePath: "Certificate.p12",
                          certificatePassword: .userDefined(environmentVariable(get: "SIGNING_CERT_PASSWORD")),
                          keychainName: "\(keychainName)-db",
                          keychainPassword: .userDefined(environmentVariable(get: "MATCH_KEYCHAIN_PASSWORD")))
    }
    
}
