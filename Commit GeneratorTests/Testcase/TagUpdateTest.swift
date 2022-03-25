//
//  TagUpdateTest.swift
//  CommitGeneratorTests
//
//  Created by JongHo Park on 2022/03/19.
//

import XCTest
import Combine
@testable import Commit_Generator
class TagUpdateTest: XCTestCase {
  private var coreDataStack: CoreDataStack!
  private var tagRepository: TagStore!
  override func setUpWithError() throws {
    try super.setUpWithError()
    coreDataStack = CoreDataStack(storeType: .inMemory)
    tagRepository = DefaultTagRepository(coreDataStack: coreDataStack)
  }
  
  override func tearDownWithError() throws {
    coreDataStack = nil
    tagRepository = nil
    try super.tearDownWithError()
  }
  // MARK: - 태그 추가 테스트
  func testAddTag() throws {
    // given
    let promise = expectation(description: "tag count is one!")
    tagRepository.addTag(name: "test", colorHex: "123456", tagDescription: "test", category: "test")
    
    // when
    var count: Int?
    _ = tagRepository.tags(category: "test").sink {
      switch $0 {
        case .success(data: let data): count = data.count
        default:
          count = nil
      }
      promise.fulfill()
    }
    wait(for: [promise], timeout: 5)
    // then
    XCTAssertEqual(count, 1)
  }
  // MARK: - 태그 수정 테스트
  func testModifyTag() throws {
    // given
    let promise = expectation(description: "tag modify success!")
    let tag: Tag = Tag(context: coreDataStack.viewContext)
    var modifiedTag: Tag?
    tag.name = "test"
    tag.category = "test"
    tag.colorHex = "123456"
    tag.tagDescription = "test"
    
    // when
    tagRepository.modifyTag(change: tag, withName: "test2", withColor: "test2", withDescription: "test2")
    _ = tagRepository.tags(category: nil).sink {
      switch $0 {
        case .success(data: let data):
          modifiedTag = data[0]
        default:
          break
      }
      promise.fulfill()
    }
    // then
    wait(for: [promise], timeout: 5)
    XCTAssertEqual(modifiedTag?.name, "test2")
  }
  // MARK: 태그 카운트 테스트
  func testTagCountFunction_WhenAddSixTag() throws {
    for _ in 0..<6 {
      tagRepository.addTag(name: "test", colorHex: "test", tagDescription: "test", category: "test")
    }
    XCTAssertEqual(tagRepository.count(category: "test"), 6)
  }
  // MARK: - 태그 삭제 테스트
  func testDeleteTag_WhenAddOneTagAndDelete() throws {
    // given
    tagRepository.addTag(name: "test", colorHex: "test", tagDescription: "test", category: "test")
    XCTAssertEqual(tagRepository.count(category: "test"), 1) // repository에 정확히 추가됐는지 확인
    let promise = expectation(description: "get added tag success!")
    var addedTag: Tag?
    // when
    _ = tagRepository.tags(category: "test").sink {
      switch $0 {
        case .success(data: let data):
          addedTag = data[0]
        default:
          break
      }
      promise.fulfill()
    }
    // then
    wait(for: [promise], timeout: 5)
    XCTAssertNotNil(addedTag) // 추가된 태그를 정확히 받아왔는지 확인
    tagRepository.deleteTag(addedTag!)
    
    XCTAssertEqual(tagRepository.count(category: "test"), 0)
  }
}
