import XCTest
@testable import ToDoList

class ProfileViewTests: XCTestCase {
    var viewModel: MockProfileViewViewModel!
    var profileView: ProfileView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockProfileViewViewModel()
        profileView = ProfileView(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        profileView = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFetchUser() {
        profileView.onAppear()

        // Assert that the fetchUser() function is called
        XCTAssertTrue(viewModel.fetchUserCalled)
    }

    func testLogOut() {
        profileView.profile(user: User(name: "John Doe", email: "johndoe@example.com", joined: Date().timeIntervalSince1970))

        // Trigger the logOut() action
        profileView.logOut()

        // Assert that the logOut() function is called
        XCTAssertTrue(viewModel.logOutCalled)
    }
}

// Mock ProfileViewViewModel
class MockProfileViewViewModel: ProfileViewViewModel {
    var fetchUserCalled = false
    var logOutCalled = false
    
    override func fetchUser() {
        fetchUserCalled = true
    }
    
    override func logOut() {
        logOutCalled = true
    }
}
