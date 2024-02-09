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
    @Environment(\.modelContext) private var context
    
    @Query(animation: .snappy) private var factories: [Factory]
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var adress: String = ""
    
    @State private var factoryIndex: Int = 1
    @State private var oldFactoryIndex: Int = 0
    @State var selectPlace: Location
    
    
    var body: some View {
        
        VStack{
            Section{
                TextField("Name", text: $name)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                
                TextField("Phone", text: $phone)
                    .onChange(of: phone) {
                       if !phone.isEmpty {
                           phone = phone.formatPhoneNumber()
                        }
                     }
                    .keyboardType(.decimalPad)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                
                VStack(alignment: .trailing) {
                    NavigationLink(destination: {
                        EditAdressView(worker: worker, name: name, selectPlace: $selectPlace, tempSelectPlace: selectPlace)
                        
                    }, label: {
                        TextField((!selectPlace.name.isEmpty) ? "Adress is checked" : "Adress", text: $adress)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .disabled(true)
                    })
                }
            }
            .padding(.horizontal)
            
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
            
            HStack {
                Button {
                    //
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button {
                    //
                    worker.name = name
                    worker.phone = phone
                    worker.adress = selectPlace
                    
                    if worker.factory != factories[factoryIndex] {
                        worker.factory = factories[factoryIndex]
                        if let index = factories[oldFactoryIndex].workers.firstIndex(where: {$0 === worker}) {
                            factories[oldFactoryIndex].workers.remove(at: index)
                        }
                    }
                    dismiss()
                    
                } label: {
                    Text("Save")
                        .padding(.horizontal, 10)
                    
                    
                }
                .disabled(
                    
                    name == worker.name &&
                    phone == worker.phone &&
                    selectPlace.latitude == worker.adress.latitude &&
                    selectPlace.longitude == worker.adress.longitude &&
                    factoryIndex == factories.firstIndex{$0 === worker.factory}!
                )
                .tint(.red)
                
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
            .frame(width: 180)
            Spacer()
                .navigationTitle("Edit worker page")
                .toolbar(.hidden, for: .tabBar)
        }
        .padding(.vertical)
        // onAppear загружает данные один раз. и при смене экрана не обновляет данные
        .onFirstAppear{
            name = worker.name
            phone = worker.phone
            selectPlace = worker.adress
            factoryIndex = factories.firstIndex{$0 === worker.factory}!
            oldFactoryIndex = factories.firstIndex{$0 === worker.factory}!
        }
    }
}

//#Preview {
//    EditWorkerView(worker: Worker(name: "Dima", phone: "010-7320-7188", adress: "lksdjflksdjf"))
//}

// onAppear загружает данные один раз. и при смене экрана не обновляет данные
public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

// onAppear загружает данные один раз. и при смене экрана не обновляет данные
private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
