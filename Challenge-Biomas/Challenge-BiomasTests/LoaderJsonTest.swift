//
//  InfoBiomaView.swift
//  Challenge-BiomasTests
//
//  Created by Helaine Pontes on 24/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import XCTest

@testable import Challenge_Biomas

let loadJson = LoaderJson()


class LoaderJsonTest: XCTestCase {
    func test_LoaderJson_estadoData_count19(){
        //given
        let sut = LoaderJson()
        
        // when
        let output1 = sut.estadoData
        let count1 = output1.count
        
        //then
        XCTAssertEqual(count1, 19)
    }
    func test_LoaderJson_biomaData_count6(){
        //given
        let sut = LoaderJson()
        
        // when
        let output1 = sut.biomaData
        let count1 = output1.count
        
        //then
        XCTAssertEqual(count1, 6)
    }
}

