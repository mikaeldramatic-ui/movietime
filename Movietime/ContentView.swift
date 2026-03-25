//
//  ContentView.swift
//  Movietime
//
//  Created by Mikael Engvall on 2026-03-25.
//

import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let genre: String
    let rating: Double
    let year: String
    let description: String
    let director: String
    let iconName: String
}

extension Double {
    var oneDecimal: String{
        String(format: "%.1f", self)
    }
}

struct MovieDetailView: View {

    let movie: Movie

    var body: some View {
        VStack(spacing: 20) {
            Image("\(movie.iconName)")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            Text(movie.title)
                .font(.title)
                .fontWeight(.bold)
            Text(movie.year)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text(movie.genre)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text(movie.director)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text(movie.description)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text("Rating: \(movie.rating.oneDecimal)")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
}

struct ContentView: View {

    @State private var movies = [
        Movie(
            title: "Inception",
            genre: "Thriller",
            rating: 8.8,
            year: "2010",
            description:
                "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO, but his tragic past may doom the project and his team to disaster.",
            director: "Christopher Nolan",
            iconName: "waveform.path.ecg.rectangle.fill"
        ),
        Movie(
            title: "There's Something About Mary",
            genre: "Comedy",
            rating: 7.1,
            year: "1998",
            description:
                "A man gets a chance to meet up with his dream girl from high school, even though his date with her back then was a complete disaster.",
            director: "Bobby and Peter Farrelly,",
            iconName: "theatermasks.fill"
        ),
        Movie(
            title: "Pirates of the Caribbean: The Curse of the Black Pearl",
            genre: "Adventure",
            rating: 8.1,
            year: "2003",
            description:
                "Blacksmith Will Turner teams up with eccentric pirate \"Captain\" Jack Sparrow to save Elizabeth Swann, the governor's daughter and his love, from Jack's former pirate allies, who are now undead.",
            director: "Gore Verbinski",
            iconName: "sailboat.fill"
        ),
    ]

    @State private var newTitle = ""
    @State private var newGenre = ""
    @State private var newRating: Double = 0.0
    @State private var newYear = ""
    @State private var newDescription = ""
    @State private var newDirector = ""
    @State private var newIconName = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.95, blue: 0.9),
                        Color(red: 0.95, green: 0.9, blue: 1.0),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List(movies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        HStack {
                            Image(systemName: movie.iconName)
                                .font(.system(size: 24))
                                .frame(width: 48)
                                .foregroundStyle(.gray)

                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text("\(movie.year)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
                .navigationTitle("Movies")
            }
        }
    }
}

#Preview {
    ContentView()
}
