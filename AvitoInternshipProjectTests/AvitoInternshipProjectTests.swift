//
//  AvitoInternshipProjectTests.swift
//  AvitoInternshipProjectTests
//
//  Created by Mila B on 24.10.2022.
//

import XCTest

@testable import AvitoInternshipProject

final class AvitoInternshipProjectTests: XCTestCase {
    
    var dataProvider: DataProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataProvider = DataProvider()
    }

    override func tearDownWithError() throws {
        dataProvider = nil
        try super.tearDownWithError()
    }

    func testCorrectJSON() throws {
        _ = DataProvider.shared.readLocalFile(forName: "sampleCorrectJSON")
        XCTAssertNil(DataProvider.error)
    }

    func testIncorrectNameJSON() throws {
        _ = DataProvider.shared.readLocalFile(forName: "sampleIncorrectNameJSON")
        if let error = DataProvider.error {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
        else {
            XCTFail("Error should be thrown")
        }
    }
    
    func testIncorrectPhoneNumberJSON() throws {
        _ = DataProvider.shared.readLocalFile(forName: "sampleIncorrectPhoneJSON")
        if let error = DataProvider.error {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
        else {
            XCTFail("Error should be thrown")
        }
    }
    
    func testIncorrectSkillsJSON() throws {
        _ = DataProvider.shared.readLocalFile(forName: "sampleIncorrectSkillsJSON")
        if let error = DataProvider.error {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
        else {
            XCTFail("Error should be thrown")
        }
    }
    
    func testIncorrectStructureJSON() throws {
        _ = DataProvider.shared.readLocalFile(forName: "sampleIncorrectStructureJSON")
        if let error = DataProvider.error {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
        else {
            XCTFail("Error should be thrown")
        }
    }

}
