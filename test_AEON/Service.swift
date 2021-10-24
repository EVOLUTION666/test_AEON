import Foundation

struct Service {
    
    fileprivate let baseUrl = "http://82.202.204.94/api-test/"
    fileprivate let pathToLogin = "login"
    fileprivate let pathToPayments = "payments"
    
    func postReq(login: String, password: String, completionHandler: @escaping (String?)->()) {
        
        let url = URL(string: baseUrl + pathToLogin)
        let session = URLSession.shared
        let parameters = ["login" : login, "password" : password]

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("12345", forHTTPHeaderField: "app-key")
        request.setValue("1", forHTTPHeaderField: "v")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                          options: .prettyPrinted)

        } catch let error {
            print(error.localizedDescription)
        }

        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionHandler(nil)
                return }
            guard let data = data else {
                completionHandler(nil)
                return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
                let result = try JSONDecoder().decode(AuthModel.self, from: data)
                completionHandler(result.response.token)
                UserDefaults.standard.setValue(result.response.token, forKey: "token")
                
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }.resume()
    }
    
    func getRequest(completionHandler: @escaping ([Payments]) -> ()) {
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            return
        }
        
        let urlStr = baseUrl + pathToPayments + "?token=\(token)"
        
        guard let url = URL(string: urlStr) else { return }
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("12345", forHTTPHeaderField: "app-key")
        request.setValue("1", forHTTPHeaderField: "v")

        session.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
                
                let result = try JSONDecoder().decode(PaymentsResponse.self, from: data)
                completionHandler(result.response)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
