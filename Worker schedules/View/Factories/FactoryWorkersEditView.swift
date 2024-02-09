//
//  FactoryWorkersEditView.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/24/24.
//

import SwiftUI
import SwiftData

struct FactoryWorkersEditView: View {
    
    let factory: Factory
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var isAuto = false
    @State private var dayOnly = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                HStack {
                    Toggle("Auto", isOn: $isAuto)
                        .toggleStyle(SwitchToggleStyle(tint: Color.orange.opacity(0.7)))
                        .controlSize(.mini)
                        .frame(width: 130)
                    Spacer()
                    Toggle("Day only", isOn: $dayOnly)
                        .toggleStyle(SwitchToggleStyle(tint: Color.orange.opacity(0.7)))
                        .controlSize(.mini)
                        .frame(width: 130)
                }.padding()
                    .onChange(of: [isAuto, dayOnly]) {
                        factory.isAuto = isAuto
                        factory.dayOnly = dayOnly
                    }
                ScrollView (showsIndicators: false) {
                    ForEach( 0..<factory.workers.count, id:\.self ) { index in
                        FactoryWorkersEditCard(worker: factory.workers[index], workers: factory.workers)
                    }
                }
                Spacer()
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .onAppear{
            isAuto = factory.isAuto
            dayOnly = factory.dayOnly
        }
        .navigationTitle("\(factory.factoryName)")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(factory.workers.count)명")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
    }
}

//#Preview {
//    FactoryWorkersEditView()
//}

struct FactoryWorkersEditCard: View {
    
    let worker: Worker
    let workers: [Worker]

    var body: some View {
        VStack {
            HStack {
                Text(worker.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: worker.isDay ? "sun.max" : "moon.fill")
                        .foregroundStyle(worker.isDay ? Color.yellow : Color.gray)
                    Text(worker.isDay ? "주간" : "야간")
                }
                .padding(4)
                .background(worker.isDay ? Color.blue.opacity(0.8) : Color.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(12)
            .background(
                (LinearGradient(colors: [.gray.opacity(0.15), .gray.opacity(0.55)], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            if worker.isTaping {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            worker.isDay = true
                            worker.isTaping.toggle()
                        }
                    }, label: {
                        Image(systemName: "sun.max")
                            .foregroundStyle(Color.yellow)
                        Text("주간")
                    })
                    .padding(4)
                    .background(Color.blue.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Spacer(minLength: 40)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            worker.isDay = false
                            worker.isTaping.toggle()
                        }
                    }, label: {
                        Image(systemName: "moon.fill")
                            .foregroundStyle(Color.gray)
                        Text("야간")
                    })
                    .padding(4)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .padding()
                .frame(width: 210)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                IsTapTrueToggle()
                worker.isTaping.toggle()
            }
        }
    }
    func IsTapTrueToggle() {
        for worker in workers {
            if worker.isTaping {
                guard let index = workers.firstIndex(of: worker) else { return  }
                workers[index].isTaping.toggle()
            }
        }
    }
}


//#Preview {
//    FactoryWorkersEditView(factory: factories[1])
//}
