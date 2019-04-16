import Foundation

protocol FM {
    func removeDB(url: URL, fm: FileManager) //вынести в отдельный протокол
    func createURL(nameDB: String, fm: FileManager) -> URL //вынести в отдельный протокол
}

extension FM {
    
    func createURL(nameDB: String, fm: FileManager) -> URL {
        var url = URL(fileURLWithPath: "")
        do {
            url = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(nameDB)
        } catch {
            print(error)
        }
        return url
    }
    
    func removeDB(url: URL, fm: FileManager) {
        do {
            try fm.removeItem(at: url)
        } catch {
            print("error delete DB")
        }
        
    }
    
}

