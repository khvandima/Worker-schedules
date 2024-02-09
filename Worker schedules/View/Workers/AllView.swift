//
//  AllView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import SwiftData

struct AllView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Worker.factory?.factoryName, animation: .snappy) private var workers: [Worker]
    
    @State private var showingDeleteAlert = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                if workers.isEmpty {
                    VStack {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .foregroundColor(.brown)
                        Text("No saved worker")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                    }
                } else {
                    List {
                        ForEach(filteredWorkers) {worker in
                            NavigationLink {
                                EditWorkerView(worker: worker, selectPlace: worker.adress)
                            } label: {
                                HStack {
                                    Text(worker.name)
                                        .font(.title2)
                                        .fontWeight(.bold)                                    
                                    Spacer()
                                    Text(worker.factory?.factoryName ?? "WK")
                                        .padding(.horizontal)
                                        .font(.subheadline)
                                    Button {
                                        //
                                                                                
                                        guard let url = URL(string: "tel:\(worker.name)") else { return }
                                        Link(worker.name, destination: url)
                                        
//                                        UIApplication.shared.open(url)
                                        
                                    } label: {
                                        Image(systemName: "phone.circle")
                                            .font(.title)
                                            .foregroundStyle(Color.green)
                                            .padding(.horizontal)
                                            .imageScale(.large)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let worker = workers[index]
                                context.delete(worker)
                            }
                        })
                        
                        
                        
                        
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("All")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AdWorkerView()
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.plusButton)
                    }
                }
            }
            
        }
        .searchable(text: $searchText)
        
        // Вычисляемое значение для поиска
        var filteredWorkers: [Worker] {
            if searchText.isEmpty {
                return workers
            } else {
                return workers.filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
            }
        }
    }
}

//#Preview {
//    AllView()
//        .modelContainer(for: Worker.self, inMemory: true)
//}
//
