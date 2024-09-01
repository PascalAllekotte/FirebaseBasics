//
//  ExampleModel.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 29.08.24.
//

import Foundation
import FirebaseFirestore

struct ExampleModel : Codable, Identifiable {
    @DocumentID var id: String?
    
    
    var title : String
    var text : String
    
}
