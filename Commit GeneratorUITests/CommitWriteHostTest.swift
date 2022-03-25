//
//  CommitWriteHostTest.swift
//  CommitGeneratorUITests
//
//  Created by JongHo Park on 2022/03/21.
//

import XCTest

class CommitWriteHostTest: XCTestCase {
  var app: XCUIApplication!
  override func setUpWithError() throws {
    try super.setUpWithError()
    app = XCUIApplication()
    continueAfterFailure = false
    app.launch()
  }
  
  func testCopyButtonEnabling() throws {
    let copyButton = app.navigationBars["커밋 작성"].buttons["커밋 복사"]
    XCTAssertFalse(copyButton.isEnabled)
    let elementsQuery = XCUIApplication().scrollViews.otherElements
    elementsQuery.buttons["태그"].tap()
    elementsQuery.buttons["이름, !BREAKING CHANGE, 설명, 커다란 API의 변경"].tap()
    elementsQuery.buttons["기능"].tap()
    elementsQuery.buttons["이름, Add"].tap()
    elementsQuery.buttons["제목, 0/50"].tap()
    let textEditor = app.textViews["TextEditor"]
    textEditor.tap()
    textEditor.typeText("11")
    app.navigationBars["제목"].buttons["커밋 작성"].tap()
    XCTAssertTrue(copyButton.isEnabled)
  }
}
