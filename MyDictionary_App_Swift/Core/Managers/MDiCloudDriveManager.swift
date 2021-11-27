//
//  MDiCloudDriveManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 27.11.2021.
//

import Foundation

struct ExportData {
    let courses: [CDCourseEntity]
    let words: [CDWordEntity]
}

// MARK: - Encodable
extension ExportData: Encodable {
    
    enum CodingKeys: CodingKey {
        case courses
        case words
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(courses, forKey: .courses)
        try container.encode(words, forKey: .words)
        
    }
    
}

enum MDiCloudDriveError: Error {
    case iCloudIsNotWorking
    case cannotFindLocalDocumentsPath
}

protocol MDiCloudDriveManagerProtocol {
    
    func exportFile(fromExportData exportData: ExportData) throws
    
}

final class MDiCloudDriveManager: MDiCloudDriveManagerProtocol {
    
    fileprivate let fileManager: FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
}

// MARK: - Public Methods
extension MDiCloudDriveManager {
    
    var iCloudDocumentsURL: URL? {
        return fileManager.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
    }
    
    func exportFile(fromExportData exportData: ExportData) throws {
        
        if (iCloudDocumentsURL == nil) {
            throw MDiCloudDriveError.iCloudIsNotWorking
        } else {
            
            // Check if iCloud directory exists
            if (!fileManager.fileExists(atPath: iCloudDocumentsURL!.path)) {
                
                // Create iCloud directory
                try fileManager.createDirectory(at: iCloudDocumentsURL!, withIntermediateDirectories: true, attributes: nil)
                
            }
            
            // Set up local directory
            guard let localDocumentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else { throw MDiCloudDriveError.cannotFindLocalDocumentsPath }
            
            // Add file to local folder
            let localFile = localDocumentsURL
                .appendingPathComponent(MDConstants.File.subDirectory)
                .appendingPathComponent(MDConstants.File.name)
                .appendingPathExtension(MDConstants.File.extension)
            
            // Check if local file exists
            if (fileManager.fileExists(atPath: localFile.path)) {
                
                // Remove local file
                try fileManager.removeItem(at: localFile)
                
                // Create local File
                fileManager.createFile(atPath: localFile.path, contents: exportData.data, attributes: nil)
                
            } else {
                
                // Create local File
                fileManager.createFile(atPath: localFile.path, contents: exportData.data, attributes: nil)
                
            }
            
            // If iCloud file exists -> remove it
            var isDirectory: ObjCBool = false
            
            if (fileManager.fileExists(atPath: iCloudDocumentsURL!.path, isDirectory: &isDirectory)) {
                
                // Remove iCloud file
                try fileManager.removeItem(at: iCloudDocumentsURL!)
                
            }
            
            // Copy from local to iCloud
            try fileManager.copyItem(at: localDocumentsURL, to: iCloudDocumentsURL!)
            
        }
        
    }
    
}
