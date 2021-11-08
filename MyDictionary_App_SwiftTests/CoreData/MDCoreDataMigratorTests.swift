//
//  MDCoreDataMigratorTests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

final class MDCoreDataMigratorTests: XCTestCase {
    
    var coreDataMigrator: MDCoreDataMigrator!
    
    override class func setUp() {
        super.setUp()
        
        FileManager.clearTempDirectoryContents()
    }
    
    override func setUp() {
        super.setUp()
        
        coreDataMigrator = MDCoreDataMigrator()
    }
    
    override func tearDown() {
        coreDataMigrator = nil
        
        super.tearDown()
    }
    
    func tearDownCoreDataStack(context: NSManagedObjectContext) {
        context.destroyStore()
    }
    
}

fileprivate extension FileManager {
    
    static func clearTempDirectoryContents() {
        let tmpDirectoryContents = try! FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
        tmpDirectoryContents.forEach {
            let fileURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent($0)
            try? FileManager.default.removeItem(atPath: fileURL.path)
        }
    }
    
    static func moveFileFromBundleToTempDirectory(filename: String) -> URL {
        let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: destinationURL)
        let bundleURL = Bundle(for: MDCoreDataMigratorTests.self).resourceURL!.appendingPathComponent(filename)
        try? FileManager.default.copyItem(at: bundleURL, to: destinationURL)
        
        return destinationURL
    }
    
}
