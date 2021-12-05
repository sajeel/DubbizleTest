//
//  ListingViewControllerTests.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import XCTest
@testable import DubbizleTest

class ListingViewControllerTests: XCTestCase {
    var listingsViewControllerTest: ListingsViewController!
    var vm: ListingsViewModel!
    
    private func makeSUT() -> ListingsViewController {
        let navController = UINavigationController.init()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vm  = createListingsViewModel()
        let navigator = MainNavigator(navigationController: navController)
        let sut = ListingsViewController.createWith(navigator: navigator, storyboard: storyboard, viewModel: vm)
        return sut
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        listingsViewControllerTest = makeSUT()
        
        //storyboard.instantiateViewController(withIdentifier: "ListingsViewController") as! ListingsViewController
        self.listingsViewControllerTest.loadView()
        self.listingsViewControllerTest.viewDidLoad()
    }
    
    private func createViewModel() -> ListingsViewModel {
        return ListingsViewModel(apiType: ListingsTestAPI.self)
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
    func testHasATableView() {
        XCTAssertNotNil(listingsViewControllerTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(listingsViewControllerTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(listingsViewControllerTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(listingsViewControllerTest.responds(to: #selector(listingsViewControllerTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(listingsViewControllerTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(listingsViewControllerTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(listingsViewControllerTest.responds(to: #selector(listingsViewControllerTest.numberOfSections(in:))))
        XCTAssertTrue(listingsViewControllerTest.responds(to: #selector(listingsViewControllerTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(listingsViewControllerTest.responds(to: #selector(listingsViewControllerTest.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        ListingsTestAPI.reset()
        DispatchQueue.main.async {
            let adsListing = getAdsListing()
            self.vm.paused.accept(false)
            ListingsTestAPI.objects.onNext(adsListing!)
            //let _ = try! self.vm.ads.take(1).toBlocking(timeout: 3).toArray()
            let cell = self.listingsViewControllerTest.tableView(self.listingsViewControllerTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AdCellView
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = "AdCellView"
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }
    }
    
    func testTableCellHasCorrectLabelText() {
        ListingsTestAPI.reset()
        
        DispatchQueue.main.async {
            
            let adsListing = getAdsListing()
            self.vm.paused.accept(false)
            ListingsTestAPI.objects.onNext(adsListing!)
            
            
            let _ = try! self.vm.ads.take(1).toBlocking(timeout: 1).toArray()
            let cell0 = self.listingsViewControllerTest.tableView(self.listingsViewControllerTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AdCellView
            XCTAssertEqual(cell0!.name.text!, "Notebook")
            
            
            let cell1 = self.listingsViewControllerTest.tableView(self.listingsViewControllerTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? AdCellView
            XCTAssertEqual(cell1?.name.text!, "Glasses")
            
            let cell2 = self.listingsViewControllerTest.tableView(self.listingsViewControllerTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? AdCellView
            XCTAssertEqual(cell2?.name.text, "monitor")
        }
        
        
        //
        
       
        
    }
    
}
