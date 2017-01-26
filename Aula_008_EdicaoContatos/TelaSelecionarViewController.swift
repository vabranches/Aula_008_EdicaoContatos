import UIKit
import ContactsUI

class TelaSelecionarViewController: UIViewController , CNContactPickerDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelSobrenome: UILabel!
    @IBOutlet weak var labelTelefone: UILabel!
    
    //MARK: Propriedades
    var meuContactStore = CNContactStore()
    var foiSelecionado = true

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Actions
    @IBAction func selecionar(_ sender: UIButton) {
        foiSelecionado = true
        let meuContactPicker = CNContactPickerViewController()
        meuContactPicker.delegate = self
        
        present(meuContactPicker, animated: true)
        
    }
    
    @IBAction func apagar(_ sender: UIButton) {
        foiSelecionado = false
        let meuContactPicker = CNContactPickerViewController()
        meuContactPicker.delegate = self
        
        present(meuContactPicker, animated: true)
    }
    
    //MARK: Métodos de CNContactPickerDelegate
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        if foiSelecionado == true {
            let nome = contact.givenName
            let sobrenome = contact.familyName
            var telefoneSelecionado = ""
            let listaTelefones = contact.phoneNumbers
            
            if listaTelefones.count > 0 {
                telefoneSelecionado = (listaTelefones[0].value).stringValue
            }
            
            labelNome.text = nome
            labelSobrenome.text = sobrenome
            labelTelefone.text = telefoneSelecionado
            
        } else {
            let salvarRequisicao = CNSaveRequest()
            let contatoParaDeletar = contact.mutableCopy() as! CNMutableContact
            
            salvarRequisicao.delete(contatoParaDeletar)
            
            do {
                try meuContactStore.execute(salvarRequisicao)
            } catch {}
        }
        
        picker.dismiss(animated: true)
    }


}
