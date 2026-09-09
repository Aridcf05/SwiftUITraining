import XCTest
@testable import SwiftUITraining

final class TaskCounterViewModelTests: XCTestCase {
    
    private var sut: TaskCounterViewModel! // System Under Test
    
    // 1. Ciclo de vida: setUp se ejecuta ANTES de cada test individual
    override func setUp() {
        super.setUp()
        sut = TaskCounterViewModel()
    }
    
    // 2. Ciclo de vida: tearDown limpia la memoria DESPUÉS de cada test
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // Test 1: Caso normal (Patrón AAA)
    func test_increment_increasesCountByOne() {
        // Arrange
        XCTAssertEqual(sut.count, 0)
        
        // Act
        sut.increment()
        
        // Assert
        XCTAssertEqual(sut.count, 1)
        XCTAssertNil(sut.errorMessage)
    }
    
    // Test 2: Caso límite (Edge case)
    func test_decrement_whenCountIsZero_keepsZeroAndSetsError() {
        // Arrange (inicia en 0)
        XCTAssertEqual(sut.count, 0)
        
        // Act
        sut.decrement()
        
        // Assert
        XCTAssertEqual(sut.count, 0)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.count < 0, "El contador no puede ser negativo")
    }
}
