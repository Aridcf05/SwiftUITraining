import XCTest

final class TaskManagerUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        // Este argumento le dice a SwiftUITrainingApp que abra directo TaskManagerView:
        app.launchArguments = ["-UITests_TaskManager"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func test_addNewTask_displaysTaskInList() {
        let inputField = app.textFields["txt_task_input"]
        let addButton = app.buttons["btn_add_task"]
        
        // 1. Espera a que los controles existan
        XCTAssertTrue(inputField.waitForExistence(timeout: 2.0))
        
        // 2. Simula escritura del usuario
        inputField.tap()
        inputField.typeText("Entregable")
        
        // 3. Toca el botón Agregar
        addButton.tap()
        
        // 4. Verifica que aparezca en la lista
        let taskRow = app.staticTexts["Entregable"]
        XCTAssertTrue(taskRow.waitForExistence(timeout: 2.0))
    }
}
