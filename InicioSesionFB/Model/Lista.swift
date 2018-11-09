import Foundation
import RealmSwift


class Lista: Object {
    
    
    @objc dynamic var tipoMacro: String = ""

    var listaAlimentos = List<ListaAlimentos>()

    
    var parentPersona = LinkingObjects(fromType: Persona.self, property: "lista")
    
}
