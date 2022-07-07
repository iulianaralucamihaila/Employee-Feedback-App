import Foundation

struct RegisterRequest: Encodable {
    let biography: String
    let emailAddress: String
    let firstName: String
    let lastName: String
    let password: String
}

struct LoginRequest: Encodable {
    let emailAddress: String
    let password: String
}

struct LoginResponse: Decodable {
    let refreshToken: String
}

struct AccessTokenRequest: Encodable {
    let refreshToken: String
}

struct AccessTokenResponse: Decodable {
    let accessToken: String
}
