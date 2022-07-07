import Foundation

struct EmployeeListResponse: Decodable {
    let apiUserId: Int32
    let emailAddress: String
    let firstName: String
    let lastName: String
    let profilePhotoURL: String
}
