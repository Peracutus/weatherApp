//
//  SecondScreen.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI

struct Person: Identifiable {
    let firstName: String
    let secondName: String
    let age: Int
    let gender: String
    let height: Double
    var id: String {
        UUID().uuidString
    }
}

final class PersonsViewModel: ObservableObject {
    
    @Published private(set) var persons = [
        Person(firstName: "Petr", secondName: "Petrovich", age: 56, gender: "Male", height: 199),
        Person(firstName: "Maria", secondName: "Petrovna", age: 5, gender: "Female", height: 140),
        Person(firstName: "John", secondName: "Snow", age: 37, gender: "Male", height: 187),
        Person(firstName: "Ann", secondName: "Hat", age: 26, gender: "Female", height: 166),
    ]
}

struct SecondScreen: View {
    
    @EnvironmentObject var viewModel: PersonsViewModel
    @Binding var isShowingDetailView: Bool

    var body: some View {
        NavigationView {
            List {
              ForEach(viewModel.persons) { person in
                    NavigationLink(destination: DetailInfoScreen(
                        title: person.firstName,
                        secondName: person.secondName,
                        age: person.age,
                        gender: person.gender,
                        height: person.height)) {
                        Text(person.firstName)
                    }
                }
            }.navigationTitle("Second View")
                .overlay(NavigationLink(
                    destination: DetailInfoScreen(
                        title: viewModel.persons[viewModel.persons.startIndex].firstName,
                        secondName: viewModel.persons[viewModel.persons.startIndex].secondName,
                        age: viewModel.persons[viewModel.persons.startIndex].age,
                        gender: viewModel.persons[viewModel.persons.startIndex].gender,
                        height: viewModel.persons[viewModel.persons.startIndex].height),
                    isActive: $isShowingDetailView) { EmptyView() }.hidden())
        }.phoneOnlyStackNavigationView()
    }
}
                         
    struct DetailInfoScreen: View {
        
        let title: String
        let secondName: String
        let age: Int
        let gender: String
        var height: Double
        
        var body: some View {
            VStack {
                Text(title)
                Text(secondName)
                Text("age is \(age)")
                Text(gender)
                Text("height is \(String(format: "%.2f", height))")
            }
        }
    }
