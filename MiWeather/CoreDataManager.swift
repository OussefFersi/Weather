//
//  CoreDataManager.swift
//  MiWeather
//
//  Created by oussef on 08/03/2023.
//
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    var delegate:CoreDataManagerDelegate?
    
    private lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "MiWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    private init(){
        
    }

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveCity(name:String,lat:Double,long:Double , completion:@escaping(Bool,Error?) -> Void) {
        let city = MCity(context: persistentContainer.viewContext)
        city.setValue(name, forKey: "name")
        city.setValue(lat, forKey: "lat")
        city.setValue(long, forKey: "long")
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                delegate?.onCMCityAdded()
                completion(true,nil)
            } catch {
                completion(false,error)
            }
        }
    }
    
    func fetchCities() -> [City] {
        var result = [City]()
        do {
            let fetchRequest = NSFetchRequest<MCity>(entityName: "MCity")
            let cities = try persistentContainer.viewContext.fetch(fetchRequest)
            for item in cities{
                result.append(City(name: item.name ?? "", longitude: item.long, latitude: item.lat))
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }
    
    func removeCity(city:City){
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<MCity> = MCity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", city.name)

        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
            }
            try context.save()
            delegate?.onCMCityRemoved()
        } catch {
            // error handling
            print(error.localizedDescription)
        }
    }
    
}

protocol CoreDataManagerDelegate {
    func onCMCityAdded()
    func onCMCityRemoved()
}
