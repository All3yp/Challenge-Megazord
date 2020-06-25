//
//  InfoBiomaView.swift
//  Challenge-BiomasTests
//
//  Created by Helaine Pontes on 24/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import XCTest

@testable import Challenge_Biomas

let loadJson = LoadJson()


class InfoBiomaView: XCTestCase {
    func test_(){
        //given
        //verificar se o load.biomasData comeca vazio
        let sut = LoadJson()
        // when
        let output = sut.biomaData
        let count = output.count
        //then
        XCTAssertEqual(count, 6)
    }
}
