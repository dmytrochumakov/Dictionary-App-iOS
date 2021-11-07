//
//  CDWordResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation

extension CDWordResponseEntity {
    
    var wordResponse: WordResponse {
        guard let wordText = self.wordText,
              let wordDescription = self.wordDescription,
              let languageName = self.languageName,
              let createdAt = self.createdAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     wordId: self.wordId,
                     courseId: self.courseId,
                     languageId: self.languageId,
                     wordText: wordText,
                     wordDescription: wordDescription,
                     languageName: languageName,
                     createdAt: createdAt)
    }
    
}
