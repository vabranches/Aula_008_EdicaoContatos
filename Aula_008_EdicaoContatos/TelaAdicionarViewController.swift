import UIKit
import ContactsUI

class TelaAdicionarViewController: UIViewController, CNContactPickerDelegate {

    //MARK: Outlets
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldSobrenome: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    //MARK: Actions
    @IBAction func adicionar(_ sender: UIBarButtonItem) {
        if !((textFieldNome.text?.isEmpty)! || (textFieldSobrenome.text?.isEmpty)! || (textFieldTelefone.text?.isEmpty)!) {
            
            let nome = textFieldNome.text
            let sobrenome = textFieldSobrenome.text
            let telefone = textFieldTelefone.text
            
            let novoContato = CNMutableContact()
            novoContato.givenName = nome!
            novoContato.familyName = sobrenome!
            novoContato.phoneNumbers = [CNLabeledValue(label: "Mobile", value: CNPhoneNumber(stringValue: telefone!))]
            
            let salvarRequisao = CNSaveRequest()
            salvarRequisao.add(novoContato, toContainerWithIdentifier: nil)
            
            let meuContactStore = CNContactStore()
            
            do {
                try meuContactStore.execute(salvarRequisao)
            } catch{}
            
            textFieldNome.text = ""
            textFieldSobrenome.text = ""
            textFieldTelefone.text = ""
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
