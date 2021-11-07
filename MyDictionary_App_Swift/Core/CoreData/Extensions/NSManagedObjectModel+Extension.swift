//
//  NSManagedObjectModel+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import CoreData

extension NSManagedObjectModel {
    
    static func managedObjectModel(forResource resource: String) -> NSManagedObjectModel {
        let mainBundle = Bundle.main
        let subdirectory = MDConstants.StaticText.appName + MDConstants.StaticText.dot + MDConstants.StaticText.momdExtension
        let omoURL = mainBundle.url(forResource: resource, withExtension: MDConstants.StaticText.omoExtension, subdirectory: subdirectory) // optimised model file
        let momURL = mainBundle.url(forResource: resource, withExtension: MDConstants.StaticText.momExtension, subdirectory: subdirectory)
        
        guard let url = omoURL ?? momURL else {
            fatalError("unable to find model in bundle")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("unable to load model in bundle")
        }
        
        return model
    }
    
}
