//Justin Stauffer
//  ContentView.swift
//  Tic-Tac-Toe

// Importing SwiftUI for UI development
import SwiftUI

// ContentView struct which conforms to the View protocol
struct ContentView: View {
    // State variables for managing the game state
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3) // The game board
    @State private var currentPlayer: String = "X" // Tracks the current player
    @State private var winner: String? = nil // Tracks the winner
    @State private var isDraw: Bool = false // Tracks if the game is a draw
    @State private var xscore = 0 // Score counter for player X
    @State private var oscore = 0 // Score counter for player O

    // Main view for the ContentView
    var body: some View {
        VStack(spacing: 10) { // Vertical stack for arranging views
            // Loop to create rows for the Tic-Tac-Toe grid
            ForEach(0..<3) { row in
                HStack(spacing: 10) { // Horizontal stack for arranging views in a row
                    // Loop to create columns for each row
                    ForEach(0..<3) { col in
                        Button(action: {
                            makeMove(row: row, col: col) // Action to make a move on the board
                        }) {
                            Text(board[row][col]) // Display the value in the board cell
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                }
            }

            // Display the winner or if it's a draw
            if let winner = winner {
                Text("\(winner) Wins!")
                    .font(.title)
                    .padding(.top, 20)
            } else if isDraw {
                Text("It's a Draw!")
                    .font(.title)
                    .padding(.top, 20)
            }

            // Display scores for both players
            Text("X Win#: \(xscore)")
                .font(.title)
                .offset(x:-100, y: 0)
            Text("O Win#: \(oscore)")
                .font(.title)
                .offset(x:100, y: -40)

            // Button to restart the game
            Button("Restart Game") {
                reset() // Resets the game state
            }
            .padding(.top)//formatting for the spacing and color of the game
            .padding(.bottom)
            .padding(.horizontal)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
        .padding()//formatting for the spacing and color of the game
        .background(Color.cyan.edgesIgnoringSafeArea(.all))
        .background(Color.gray.opacity(0.2))
        
    }

    // Function to handle making a move on the board
    func makeMove(row: Int, col: Int) {
        if board[row][col] == "" && winner == nil { // Check if the cell is empty and no winner yet
            board[row][col] = currentPlayer // Set the cell to the current player's symbol

            if checkWinner() { // Check if the current move made a winner
                winner = currentPlayer // Set the winner
                if currentPlayer == "X"{
                   xscore += 1 // Increment score for X
                }
                else{
                     oscore += 1 // Increment score for O
                }
                
            } else {
                // Change the current player
                currentPlayer = (currentPlayer == "X") ? "O" : "X"
                // Check for a draw
                isDraw = board.joined().allSatisfy { $0 != "" } && winner == nil
            }
        }
    }

    // Function to check if the current player has won
    func checkWinner() -> Bool {
        // Check rows and columns for winning condition
        for i in 0..<3 {
            if board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer { return true }
            if board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer { return true }
        }
        // Check diagonals for winning condition
        return (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) ||
               (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer)
    }

    // Function to reset the game to its initial state
    func reset() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentPlayer = "X"
        winner = nil
        isDraw = false
    }
}


