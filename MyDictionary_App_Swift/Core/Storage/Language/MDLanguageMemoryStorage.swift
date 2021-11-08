//
//  MDLanguageMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.11.2021.
//

import Foundation

protocol MDLanguageMemoryStorageProtocol {
    func readLanguage(byLanguageId languageId: Int16) -> MDOperationResultWithoutCompletion<MDLanguageModel>
    func readAllLanguages() -> [MDLanguageModel]
}

final class MDLanguageMemoryStorage: MDLanguageMemoryStorageProtocol {
    
    fileprivate let languages: [MDLanguageModel]
    
    init(languages: [MDLanguageModel]) {
        self.languages = languages
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Read
extension MDLanguageMemoryStorage {
    
    func readLanguage(byLanguageId languageId: Int16) -> MDOperationResultWithoutCompletion<MDLanguageModel> {
        guard let language = languages.first(where: { $0.id == languageId }) else { return .failure(MDMemoryLanguageStorageError.languageWithThisIDDoesNotExist) }
        return .success(language)
    }
    
    func readAllLanguages() -> [MDLanguageModel] {
        return self.languages
    }
    
}

// MARK: - Read All Languages From JSON
extension MDLanguageMemoryStorage {
    
    static func readAllLanguagesFromJSON() -> [MDLanguageModel] {
        do {
            guard let bundlePath = Bundle.main.path(forResource: "ListOfLanguages", ofType: "json") else { fatalError(MDMemoryLanguageStorageError.invalidPath.localizedDescription) }
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
            return try JSONDecoder.init().decode([MDLanguageModel].self, from: jsonData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
