//
//  AdWorkerSheetView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/19/24.
//
//TODO: Add custom TextField for phone number!

import SwiftUI
import SwiftData

struct AdWorkerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    @State private var phone = ""
    @State private var adress = ""
    @State private var factoryIndex: Int = 0
    @State private var selectPlace: Location?
    
    @Query private var factories: [Factory]
    
    var body: some View {
        NavigationStack {
            
            VStack (alignment: .trailing) {
                Section {
                    
                    TextField("Name", text: $name)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    
                    TextField("Phone", text: $phone)
                        .onChange(of: phone) {
                           if !phone.isEmpty {
                               phone = phone.formatPhoneNumber()
                            }
                         }
                        .keyboardType(.decimalPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        
                    VStack(alignment: .trailing) {
                        NavigationLink(destination: {
                            SearchAdressView(selectPlace: $selectPlace, name: name)
                                
                        }, label: {
                            TextField((selectPlace != nil) ? "Adress is checked" : "Adress", text: $adress)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                                .disabled(true)
                        })
                    }
                
                    HStack{
                        Text("Factory")
                            .padding(.leading)
                        
                        Spacer()
                        
                        Picker("Factory", selection: $factoryIndex) {
                            if factories.isEmpty {
                                Text("No Factories")
                            } else {
                                ForEach(0 ..< factories.count, id: \.self){ index in
                                    Text(factories[index].factoryName).tag(index)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(4)
                        .background(.gray.opacity(0.5))
                        .clipShape(.buttonBorder)
                    }
                }
            }
            .padding()
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button {
                    guard var adress = selectPlace else { return }
                    adress.name = name
                    let worker = Worker(name: name, phone: phone, adress: adress)
                    context.insert(worker)
                    worker.factory = factories[factoryIndex]
                    factories[factoryIndex].workers.append(worker)
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .padding(.horizontal, 10)
                }
                .disabled(
                    name.isEmpty ||
                    phone.isEmpty ||
                    selectPlace?.latitude == nil)
                .tint(.red)
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 180)
            Spacer()
                .navigationTitle("Add new worker")
        }
    }
}

//#Preview {
//    AdWorkerView()
//}



