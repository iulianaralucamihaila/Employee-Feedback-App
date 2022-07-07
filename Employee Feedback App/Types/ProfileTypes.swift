import Foundation

struct ProfileResponse: Decodable {
    let score1: Double
    let score2: Double
    let score3: Double
    let apiUserId: Int
    let biography: String
    let firstName: String
    let lastName: String
    let emailAddress: String
    let profilePhotoURL: String
    let receivedReviews: [ReceivedReview]
}

struct ReceivedReview: Decodable {
    let reviewId: Int64
    let timestamp: Int64
    let senderEmail: String
    let senderId: Int64
    let comment:String
    let scores: Score
}

struct Score: Decodable {
    let score1: Double
    let score2: Double
    let score3: Double
}
