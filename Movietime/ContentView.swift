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
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

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
    @State private var showingAddMovieSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.5, green: 0.0, blue: 0.15),
                        Color(red: 0.1, green: 0.05, blue: 0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List {
                    ForEach(movies){ movie in
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
                    .onDelete(perform: deleteMovie)
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
                .navigationTitle("Movies")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showingAddMovieSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddMovieSheet) {
                    AddMovieView(
                        movies: $movies,
                        isPresented: $showingAddMovieSheet
                    )
                }
            }
        }
    }
    func deleteMovie(at offsets: IndexSet) {
            movies.remove(atOffsets: offsets)
        }
}

struct AddMovieView: View {
    @Binding var movies: [Movie]
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var genre = ""
    @State private var rating: Double = 5.0
    @State private var year = ""
    @State private var description = ""
    @State private var director = ""
    @State private var iconName = "film.fill"
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.5, green: 0.0, blue: 0.15),
                        Color(red: 0.1, green: 0.05, blue: 0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Form {
                Section("Movie Information") {
                    TextField("Title", text: $title)
                    TextField("Genre", text: $genre)
                    TextField("Year", text: $year)
                    TextField("Director", text: $director)
                }
                
                Section("Details") {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                    
                    HStack {
                        Text("Rating:")
                        Slider(value: $rating, in: 0...10, step: 0.1)
                        Text(rating.oneDecimal)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Add Movie")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addMovie()
                    }
                    .disabled(title.isEmpty)
                
                }
            
            }
            }
        }
    }
    func addMovie() {
        let newMovie = Movie(
            title: title,
            genre: genre,
            rating: rating,
            year: year,
            description: description,
            director: director,
            iconName: iconName
        )
        
        movies.append(newMovie)
        isPresented = false
    }
}

#Preview {
    ContentView()
}
