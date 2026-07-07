import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [BloomRecord] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "bloomdate_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([BloomRecord].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: BloomRecord) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: BloomRecord) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: BloomRecord) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [BloomRecord] {
        [
        BloomRecord(plantName: "Monstera", year: 1, bloomStart: Date().addingTimeInterval(-259200), bloomEnd: Date().addingTimeInterval(-259200)),
        BloomRecord(plantName: "Pothos", year: 2, bloomStart: Date().addingTimeInterval(-518400), bloomEnd: Date().addingTimeInterval(-518400)),
        BloomRecord(plantName: "Snake Plant", year: 3, bloomStart: Date().addingTimeInterval(-777600), bloomEnd: Date().addingTimeInterval(-777600)),
        BloomRecord(plantName: "Fiddle Leaf Fig", year: 4, bloomStart: Date().addingTimeInterval(-1036800), bloomEnd: Date().addingTimeInterval(-1036800))
        ]
    }
}
