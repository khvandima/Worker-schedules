//
//  EditWorkerView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/20/24.
//

import SwiftUI
import SwiftData

struct EditWorkerView: View {
    
    let worker: Worker
    
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Factory.factoryName, animation: .snappy) private var factories: [Factory]
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var adress: String = ""
    @State private var factory: Factory?
    
    
    var body: some View {
        
        VStack{
            Section{
                TextField("Name", text: $name)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                
                TextField("Phone", text: $phone)
                    .keyboardType(.decimalPad)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                
                TextField("Adress", text: $adress)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
            }
            .padding(.horizontal)
            
            HStack{
                Text("Factory")
                    .padding(.leading)
                
                Spacer()
                
                Picker("Factory", selection: $factory) {
                    
                    if factories.isEmpty {
                        Text("No Factories")
                        
                    } else {
                        ForEach(factories){ factory in
                            Text(factory.factoryName).tag(factory)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(4)
                .background(.gray.opacity(0.5))
                .clipShape(.buttonBorder)
            }
            
            //TODO: Create buttons to save or calcel on change state
        }
        .onAppear{
            name = worker.name
            phone = worker.phone
            adress = worker.adress
            factory = worker.factory
        }
    }
}

//#Preview {
//    EditWorkerView()
//}
