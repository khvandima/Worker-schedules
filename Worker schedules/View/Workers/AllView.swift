//
//  AllView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import SwiftData

struct AllView: View {
    
    @Query(sort: \Worker.name, animation: .snappy) private var workers: [Worker]
    
    @State private var showSheet = false
    
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
                        ForEach(workers) {worker in
                            NavigationLink {
                                EditWorkerView(worker: worker)
                            } label: {
                                HStack {
                                    Text(worker.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text(worker.factory?.factoryName ?? "wideKorea")
                                        .padding(.horizontal)
                                        .font(.headline)
                                    Button {
                                        //
                                    } label: {
                                        Image(systemName: "phone.circle")
                                            .font(.title)
                                            .foregroundStyle(Color.green)
                                            .padding(.horizontal)
                                            .imageScale(.large)
                                    }
                                }
                            } 
                        }
                    }
                }
            }
            .navigationTitle("All")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.plusButton)
                    })
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AdWorkerSheetView()
                
                
                    // Изменение цвета заднего фона при появлении sheet
                    .onAppear {
                        setWindowBackgroundColor(.black) // Set the background color behind the sheet
                    }
                    .onDisappear {
                        setWindowBackgroundColor(.white) // Reset the background color when the sheet is dismissed
                    }
            })
        }
    }
    
    // Функция для изменение цвета заднего фона при появлении sheet
    private func setWindowBackgroundColor(_ color: UIColor) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        {
            window.backgroundColor = color
        }
    }
}

#Preview {
    AllView()
}


