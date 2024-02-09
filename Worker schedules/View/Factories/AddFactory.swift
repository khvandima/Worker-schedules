//
//  AddFactory.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/23/24.
//

import SwiftUI

struct AddFactory: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var factoryName = ""
    @State private var factoryColor = Color.gray
    
    var body: some View {
        
        NavigationStack {
            VStack (alignment: .trailing) {
                Section {
                    TextField("Name", text: $factoryName)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                }
                ColorPicker("Set the factory color", selection: $factoryColor, supportsOpacity: false)
            }
            .padding()
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(Color.blue)
                }
                
                Spacer()
                
                Button {
                    let factory = Factory(factoryName: factoryName, color: factoryColor.toHexString()!)
                    context.insert(factory)
                    dismiss()
                } label: {
                    Text("Save")
                        .padding(.horizontal, 10)
                }
                .disabled(
                    factoryName.isEmpty
                )
                .tint(.red)
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 180)
            Spacer()
            .navigationTitle("Add new factory")
        }
    }
}

#Preview {
    AddFactory()
}
