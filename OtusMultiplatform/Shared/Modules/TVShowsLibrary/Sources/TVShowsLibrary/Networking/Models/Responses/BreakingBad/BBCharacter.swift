import Foundation
import RealmSwift

public class BBCharacter: Object, Codable, Identifiable {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var birthday: String = ""
    var occupation = List<String>()
    @objc public dynamic var img: String = ""
    @objc public dynamic var status = ""
    @objc public dynamic var nickname: String = ""
    var appearance = List<Int>()
    @objc public dynamic var portrayed = ""
    @objc public dynamic var category: String = ""
    var betterCallSaulAppearance = List<Int>()
    
    public override init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
    
    public convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupation = try container.decodeIfPresent(List<String>.self, forKey: .occupation) ?? List<String>()
        self.img = try container.decode(String.self, forKey: .img)
        self.status = try container.decode(String.self, forKey: .status)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.appearance = try container.decodeIfPresent(List<Int>.self, forKey: .appearance) ?? List<Int>()
        self.portrayed = try container.decode(String.self, forKey: .portrayed)
        self.category = try container.decode(String.self, forKey: .category)
        self.betterCallSaulAppearance = try container.decodeIfPresent(List<Int>.self, forKey: .betterCallSaulAppearance) ?? List<Int>()
    }
    
    public override class func primaryKey() -> String? {
        return BBCharacter.getPrimaryKey()
    }
    
    public static func getPrimaryKey() -> String {
        return "id"
    }
    
    
    public static func getMockCharacter() -> BBCharacter {
        let character = BBCharacter()
        character.id = 1
        character.name = "Walter White"
        character.birthday = "09-07-1958"
        character.img = "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"
        character.nickname = "Heisenberg"
        return character
    }
    
}


