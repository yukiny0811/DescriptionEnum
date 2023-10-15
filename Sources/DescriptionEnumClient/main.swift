import DescriptionEnum
import Foundation

@DescriptionEnum
public enum Fruit: String, Codable, CaseIterable {
    case Apple = "甘い"
    case Grape = "紫色"
    case Lemon = "酸っぱい"
    case 名前 = "説明"
}

// 使い方
print(Fruit.Apple.name)
print(Fruit.Grape.desc)
print(Fruit.init(rawValue: "Lemon")!)
print(Fruit.allCases.randomElement()!)
print(Fruit.名前.rawValue)

struct Temp: Codable {
    var aaa = "aaa"
    var idea: Fruit = .Apple
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let encoded = try! encoder.encode(Temp())
let decoded = try! decoder.decode(Temp.self, from: encoded)

dump(decoded)
