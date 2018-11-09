import Foundation
import RealmSwift



class Sesion: Object {
    
    @objc dynamic var userID: String = ""
    @objc dynamic var premium: Bool = false

}
