//
//  AvisosDetailUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/22/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class AvisosDetailUserViewController: UIViewController {

    var aviso: Aviso?

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tituloLabel.text = aviso?.titulo
        descripcionLabel.text = aviso?.descripcion
        if let fecha = aviso?.fecha{
             fechaLabel.setDate(fecha, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
