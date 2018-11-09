import Foundation
import RealmSwift


class ListaAlimentos: Object {
    
    
    @objc dynamic var nombre: String = ""
    @objc dynamic var tipoMacro: String = ""
    @objc dynamic var cantidad: String = ""
    @objc dynamic var comprado: Bool = false
    @objc dynamic var porcion: Int = 0
    @objc dynamic var unidadPorcion: String = ""
    
    
    
    var parentLista = LinkingObjects(fromType: Lista.self, property: "listaAlimentos")
    
}
