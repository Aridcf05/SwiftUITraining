import XCTest

final class TaskCounterUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    func test_incrementButton_updatesCounterLabel() {
        // 1. Navegamos desde el menú principal
        let navButton = app.buttons["nav_task_counter"]
        XCTAssertTrue(navButton.waitForExistence(timeout: 2.0))
        navButton.tap()
        
        // 2. Ya en la pantalla del contador, probamos la interacción
        let incrementBtn = app.buttons["btn_increment"]
        let counterTxt = app.staticTexts["txt_counter_value"]
        
        XCTAssertTrue(incrementBtn.waitForExistence(timeout: 2.0))
        incrementBtn.tap()
        
        // 3. Verificamos que suba a 1
        XCTAssertEqual(counterTxt.label, "1")
    }
}
