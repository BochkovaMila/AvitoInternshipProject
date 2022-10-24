//
//  DataProvider.swift
//  AvitoInternshipProject
//
//  Created by Mila B on 22.10.2022.
//

import UIKit

public final class DataProvider {
    
    static let shared = DataProvider()
    
    private let JSON_URL = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    private let cache = NSCache<NSString, MyModel>()
    
    private let cacheLifetime: TimeInterval = 60 * 60 // 1 hour = 60 * 60 secs
    
    public static var error: Error? = nil
    
    public init() {}
    
    public func readLocalFile(forName name: String) -> Model? {
        if let urlPath = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: urlPath, options: .mappedIfSafe)
                let data = self.parse(jsonData: jsonData)
                return data
            } catch {
                DataProvider.error = error
                //print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public func parse(jsonData: Data) -> Model? {
        do {
            let decodedData = try JSONDecoder().decode(Model.self, from: jsonData)
            return decodedData
        } catch {
            DataProvider.error = error
        }
        return nil
    }
    
    public func fetchData(completion: @escaping (Model) -> Void)
    {
        
        if let myModel = cache.object(forKey: "data") {
            
            guard Date.init() < myModel.expirationDate else {
                cache.removeObject(forKey: "data")
                return
            }
            
            print("Using cache")
            completion(myModel.modelObj)
            return
        }
        
        let url = URL(string: JSON_URL)
        
        guard url != nil else {
            //completion(nil)
            return
        }
                
        print("Fetching data")
        let dataTask = URLSession.shared.dataTask(with: url!){ data, response, error in
            
            DispatchQueue.main.async {
                
                if error == nil && data != nil {
                    if let tempModel = self.parse(jsonData: data!) {
                        let date = Date.init().addingTimeInterval(self.cacheLifetime)
                        let modelObj = MyModel(Model: tempModel, expirationDate: date)
                        self.cache.setObject(modelObj, forKey: "data")
                        completion(tempModel)
                    }
                }
                else if error != nil {
                    DataProvider.error = error
                }
            }
        }
        dataTask.resume()
    }
    
}
