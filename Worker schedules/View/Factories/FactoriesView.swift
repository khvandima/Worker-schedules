//
//  FactoriesView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import SwiftData

struct FactoriesView: View {
    
    @Query(animation: .snappy) private var factories: [Factory]
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                if factories.isEmpty {
                    VStack {
                        Image(systemName: "building.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .foregroundColor(.brown)
                        Text("No saved factories")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                    }
                } else {
                    VStack(alignment: .leading ){
                        ScrollView {
                            ForEach(factories, id: \.self) { factory in
                                NavigationLink(destination: {
                                    FactoryWorkersEditView(factory: factory)
                                }, label: {
                                    FactoryCard(factory: factory)
                                        .background(LinearGradient(colors: [factory.hexColor.opacity(0.15), factory.hexColor.opacity(0.55)], startPoint: .bottomLeading, endPoint: .topTrailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                })
                            }
                        }
                    }
                }
            }
            .navigationTitle("Factories")
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
                AddFactory()
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

//#Preview {
//    FactoriesView()
//}

struct FactoryCard: View {
    
    let factory: Factory
    
    @State var factoryName = ""
    @State var workersCount = 0
    
    var body: some View {
        HStack {
            HStack (spacing: 16) {
                Image(systemName: "building.2")
                Text(factoryName) //Text(factory.factoryName)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            if !factory.workers.isEmpty {
                Text("\(workersCount) 명") //Text("\(factory.workers.count) 명")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(height: 60)
        .padding()
        .onAppear{
            factoryName = factory.factoryName
            workersCount = factory.workers.count
        }
    }
}

//#Preview {
//    let preview = Preview(Factory.self)
////    let preview = Preview(Worker.self)
//    preview.addExamples(Worker.sampleWorkers)
//    preview.addExamples(Factory.sampleFactories)
////    factories[1].workers.append(workers[0])
//    return FactoriesView()
//        .modelContainer(preview.container)
//}
