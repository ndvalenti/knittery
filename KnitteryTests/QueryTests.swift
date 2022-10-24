//
//  QueryTests.swift
//  KnitteryTests
//
//  Created by Nick on 2022-10-21.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import XCTest
@testable import Knittery

final class QueryTests: XCTestCase {
    let query = Query()
    
    func testEmptyQuery() {
        query.clear()
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=$sort=best")
    }
    
    func testBasicInvertQuery() {
        query.clear()
        query.search = "cowl"
        query.invert = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=_best")
    }
    
    func testSecondPageQuery() {
        query.clear()
        query.search = "cowl"
        query.page = "2"
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$page=2")
    }
    
    func testSingleNotebookQuery() {
        query.clear()
        query.search = "cowl"
        query.notebook.append(.favorites)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$notebook-p=faved")
    }
    
    func testMultipleNotebooksQuery() {
        query.clear()
        query.search = "cowl"
        query.notebook.append(.favorites)
        query.notebook.append(.library)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$notebook-p=faved%7Clibrary")
    }
    
    func testSingleCraftQuery() {
        query.clear()
        query.search = "hat"
        query.craft.append(QCraft.crochet)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=hat$sort=best$craft=crochet")
    }
    
    func testMultipleCraftsQuery() {
        query.clear()
        query.search = "hat"
        query.craft.append(QCraft.knitting)
        query.craft.append(QCraft.crochet)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=hat$sort=best$craft=knitting%7Ccrochet")
    }
    
    func testSingleAvailabilityQuery() {
        query.clear()
        query.search = "cowl"
        query.availability.append(.nocost)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$availability=free")
    }
    
    func testDoubleAvailabilitiesQuery() {
        query.clear()
        query.search = "cowl"
        query.availability.append(.nocost)
        query.availability.append(.ravelryDownload)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$availability=free%7Cravelry")
    }
    
    func testSingleWeightQuery() {
        query.clear()
        query.search = "cowl"
        query.weight.append(.fingering)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$weight=fingering")
    }
    
    func testDoubleWeightsQuery() {
        query.clear()
        query.search = "cowl"
        query.weight.append(.fingering)
        query.weight.append(.jumbo)
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$weight=fingering%7Cjumbo")
    }
}
