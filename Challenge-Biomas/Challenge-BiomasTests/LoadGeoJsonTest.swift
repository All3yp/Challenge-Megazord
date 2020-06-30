//
//  LoadGeoJsonTest.swift
//  Challenge-BiomasTests
//
//  Created by Helaine Pontes on 25/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import XCTest

@testable import Challenge_Biomas

let loadGeoJson = LoadGeoJson()

class LoadGeoJsonTest: XCTestCase {
    func test_LoadJson_artwork_count6(){
        //given
        let sut = LoadGeoJson()
        
        // when
        let output1 = sut.artworks
        let count1 = output1.count
        
        //then
        XCTAssertEqual(count1, 6)
    }
    func test_LoadJson_estateArtwork_count19(){
        //given
        let sut = LoadGeoJson()
        
        // when
        let output1 = sut.estateartworks
        let count1 = output1.count
        
        //then
        XCTAssertEqual(count1, 19)
    }
    }
