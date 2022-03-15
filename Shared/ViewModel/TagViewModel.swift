//
//  TagViewModel.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/15.
//

import Foundation
import Combine
final class TagViewModel: ObservableObject {
    
    private let tagRepository: TagStore
    @Published var tags: [Tag] = []
    @Published var functions: [Tag] = []
    private var cancelBag: Set<AnyCancellable> = []
    
    init(tagRepository: TagStore = DefaultTagRepository.shared) {
        self.tagRepository = tagRepository
        reloadTags()
        reloadFunctions()
    }
    fileprivate func reloadTags() {
        tagRepository.tags(category: "태그")
            .sink {
                switch $0 {
                case .success(data: let tags):
                    self.tags = tags
                default:
                    self.tags = []
                }
            }.store(in: &cancelBag)
    }
    
    fileprivate func reloadFunctions() {
        tagRepository.tags(category: "기능")
            .sink {
                switch $0 {
                case .success(data: let functions):
                    self.functions = functions
                default:
                    self.functions = []
                }
            }.store(in: &cancelBag)
    }
    
    fileprivate func reloadTag(category: String?) {
        switch category {
        case .some("태그"): reloadTags()
        case .some("기능"): reloadFunctions()
        default: fatalError("카테고리 에러")
        }
    }
    func deleteTag(_ tag: Tag) {
        let category: String? = tag.category
        tagRepository.deleteTag(tag)
        reloadTag(category: category)
    }
    
    func modifyTag(change tag: Tag, name: String?, color: String?, description: String?) {
        tagRepository.modifyTag(change: tag, withName: name, withColor: color, withDescription: description)
        reloadTag(category: tag.category)
    }
    
    func addTag(name: String, colorHex: String, tagDescription: String, category: String) {
        tagRepository.addTag(name: name, colorHex: colorHex, tagDescription: tagDescription, category: category)
        reloadTag(category: category)
    }
    
    func removeAll() {
        tagRepository.removeAll()
        reloadTags()
        reloadFunctions()
    }
    
    func count(category: String?) -> Int? {
        return tagRepository.count(category: category)
    }
    
    func reset() {
        tagRepository.reset()
        reloadTags()
        reloadFunctions()
    }
    
}
