//
//  AdWorkerSheetView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/19/24.
//
//TODO: Add custom TextField for phone number!

import SwiftUI
import SwiftData

struct AdWorkerSheetView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var adress = ""
    @State private var newFactory: Factory?
    
    @Query private var factories: [Factory]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            
      
        VStack (alignment: .trailing) {
            Section {
                
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
                
                HStack{
                    Text("Factory")
                        .padding(.leading)
                    
                    Spacer()
                    
                    Picker("Factory", selection: $newFactory) {
                        
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
            }
        }
        .padding()
        
        HStack {
            Button {
                //
                dismiss()
            } label: {
                Text("Cancel")
            }
            
            Spacer()
            
            Button {
                //
                let worker = Worker(name: name, phone: phone, adress: adress)
                context.insert(worker)
                if let notNilFactory = newFactory {
                    worker.factory = notNilFactory
                    notNilFactory.workers.append(worker)
                }
                dismiss()
            } label: {
                Text("Save")
                    .padding(.horizontal, 10)
                
            }
            .disabled(
                name.isEmpty ||
                phone.isEmpty ||
                adress.isEmpty)
            .tint(.red)
            
        }
        .buttonStyle(.borderedProminent)
        .frame(width: 180)
        Spacer()
        .navigationTitle("Add new worker")
//        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AdWorkerSheetView()
}
