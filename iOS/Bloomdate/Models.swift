import Foundation

struct BloomRecord: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var plantName: String
    var year: Int
    var bloomStart: Date
    var bloomEnd: Date

    init(id: UUID = UUID(), plantName: String = "", year: Int = 0, bloomStart: Date = Date(), bloomEnd: Date = Date()) {
        self.id = id
        self.plantName = plantName
        self.year = year
        self.bloomStart = bloomStart
        self.bloomEnd = bloomEnd
    }
}
