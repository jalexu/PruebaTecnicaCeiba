//
//  Constants.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation

public struct Constants {
    enum MessagesError {
        static let message = "Por favor intenta más tarde."
        static let title = "Ha ocurrido un error"
        static let okButton = "Aceptar"
        static let closeButton = "Close"
        static let listEmpty = "No hay mas datos para mostrar"
    }
    
    enum CoreDataBase {
        static let nameDatabase = "PruebaTecnicaCeibaDB"
    }
    
    struct URLPaths {
        static let baseURL = "https://jsonplaceholder.typicode.com"
        static let publishing = "/posts?userId="
        static let users = "/users"
    }
    
    struct APIClient {
        static let contentType = "Content-Type"
    }
    
    enum TextDescription {
        static let searchUser = "Buscar usuario"
    }
    
    public struct PreviewsMocks {
        static let users: [UserModel] = [
            UserModel(id: 1,
                 name: "Leanne Graham",
                 username: "Bret",
                 email: "Sincere@april.biz",
                 address: address,
                 phone: "1-770-736-8031 x56442",
                 website: "hildegard.org",
                 company: company),
            UserModel(id: 2,
                 name: "Leanne Graham",
                 username: "Bret",
                 email: "Sincere@april.biz",
                 address: address,
                 phone: "1-770-736-8031 x56442",
                 website: "hildegard.org",
                 company: company)
        ]
        
        static let user: UserModel = UserModel(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: address,
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: company)
        
        static let address: Address = Address(
            street: "Victor Plains",
            suite: "Suite 879",
            city: "Wisokyburgh",
            zipcode: "90566-7771",
            geo: geo)
        
        static let geo: Geo = Geo(lat: "-43.9509", lng: "-34.4618")
        
        static let company: Company = Company(
            name: "Deckow-Crist",
            catchPhrase: "Proactive didactic contingency",
            bs: "synergize scalable supply-chains")
        
        
        static let userPusblishing: UserPublishig = UserPublishig(
            userID: 1,
            id: 1,
            title: "Stringsunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        static let userPusblishings: [UserPublishig] = [
            UserPublishig(
                userID: 1,
                id: 1,
                title: "Stringsunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
            UserPublishig(
                userID: 2,
                id: 2,
                title: "Stringsunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        ]
    }
}
