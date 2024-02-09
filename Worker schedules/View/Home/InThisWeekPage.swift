//
//  InThisWeekPage().swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/17/24.
//

import SwiftUI
import SwiftData
        
struct InThisWeekPage: View {
    
    @Query(animation: .snappy) private var factories: [Factory]
        
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(factories, id: \.self) { factory in
                    NavigationLink(destination: {
                        InThisWeekDitail(factory: factory)
                    }, label: {
                        InThisWeekCard(factory: factory)
                            .background(LinearGradient(colors: [factory.hexColor.opacity(0.15), factory.hexColor.opacity(0.55)], startPoint: .bottomLeading, endPoint: .topTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(factory.hexColor.opacity(0.4), lineWidth: 1)
                            )
                    })
                    
                }
                
            }
            .navigationTitle("ON THIS WEEK")
        }
    }
}


#Preview {
    InThisWeekPage()
}


struct InThisWeekCard: View {
    
    let factory: Factory
    
    @State private var newDayWorkers = [Worker]()
    @State private var newNightWorkers = [Worker]()
    
    var body: some View {
        VStack (alignment: .leading){
            Text(factory.factoryName)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("주간")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("\(newDayWorkers.count)명")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.top, 1)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach( newDayWorkers, id:\.self ) { worker in
                        Text(worker.name)
                    }
                }
            }
            Divider()
                .overlay(Color.gray)
            HStack {
                Text("야간")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("\(newNightWorkers.count)명")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.top, 2)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach( newNightWorkers, id:\.self ) { worker in
                        Text(worker.name)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            newDayWorkers = dayWorkers
            newNightWorkers = nightWorkers
        }
    }
    
    
    var dayWorkers: [Worker] {
        return factory.workers.filter{$0.isDay}
    }
    
    var nightWorkers: [Worker] {
        return factory.workers.filter{$0.isDay == false}
    }

}
