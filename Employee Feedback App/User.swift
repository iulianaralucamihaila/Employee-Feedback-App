import Foundation

class User {
    let emailAddress: String
    let password: String
    let firstName: String
    let lastName: String
    let resiliance: Double
    let performance: Double
    let innovation: Double
    let biography: String
    
    init(emailAdress: String, password: String, firstName: String, lastName: String, resiliance: Double, performance: Double, innovation: Double, biography: String) {
        self.emailAddress = emailAdress
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.resiliance = resiliance
        self.performance = performance
        self.innovation = innovation
        self.biography = biography
    }
}
