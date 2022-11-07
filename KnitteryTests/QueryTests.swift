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
        query.notebook[.favorites] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$notebook-p=faved")
    }
    
    func testMultipleNotebooksQuery() {
        query.clear()
        query.search = "cowl"
        query.notebook[.favorites] = true
        query.notebook[.library] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssert(queryString == "?query=cowl$sort=best$notebook-p=faved%7Clibrary" || queryString == "?query=cowl$sort=best$notebook-p=library%7Cfaved")
    }
    
    func testSingleCraftQuery() {
        query.clear()
        query.search = "hat"
        query.craft[.crochet] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=hat$sort=best$craft=crochet")
    }
    
    func testMultipleCraftsQuery() {
        query.clear()
        query.search = "hat"
        query.craft[.knitting] = true
        query.craft[.crochet] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssert(queryString == "?query=hat$sort=best$craft=knitting%7Ccrochet" || queryString == "?query=hat$sort=best$craft=crochet%7Cknitting")
    }
    
    func testSingleAvailabilityQuery() {
        query.clear()
        query.search = "cowl"
        query.availability[.nocost] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$availability=free")
    }
    
    func testDoubleAvailabilitiesQuery() {
        query.clear()
        query.search = "cowl"
        query.availability[.nocost] = true
        query.availability[.ravelryDownload] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssert(queryString == "?query=cowl$sort=best$availability=free%7Cravelry" || queryString == "?query=cowl$sort=best$availability=ravelry%7Cfree")
    }
    
    func testSingleWeightQuery() {
        query.clear()
        query.search = "cowl"
        query.weight[.fingering] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssertEqual(queryString, "?query=cowl$sort=best$weight=fingering")
    }
    
    func testDoubleWeightsQuery() {
        query.clear()
        query.search = "cowl"
        query.weight[.fingering] = true
        query.weight[.jumbo] = true
        let queryString = QueryBuilder.build(query)
        
        XCTAssert(queryString == "?query=cowl$sort=best$weight=fingering%7Cjumbo" || queryString == "?query=cowl$sort=best$weight=jumbo%7Cfingering")
    }
}
