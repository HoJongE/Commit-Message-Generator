//
//  PersistenceController.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import Foundation
import CoreData
import SwiftUI


struct PersistenceController {
    
    static let shared : PersistenceController = PersistenceController()
    
    let container : NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context : NSManagedObjectContext = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    
    func delete(_ object: NSManagedObject,completion: @escaping (Error?) -> () = {_ in} ) {
        container.viewContext.delete(object)
        save(completion: completion)
    }
}


extension PersistenceController {
    func deleteAllData() {
        guard let url = self.container.persistentStoreDescriptions.first?.url else { return }
    
        let persistentStoreCoordinator = self.container.persistentStoreCoordinator

            do {
                try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            } catch {
                print("Attempted to clear persistent store: ".appending(error.localizedDescription))
            }
    }
    
    func reset() {
        
        deleteAllData()
        
        let context = PersistenceController.shared.container.viewContext
        
        let name = ["Feat","Fix","Design","!BREAKING CHANGE","!HOTFIX","Style","Refactor","Comment","Docs","Test","Chore","Rename","Remove"]
        let description = ["새로운 기능을 추가","버그를 고친 경우","사용자 UI 디자인 변경","커다란 API의 변경","급하게 치명적인 버그를 고쳐야하는 경우","코드 포맷 변경, 세미 클론 누락 (오타 수정, 탭 사이즈 변경, 변수명 변경","프로덕션 코드 리팩토링","필요한 주석 추가 및 변경","문서 수정","테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X)","빌드 테스트 업데이트, 패키지 매니저를 설정","파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우","파일을 삭제하는 작업만 수행한 경우"]
        let colorHex = ["#3563EB","#2B4BE9","#8B44C1","#B03320","#51F1F5","#4AB455","#777777","#948534","123456","#999999","#987654","#991133","#661293"]
        
        for i in 0..<name.count {
            let tag = Tag(context: context)
            tag.colorHex = colorHex[i]
            tag.name = name[i]
            tag.tagDescription = description[i]
            tag.category = "태그"
        }
        
        let function = ["Add","Fix","Change"]

        for i in 0..<function.count {
            let tag = Tag(context: context)
            tag.colorHex = colorHex[i]
            tag.name = function[i]
            tag.category = "기능"
        }
        
        PersistenceController.shared.save()
    }
}
