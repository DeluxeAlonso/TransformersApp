//
//  TransformerWarTests.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import XCTest
@testable import TransformersApp

class TransformerWarTests: XCTestCase {

    func testTeamDivisionAutobotsCount(){
        //Arrange
        let autobots = [Transformer.with(id: "1", type: .autobot)]
        let decepticons = [Transformer.with(id: "2", type: .decepticon)]
        let transformers = autobots + decepticons
        let warUtil = TransformerWarUtil(transformers: transformers)
        //Act
        let dividedTeams = warUtil.divideTransformersByTeam()
        //Assert
        XCTAssertEqual(dividedTeams.autobots.count, autobots.count)
    }

    func testTeamDivisionDecepticonsCount(){
        //Arrange
        let autobots = [Transformer.with(id: "1", type: .autobot)]
        let decepticons = [Transformer.with(id: "2", type: .decepticon)]
        let transformers = autobots + decepticons
        let warUtil = TransformerWarUtil(transformers: transformers)
        //Act
        let dividedTeams = warUtil.divideTransformersByTeam()
        //Assert
        XCTAssertEqual(dividedTeams.decepticons.count, decepticons.count)
    }

    func testTeamDivisionAutobotsOrder(){
        //Arrange
        let highestAutobotRank = 10
        let autobots = [Transformer.with(id: "1", rank: 1, type: .autobot), Transformer.with(id: "3", rank: highestAutobotRank, type: .autobot)]
        let decepticons = [Transformer.with(id: "2", type: .decepticon)]
        let transformers = autobots + decepticons
        let warUtil = TransformerWarUtil(transformers: transformers)
        //Act
        let dividedTeams = warUtil.divideTransformersByTeam()
        //Assert
        XCTAssertEqual(dividedTeams.autobots.first!.rank, highestAutobotRank)
    }

    func testTeamDivisionDecepticonsOrder() {
        //Arrange
        let highestDecepticonRank = 10
        let decepticons = [Transformer.with(id: "1", rank: 1, type: .decepticon), Transformer.with(id: "3", rank: highestDecepticonRank, type: .decepticon)]
        let autobots = [Transformer.with(id: "2", type: .autobot)]
        let transformers = autobots + decepticons
        let warUtil = TransformerWarUtil(transformers: transformers)
        //Act
        let dividedTeams = warUtil.divideTransformersByTeam()
        //Assert
        XCTAssertEqual(dividedTeams.decepticons.first!.rank, highestDecepticonRank)
    }

    func testCourageRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", courage: 10, firepower: 1)
        let decepticon = Transformer.with(id: "2", courage: 6, firepower: 10)
        //Act
        let comparison = autobot > decepticon
        //Assert
        XCTAssertTrue(comparison)
    }

    func testStrengthRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", strength: 10, firepower: 1)
        let decepticon = Transformer.with(id: "2", strength: 7, firepower: 10)
        //Act
        let comparison = autobot > decepticon
        //Assert
        XCTAssertTrue(comparison)
    }

    func testSkillRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", firepower: 1, skill: 10)
        let decepticon = Transformer.with(id: "2", firepower: 10, skill: 7)
        //Act
        let comparison = autobot > decepticon
        //Assert
        XCTAssertTrue(comparison)
    }

    func testOptimusPrimeRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", name: "Optimus Prime")
        let decepticon = Transformer.with(id: "2", firepower: 10, skill: 7)
        let warUtils = TransformerWarUtil(transformers: [autobot, decepticon])
        //Act
        let result = warUtils.performSingleBattle(autobot: autobot, decepticon: decepticon)
        //Assert
        XCTAssertEqual(result, .autobot)
    }

    func testPredakingRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", name: "Predaking")
        let decepticon = Transformer.with(id: "2", firepower: 10, skill: 7)
        let warUtils = TransformerWarUtil(transformers: [autobot, decepticon])
        //Act
        let result = warUtils.performSingleBattle(autobot: autobot, decepticon: decepticon)
        //Assert
        XCTAssertEqual(result, .autobot)
    }

    func testFinishDrawRule() {
        //Arrange
        let autobot = Transformer.with(id: "1", name: "Predaking")
        let decepticon = Transformer.with(id: "2", name: "Predaking")
        let warUtils = TransformerWarUtil(transformers: [autobot, decepticon])
        //Act
        let result = warUtils.performSingleBattle(autobot: autobot, decepticon: decepticon)
        //Assert
        XCTAssertEqual(result, .finishDraw)
    }

}
