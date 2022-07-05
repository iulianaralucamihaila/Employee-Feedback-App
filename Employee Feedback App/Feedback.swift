import Foundation

class Feedback {
    let userName: String
    let averageScore: Double
    let comments: String

    init(userName: String, averageScore: Double, comments: String) {
        self.userName = userName
        self.averageScore = averageScore
        self.comments = comments
    }
}
