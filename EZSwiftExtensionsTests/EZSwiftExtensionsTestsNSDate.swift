//
//  EZSwiftExtensionsTestsNSDate.swift
//  EZSwiftExtensions
//
//  Created by Valentino Urbano on 28/01/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import XCTest

class EZSwiftExtensionsTestsNSDate: XCTestCase {
    // note that NSDate uses UTC in NSDate(timeIntervalSince1970: _)

    var string: String!
    var wrongDateString: String!
    let format = "dd-mm-yyyy hh:mm:ss"

    override func setUp() {
        super.setUp()
        string = "01-01-1970 00:00:00"
        wrongDateString = "13-82-1900 90:65:12"
    }

    func testDateFromString() {
        guard let dateFromString = Date(timeInterval: string, since: format) else {
            XCTFail("Date From String Couldn't be initialized.")
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.date(from: string)
        XCTAssertEqual(dateFromString, dateString)
        XCTAssertNil(Date(timeInterval: wrongDateString, since: format), "Date From String initialized, but source string was invalid.")
    }

    func testDateToString() {
        let date = Date(timeIntervalSince1970: 0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        
        XCTAssertEqual(date.toString(format: format), dateString)
    }

    func testTimePassedBetweenDates() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertTrue(date.timePassed().contains("years"))
        let now = Date()
        XCTAssertTrue(now.timePassed().contains("now") || now.timePassed().contains("seconds"))
    }

    func testComparable() {
        let date = Date()
        let future = Date(timeIntervalSinceNow: 1000)
        XCTAssertTrue(date < future)
        XCTAssertFalse(date > future)
        XCTAssertTrue(date == date)
    }
}
