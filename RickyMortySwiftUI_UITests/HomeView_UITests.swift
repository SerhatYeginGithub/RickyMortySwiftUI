//
//  HomeView_UITests.swift
//  RickyMortySwiftUI_UITests
//
//  Created by serhat on 10.11.2024.
//

import XCTest


final class HomeView_UITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_HomeView_characterItem_DetailNavTitleShouldBeItemName() throws {
        app.scrollViews.otherElements.buttons["Rick Sanchez"].children(matching: .image).element.tap()
        let navBar =  app.navigationBars["Rick Sanchez"]
        XCTAssertTrue(navBar.exists)
    }
    
    func test_HomeView_ShouldBeProgressViewVisible() throws {
       
              let progressView = app.otherElements["ProgressView"]
        
              XCTAssertFalse(progressView.exists)
              
              let firstCharacter = app.scrollViews.otherElements.staticTexts["Rick Sanchez"]
              
              XCTAssertTrue(firstCharacter.exists)
    }
    
    
}
