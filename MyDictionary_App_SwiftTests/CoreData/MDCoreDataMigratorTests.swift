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
    
    func test_Individual_Step_Migration_From_1_To_2() {
        
        let sourceURL = FileManager.moveFileFromBundleToTempDirectory(filename: MDConstants.StaticText.appName + MDConstants.StaticText.dot + MDConstants.StaticText.sqliteExtension)
        
        let toVersion = MDCoreDataMigrationVersion.version2
        
        coreDataMigrator.migrateStore(at: sourceURL, toVersion: toVersion)
        
        XCTAssertTrue(FileManager.default.fileExists(atPath: sourceURL.path))
        
        let model = NSManagedObjectModel.managedObjectModel(forResource: toVersion.stringVersion)
        let context = NSManagedObjectContext(model: model, storeURL: sourceURL)
        let request = NSFetchRequest<Word>.init(entityName: CoreDataEntityName.word)
        let sort = NSSortDescriptor(key: WordAttributeName.uuid, ascending: false)
        request.sortDescriptors = [sort]
        
        let migratedWords = try? context.fetch(request)
        
        XCTAssertEqual(migratedWords?.count, 10)
        
        let firstMigratedWord = migratedWords?.first
        
        let migratedUUID = firstMigratedWord?.value(forKey: WordAttributeName.uuid) as? String
        let migratedWord = firstMigratedWord?.value(forKey: WordAttributeName.word) as? String
        let migratedTranslatedWord = firstMigratedWord?.value(forKey: WordAttributeName.translatedWord) as? String
        let migratedStringCreatedDate = firstMigratedWord?.value(forKey: WordAttributeName.stringCreatedDate) as? String
        
        XCTAssertEqual(migratedUUID, "HUY")
        XCTAssertEqual(migratedWord, "HUY")
        XCTAssertEqual(migratedTranslatedWord, "HUY")
        XCTAssertEqual(migratedStringCreatedDate, "HUY")
        
        tearDownCoreDataStack(context: context)
        
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
        let bundleURL = Bundle(for: CoreDataMigratorTests.self).resourceURL!.appendingPathComponent(filename)
        try? FileManager.default.copyItem(at: bundleURL, to: destinationURL)
        
        return destinationURL
    }
    
}
