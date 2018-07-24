//
//  AvisosUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class AvisosUserViewController: UIViewController {

    @IBOutlet weak var avisosTable : UITableView!
    @IBOutlet weak var seleccionTipoAviso : UISegmentedControl!

    var avisos : [Aviso] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!

    var selectedAviso: Aviso?

    var selectedIndex = Int()
    
    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }
    
    var selectedAviso: Aviso?
    var selectedDocumentRef: DocumentReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        avisosTable.dataSource = self
        avisosTable.delegate = self
        avisosTable.rowHeight = 100
    
        self.query = baseQuery()
    }

    func baseQuery()->Query{
        return Firestore.firestore().collection("comunicados")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
                        
            let results = snapshot.documents.map{(document) -> Aviso in
                if let result = Aviso(diccionario: document.data()){
                    return result
                }
                else {
                    fatalError("unable to initialize with \(document.data()) " )
                }
            }
            
            self.avisos = results
            self.documents = snapshot.documents
            
            self.avisosTable.reloadData()
        }
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailAvisoUser") {

            selectedAviso = avisos[selectedIndex]

            let vc = segue.destination as! DetailAvisoAdminViewController
            vc.aviso = selectedAviso
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AvisosUserViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avisos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avisosTable.dequeueReusableCell(withIdentifier: "AvisoUserCell") as! AvisosAdminTableViewCell
        let aviso = avisos[indexPath.row]
        print(aviso.titulo)
        cell.rellenar(aviso: aviso)
        return cell
    }    
}

extension AvisosUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath{
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "DetailAvisoUser", sender: self)
    }    
}
