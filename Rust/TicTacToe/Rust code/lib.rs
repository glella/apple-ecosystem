// minimaxlib - Lib.rs
// Library to calculate best move for Tic-Tac-Toe game
// Uses minimax with alpha beta prunning
// Todo: It is unbeatable. Dumb it down to make it playable (depth limit?)
//
// One time setup x iOS use:
// cargo setup:          			rustup target add aarch64-apple-ios x86_64-apple-ios
// check rustup targets installed:  rustup show
//
// Compile with:                    cargo lipo --release
// can check fat binay with:        lipo -info libminimax.a 
// and get:                         Architectures in fat file: x86_64 arm64 
// Binding generator:				cbindgen src/lib.rs -l c > minimaxlib.h


extern crate libc;

use libc::size_t;
use std::slice;
use std::cmp;
use std::os::raw::c_uint;

const MAX: i32 = 1000;
const MIN: i32 = -1000;

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
enum Player {
	X = 1,
	O = 2,
}

impl Player {
    fn opponent(&self) -> Player {
        match *self {
            Player::X => Player::O,
            Player::O => Player::X,
        }
    }
}

#[derive(Debug, PartialEq)]
enum GameState {
    GameWon { player: Player },
    Tie,
    InProgress,
}

#[derive(Copy, Clone)]
struct Board {
    slots: 			[u32; 9],
    player: 		Player,
}

impl Board {

    fn possible_moves(&self) -> Vec<u32> {
		let mut actions: Vec<u32> = Vec::new();
		// get possible actions - empty slots with a 0
		for (i, &item) in self.slots.iter().enumerate() {
        	if item == 0 {
            	actions.push(i as u32);
        	}
    	}
		actions
	}

	fn perform_action(&mut self, action: u32) {
        // Perform...
        self.slots[action as usize] = self.player as u32;
        // Next player's turn
        self.player = self.player.opponent();
    }

    fn is_ended(&self) -> bool {
    	let game_state = self.get_winner(); 
        match &game_state {
			GameState::GameWon { player: _ } => true,

            _ => {
            	let available_moves = self.possible_moves();
    			!available_moves.len() > 0
            },
        }
    	
    }

    fn get_winner(&self) -> GameState {
    	let winning_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];
    	
    	// check each player in turn if any won
    	for player in &[Player::X, Player::O] {
    		for combination in winning_combinations.iter() {
    			if self.slots[combination[0]] == self.slots[combination[1]] &&
    			self.slots[combination[1]] == self.slots[combination[2]] &&
    			self.slots[combination[2]] == *player as u32 {
    				return GameState::GameWon {player: *player}
    			}
    		}
    	}
    	// if there are no empty cells return a Tie if not return InProgress
        let available_moves = self.possible_moves();
        if available_moves.len() > 0 {
            return GameState::InProgress;
        } else {
            return GameState::Tie;
        }
    }
}

// https://www.geeksforgeeks.org/minimax-algorithm-in-game-theory-set-4-alpha-beta-pruning/
fn minimax_abpruning(board: Board, depth: i32, mut alpha: i32, mut beta: i32) -> i32 { 

	if board.is_ended() {
		let game_state = board.get_winner();
		match &game_state {
			GameState::GameWon { player } => {
        		match player {
        			Player::O	=> return 10 - depth,	// AI won
					Player::X  	=> return -10 + depth,	// PLAYER won
        		}
            },
            _ => return 0,								// draw
		}
	}

	if board.player == Player::O { 					// Simulate AI (Max of Minimax)
		let mut best_move = MIN;
		let possible_moves = board.possible_moves();
		for amove in possible_moves {
			let mut board_copy = board.clone(); 	// copy board
			board_copy.perform_action(amove);		// perform action in board copy
			let result = minimax_abpruning(board_copy, depth+1, alpha, beta);
			best_move = cmp::max(best_move, result);
			alpha = cmp::max(alpha, best_move);
			// Alpha Beta Pruning 
            if beta <= alpha {
                break; 
            }
		}
		return best_move;

	} else {										// Simulate Human (Mini of Minimax)
		
		let mut best_move = MAX;
		let possible_moves = board.possible_moves();
		for amove in possible_moves {
			let mut board_copy = board.clone(); 	// copy board
			board_copy.perform_action(amove);		// perform action in board copy
			let result = minimax_abpruning(board_copy, depth+1, alpha, beta);
			best_move = cmp::min(best_move, result);
			beta = cmp::min(beta, best_move);
			// Alpha Beta Pruning 
            if beta <= alpha {
                break; 
            }
		}
		return best_move;
	}

}

// Helper function to fill array from a slice
fn clone_into_array<A, T>(slice: &[T]) -> A
    where A: Sized + Default + AsMut<[T]>,
          T: Clone {
    let mut a = Default::default();
    <A as AsMut<[T]>>::as_mut(&mut a).clone_from_slice(slice);
    a
}

#[no_mangle]
pub extern "C" fn find_best_rust(n: *const u32, len: size_t) -> c_uint {
    let slice = unsafe {
        assert!(!n.is_null());					// check reference is not null
        slice::from_raw_parts(n, len as usize)	// create the slice
    };
    let board = Board {
    	slots: 	clone_into_array(slice),
    	player:	Player::O
    };
    //println!("{:?}", board.slots);

    let mut best_score = -1000;
	let mut best_move = 100;					// out of bounds - no result ***

	for amove in board.possible_moves() {
		let mut board_copy = board.clone(); 	// copy board
		board_copy.perform_action(amove);		// perform action in board copy
		let score = minimax_abpruning(board_copy, 0, MIN, MAX);
		if score > best_score {
			best_score = score;
			best_move = amove;
		}
	}
    best_move as c_uint
}

#[cfg(test)]
mod tests {
	use super::*;

	fn vec_compare(va: &[u32], vb: &[u32]) -> bool {
    	(va.len() == vb.len()) &&  		// zip stops at the shortest
     	va.iter()						// creates iterator of first vec
       		.zip(vb)					// zips up two iterators into a single iterator of pairs tuple
       		.all(|(a,b)| a == b)		// tests if every element of the iterator matches a predicate
	}

    #[test]
    fn possible_moves_works() {
    	// empty board
    	let board = Board { 						
    		slots: 	[0; 9],							// nine zeroes - empty board
    		player: Player::X
    	};
		let exp = vec![0, 1, 2, 3, 4, 5, 6, 7, 8]; 	// all 9 slots
        assert!(vec_compare(&board.possible_moves(), &exp));

        // 2, 3, 5, 7 slots available
        let board = Board { 						
    		slots: 	[1,2,0,0,1,0,1,0,2],			// slots 2, 3, 5, 7 with 0
    		player:	Player::X
    	};
		let exp = vec![2, 3, 5, 7]; 				// slots 2, 3, 5, 7 avail
        assert!(vec_compare(&board.possible_moves(), &exp));

        // no available slots
        let board = Board { 						
    		slots: 	[1,2,2,1,1,1,1,2,2],			// no slots with 0
    		player:	Player::X
    	};			
		let exp = vec![];			 				// no slots avail
        assert!(vec_compare(&board.possible_moves(), &exp));
    }

    #[test]
    fn perform_action_works() {
    	let mut board = Board { 						
    		slots: 	[0; 9],							// nine zeroes - empty board
    		player: Player::O
    	};
    	
    	board.perform_action(4);					// perform action 4 slot O
		let exp = vec![0, 0, 0, 0, 2, 0, 0, 0, 0]; 	
        assert!(vec_compare(&board.slots, &exp));

        board.perform_action(8);					// perform action 1 slot X
		let exp = vec![0, 0, 0, 0, 2, 0, 0, 0, 1]; 	
        assert!(vec_compare(&board.slots, &exp));
    }

    #[test]
    fn minimax_works() {
    	// center square to win
    	let v = vec![1, 0, 2,
    	 			1, 0, 0,
    	 			2, 1, 0];
        assert_eq!(find_best_rust(v.as_ptr(), 9), 4);

        // lower right corner to win
        let v = vec![1, 0, 2,
    	 			1, 0, 2,
    	 			0, 1, 0];
        assert_eq!(find_best_rust(v.as_ptr(), 9), 8);

        // bottom left corner to avoid losing
        let v = vec![1, 2, 1,
    	 			1, 2, 2,
    	 			0, 1, 0];
        assert_eq!(find_best_rust(v.as_ptr(), 9), 6);

        // middle left to avoid losing
        let v = vec![2,1,2,
        			0,1,1,
        			0,2,1];
       	assert_eq!(find_best_rust(v.as_ptr(), 9), 3);

       	// bottom center to win
        let v = vec![1,2,1,
        			0,2,0,
        			0,0,1];
       	assert_eq!(find_best_rust(v.as_ptr(), 9), 7);

    }
}



