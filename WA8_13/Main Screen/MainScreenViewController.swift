//
//  MainScreenViewController.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/5/23.
//

import UIKit
import Alamofire

class MainScreenViewController: UIViewController {

    let mainScreen = MainScreenView()
    let notificationCenter = NotificationCenter.default
    

    var contactNames = [Note]()
    var selectedRow: Int?
    var userToken = ""

    override func loadView() {
        view = mainScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        navigationItem.hidesBackButton = true
        
        if let userToken = UserDefaults.standard.object(forKey: "userToken") as? String{
            self.userToken = userToken
        }
        

        //MARK: setting the delegate and data source...
        mainScreen.tableViewContacts.dataSource = self
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.separatorStyle = .none

        //get all contact names when the main screen loads...
        getAllNotes()

        //MARK: add action to Add Contact button...
        mainScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile", style: .plain, target: self,
            action: #selector(onProfileButtonTapped)
        )
    }
    
    
    @objc func onProfileButtonTapped(){
        let profileScreenController = ProfileViewController()
        navigationController?.pushViewController(profileScreenController, animated: true)
    }



    @objc func onButtonAddTapped(){
        //do the validations...
        if let text = mainScreen.textFieldAddName.text{
            //MARK: call add a new contact API endpoint...
            addANewNote(noteText: text)
        }
        else{
            //alert....
        }
    }

    func clearAddViewFields(){
        mainScreen.textFieldAddName.text = ""
    }


    //MARK: add a new contact call: add endpoint...
    func addANewNote(noteText: String){
        if let url = URL(string: APIConfigs.noteURL+"post"){

            AF.request(url, method:.post,
                       parameters:
                        [
                            "text": noteText
                        ],
                       headers:["x-access-token": self.userToken])
                .responseString(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode

                    switch response.result{
                    case .success(let data):
                        //MARK: there was no network error...

                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                //MARK: the request was valid 200-level...
                                self.getAllNotes()
                                self.clearAddViewFields()
                                print("success 5")
                                break

                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    print(data)
                                    break

                                default:
                                //MARK: probably a 500-level error...
                                    print(data)
                                    break

                            }
                        }
                        break

                    case .failure(let error):
                        //MARK: there was a network error...
                        print(error)
                        break
                    }
                })
        }else{
            //alert that the URL is invalid...
        }
    }

    //MARK: get all contacts call: getall endpoint...
    func getAllNotes(){
        if let url = URL(string: APIConfigs.noteURL + "getall"){
            AF.request(url, method: .get,
                       headers:["x-access-token": self.userToken])
            .responseData(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode

                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...

                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                            //MARK: the request was valid 200-level...
                            
                            self.contactNames.removeAll()
                            let decoder = JSONDecoder()
                            do{
                                let receivedData =
                                    try decoder
                                    .decode(Notes.self, from: data)
                                    
                                for item in receivedData.notes{
                                    self.contactNames.append(item)
                                }
                                self.mainScreen.tableViewContacts.reloadData()
                            }catch{
                                print("JSON couldn't be decoded.")
                            }
                            break
                            


                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print(data)
                                break

                            default:
                            //MARK: probably a 500-level error...
                                print(data)
                                break

                        }
                    }
                    break

                case .failure(let error):
                    //MARK: there was a network error...
                    print(error)
                    break
                }
            })
        }
    }
    
    @objc func deleteSelectedFor(index: Int){
        let note = contactNames[index]
        if let url = URL(string: APIConfigs.noteURL + "delete"){
            AF.request(url, method: .post,
                       parameters:
                        [
                            "id": note._id
                        ],
                       headers:["x-access-token": self.userToken])
            .responseData(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode

                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...

                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                print("Deleted \(note.text)")
                                self.contactNames.remove(at: index)
                                self.mainScreen.tableViewContacts.reloadData()
                                break
                            
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print(data)
                                break

                            default:
                            //MARK: probably a 500-level error...
                                print(data)
                                break

                        }
                    }
                    break

                case .failure(let error):
                    //MARK: there was a network error...
                    print(error)
                    break
                }
            })
        }

    }
    
    
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! ContactsTableViewCell
        cell.labelName.text = contactNames[indexPath.row].text
        
        //MARK: crating an accessory button...
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        //MARK: setting an icon from sf symbols...
        buttonOptions.setImage(UIImage(systemName: "xmark"), for: .normal)

        //MARK: setting up menu for button options click...
        buttonOptions.menu = UIMenu(title: "Are you sure you want to delete?",
                                    children: [
                                        UIAction(title: "Delete",handler: {(_) in
                                            self.deleteSelectedFor(index: indexPath.row)
                                        })
                                    ])
        //MARK: setting the button as an accessory of the cell...
        cell.accessoryView = buttonOptions
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
}
