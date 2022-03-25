//
//  TagRepository.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/14.
//

import Foundation
import CoreData
import Combine
// MARK: - Tag Repository 프로토콜
protocol TagStore {
    func tags(category: String?) -> AnyPublisher<Loadable<[Tag]>, Never>
    func deleteTag(_ tag: Tag)
    func modifyTag(change tag: Tag, withName name: String?, withColor colorHex: String?, withDescription tagDescription: String?)
    func addTag(name: String, colorHex: String, tagDescription: String, category: String)
    func removeAll()
    func count(category: String?) -> Int?
    func reset()
}
// MARK: - Tag Repository 인스턴스
final class DefaultTagRepository {
    static let shared: DefaultTagRepository = DefaultTagRepository()
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
}
// MARK: - 프로토콜 구현부
extension DefaultTagRepository: TagStore {
    
    func tags(category: String? = nil) -> AnyPublisher<Loadable<[Tag]>, Never> {
        let fetchRequest = Tag.fetchRequest()
        if let category = category {
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let context: NSManagedObjectContext = coreDataStack.viewContext
        let fetch = Future<Loadable<[Tag]>, Never> { promise in
            context.performAndWait {
                do {
                    let managedObjects = try context.fetch(fetchRequest)
                    promise(.success(Loadable.success(data: managedObjects)))
                } catch {
                    promise(.success(Loadable.error(error: error)))
                }
            }
        }
        return fetch
            .eraseToAnyPublisher()
    }
    
    func deleteTag(_ tag: Tag) {
        let context: NSManagedObjectContext = coreDataStack.viewContext
        context.delete(tag)
        save()
    }
    
    func modifyTag(change tag: Tag, withName name: String?, withColor colorHex: String?, withDescription tagDescription: String?) {
        if let name = name {
            tag.name = name
        }
        if let colorHex = colorHex {
            tag.colorHex = colorHex
        }
        if let tagDescription = tagDescription {
            tag.tagDescription = tagDescription
        }
        save()
    }
    
    func addTag(name: String, colorHex: String, tagDescription: String, category: String) {
        let context: NSManagedObjectContext = coreDataStack.viewContext
        let tag: Tag = Tag(context: context)
        
        tag.name = name
        tag.colorHex = colorHex
        tag.tagDescription = tagDescription
        tag.category = category
        context.performAndWait {
            save()
        }
    }
    
    func removeAll() {
        let context = coreDataStack.taskContext()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Tag.fetchRequest())
        
        do {
            try context.execute(deleteRequest)
            save()
        } catch {
            print("removeAll tags error: \(error)")
        }
    }
    
    func count(category: String?) -> Int? {
        let context = coreDataStack.viewContext
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print("count of Tag error: \(error)")
            return nil
        }
    }
    
    func reset() {
        let context = coreDataStack.viewContext
        removeAll()
        let name = ["Feat", "Fix", "Design", "!BREAKING CHANGE", "!HOTFIX", "Style", "Refactor", "Comment", "Docs", "Test", "Chore", "Rename", "Remove"]
        let description = ["새로운 기능을 추가", "버그를 고친 경우", "사용자 UI 디자인 변경", "커다란 API의 변경", "급하게 치명적인 버그를 고쳐야하는 경우", "코드 포맷 변경, 세미 클론 누락 (오타 수정, 탭 사이즈 변경, 변수명 변경", "프로덕션 코드 리팩토링", "필요한 주석 추가 및 변경", "문서 수정", "테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X)", "빌드 테스트 업데이트, 패키지 매니저를 설정", "파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우", "파일을 삭제하는 작업만 수행한 경우"]
        let colorHex = ["#3563EB", "#2B4BE9", "#8B44C1", "#B03320", "#51F1F5", "#4AB455", "#777777", "#948534", "123456", "#999999", "#987654", "#991133", "#661293"]

        for index in 0..<name.count {
            let tag = Tag(context: context)
            tag.colorHex = colorHex[index]
            tag.name = name[index]
            tag.tagDescription = description[index]
            tag.category = "태그"
        }

        let function = ["Add", "Fix", "Change"]

        for index in 0..<function.count {
            let tag = Tag(context: context)
            tag.colorHex = colorHex[index]
            tag.name = function[index]
            tag.category = "기능"
        }
        save()
    }
    fileprivate func save() {
        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("error when save change \(error)")
        }
    }
}
