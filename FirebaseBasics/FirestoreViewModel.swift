//
//  FirestoreVieModel.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 29.08.24.
//

import Foundation
import FirebaseFirestore

class FirestoreViewModel : ObservableObject {
    // MARK: Variables -
    
    @Published var exampleModel: [ExampleModel] = []
    
    private let firebaseFireStore = Firestore.firestore()
    
    
    // MARK: Functions-
    
    // Eine Collection erstellen aus der App heraus
    func addCollection(newCollection: String, documentName: String, example: ExampleModel){
      
        
        do { try firebaseFireStore.collection(newCollection).document(documentName).setData(from: example) { error in
            if let error {
                print("Fehler beim hinzufügen collection: \(error.localizedDescription)")
            } else {
                print("Erfolgreich collection hinzugefügt")
            }
            
        }
            
        } catch {
            print("Fehler beim erstellen \(error.localizedDescription)")
        }
    }
    
    // Eine Firestore Collection aus der App abrufen mit dem viewmodel
    
    
    func fetchCollection(collectionName: String){
        self.firebaseFireStore.collection(collectionName).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Fehler beim laden der Dokumente aus der Collection: \(error)")
                return
            }
            
            // Es wird überprüft ob die Liste der Dokumente in der Collection vorhanden ist und wenn nicht wird ein Fehler geprinted
            guard let documents = snapshot?.documents else {
                print("Keine Dokumente gefunden")
                return
            }
            
            self.exampleModel = documents.compactMap { document -> ExampleModel? in
                do{
                    return try document.data(as: ExampleModel.self)
                } catch {
                    print("Error decoding: \(error)")
                    return nil
                }
            }
        }
        
        
        
    }
    
}
