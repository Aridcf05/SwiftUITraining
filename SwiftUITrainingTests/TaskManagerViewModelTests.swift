import XCTest
@testable import SwiftUITraining

final class TaskManagerViewModelTests: XCTestCase {
    
    private var sut: TaskManagerViewModel!
    
    // MARK: - Ciclo de Vida
    override func setUp() {
        super.setUp()
        sut = TaskManagerViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - 1. Caso Normal (Happy Path)
    func test_addTask_withValidTitle_appendsTaskSuccessfully() throws {
        // Arrange
        let title = "Revisar entregable NTT DATA"
        XCTAssertEqual(sut.tasks.count, 0)
        
        // Act
        try sut.addTask(title: title)
        
        // Assert
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertEqual(sut.tasks.first?.title, title)
        XCTAssertFalse(sut.tasks.first!.isCompleted)
        XCTAssertNil(sut.errorMessage)
    }
    
    // MARK: - 2. Caso de Error (Aserción de excepción)
    func test_addTask_withEmptyOrWhitespaceTitle_throwsEmptyTitleError() {
        // Arrange
        let emptyTitle = "    "
        
        // Act & Assert
        XCTAssertThrowsError(try sut.addTask(title: emptyTitle)) { error in
            XCTAssertEqual(error as? TaskError, .emptyTitle)
        }
        XCTAssertEqual(sut.tasks.count, 0)
        XCTAssertNotNil(sut.errorMessage)
    }
    
    // MARK: - 3. Caso Límite (Edge Case - Límite de capacidad)
    func test_addTask_whenReachingMaxLimit_throwsCapacityError() throws {
        // Arrange: llenamos hasta el límite permitido (5)
        for i in 1...sut.maxLimit {
            try sut.addTask(title: "Tarea \(i)")
        }
        XCTAssertEqual(sut.tasks.count, 5)
        
        // Act & Assert: intentar insertar la sexta debe arrojar error
        XCTAssertThrowsError(try sut.addTask(title: "Tarea extra 6")) { error in
            XCTAssertEqual(error as? TaskError, .maximumCapacityReached)
        }
        XCTAssertEqual(sut.tasks.count, 5)
    }
    
    // MARK: - 4. Aserciones Booleanas (Toggle)
    func test_toggleTask_changesCompletionStatus() throws {
        // Arrange
        try sut.addTask(title: "Escribir pruebas unitarias")
        guard let taskId = sut.tasks.first?.id else {
            XCTFail("No se encontró el ID de la tarea")
            return
        }
        XCTAssertFalse(sut.tasks.first!.isCompleted)
        
        // Act
        try sut.toggleTask(id: taskId)
        
        // Assert
        XCTAssertTrue(sut.tasks.first!.isCompleted)
    }
    
    // MARK: - 5. Eliminación de datos
    func test_deleteTask_removesTaskFromList() throws {
        // Arrange
        try sut.addTask(title: "Tarea temporal")
        guard let taskId = sut.tasks.first?.id else { return }
        
        // Act
        sut.deleteTask(id: taskId)
        
        // Assert
        XCTAssertEqual(sut.tasks.count, 0)
        XCTAssertNil(sut.tasks.first)
    }
}
