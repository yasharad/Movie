# Movie
A simple iOS App to show a list of movies by search (MVVM,Protocol Oriented,Testable)

In this app i have used [Themoviedb](https://www.themoviedb.org) Api

## Network Layer
Network layer was built without any thirdparty libraray such as Alamofire ....
But it is very easy to change it to any library you would like
if you like to use Alamofire,  repalce
```
func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                if error != nil {
                     completion(nil, BackendError(data: nil, error: error))
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.result {
                    case .success:
                        completion(data, nil)
                    case .failure( _):
                        completion(nil, BackendError(data: data, error: error))
                    }
                }
            })
        }catch {
            completion(nil, BackendError(data: nil, error: error))
        }
        self.task?.resume()
    }
```
with
```
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        do {
            let request = try self.buildRequest(from: route)
           
            Alamofire.request(request)
                .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("Progress: \(progress.fractionCompleted)")
                }
                .validate { request, response, data in
                    
                    return .success
                }
                .responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        completion(response.data,response.response,nil)
                        
                    case .failure(let error):
                        print(error)
                        completion(nil,nil, error)
                    }
            }
        }catch {
            completion(nil, nil, error)
        }
       
    }
```
In NetworkManager.swift file you can change your basic API Url
```
struct NetworkManager {
    static  let shared = NetworkManager()
    private static let environment: NetworkEnvironment = .production
    static var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .qa:         return "http://api.themoviedb.org/3/search/movie"
        case .staging:    return "http://api.themoviedb.org/3/search/movie"
        case .production: return "http://api.themoviedb.org/3/search/movie"
        }
    }
    
    static var environmentImageURL: String {
        switch NetworkManager.environment {
        case .qa:         return "http://image.tmdb.org/t/p/"
        case .staging:    return "http://image.tmdb.org/t/p/"
        case .production: return "http://image.tmdb.org/t/p/"
        }
    }
    
}
```

