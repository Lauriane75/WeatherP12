//
//  WeatherRepositoryTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 13/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import weather

// MARK: - Mock

class MockHTTPClient: HTTPClientType {
    func request<T>(type: T.Type, requestType: RequestType, url: URL, cancelledBy token: RequestCancelationToken, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        do {
            let data = try Data(contentsOf: url)
            
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(type.self, from: data ) else { return }
            completion(.success(value: decodedData))
        }
        catch {
            print(error)
        }
    }
}

// MARK: - Tests

class WeatherRepositoryTests: XCTestCase {
    
    func test_Given_WeahterRepository_When_ItsCalled_Then_DataIsCorrectlyReturned() {
        
        let client = MockHTTPClient()
        
        let stack = CoreDataStack(modelName: "weather",
                                  type: .test)
        
        let repository = WeatherRepository(client: client, stack: stack)
        
        let expectedResult = WeatherItem(time: "2020-02-13 12:00:00",
                                         temperature: "19 °C",
                                         iconID: "01d",
                                         temperatureMax: "20 °C",
                                         temperatureMin: "15 °C",
                                         pressure: "1002 hPa",
                                         humidity: "50 %",
                                         feelsLike: "18 °C",
                                         description: "Sunny")
        
        guard Bundle.main.path(forResource: "FakeWeather", ofType: "json") != nil else { return }
        
        let expectation1 = self.expectation(description: "Returned not nil")
        
        let expectation2 = self.expectation(description: "Returned correctly")
        
        repository.getWeather { (result) in
            switch result {
            case .success(value: .web(let weatherItems)):
                
                XCTAssertNotNil(weatherItems)
                expectation1.fulfill()
                
                XCTAssertEqual(weatherItems, [expectedResult])
                expectation2.fulfill()
                
            case .success(.database(let weatherItems)):
                
                XCTAssertNotNil(weatherItems)
                expectation1.fulfill()
                
                XCTAssertEqual(weatherItems, [expectedResult])
                expectation2.fulfill()
                
            case .error(let error):
                print(error)
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
