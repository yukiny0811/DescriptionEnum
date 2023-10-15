
# DescriptionEnum
Easily write description for your Enum cases.

## Usage

```.swift
import DescriptionEnum

@DescriptionEnum
public enum Fruit: String, Codable, CaseIterable {
    case Apple = "Sweet"
    case Lemon = "Sour"
    case Name = "Description"
}
```

```.swift
print(Fruit.Apple.name) //Apple
print(Fruit.Lemon.desc) //Lemon
print(Fruit.init(rawValue: "Lemon")!) //Fruit.Lemon
print(Fruit.allCases.randomElement()!)
print(Fruit.Name.rawValue) //Name
```
