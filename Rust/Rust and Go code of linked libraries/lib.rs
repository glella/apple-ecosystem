// primeslib - lib.rs
// Library to calculate primes with Rust on iOS and compare it to swift
// 1 thread & using multiple threads to compare
//
// cargo setup (one time):          rustup target add aarch64-apple-ios x86_64-apple-ios
// check rustup targets installed:  rustup show
// compile with:                    cargo lipo --release
// can check fat binay with:        lipo -info libprimes.a 
// and get:                         Architectures in the fat file: libprimes.a are: x86_64 arm64 

use std::os::raw::{c_int, c_longlong};
// channels & threads
use std::thread;
use std::sync::mpsc;

fn is_prime(n: u32) -> bool {
    match n {
        0 | 1 => false,
        2 => true,
        _even if n % 2 == 0 => false,
        _ => {
            let sqrt_limit = (n as f32).sqrt() as u32;
            !(3..=sqrt_limit).step_by(2).any(|i| n % i == 0)
        }
    }
}

// On a 64-bit system, arguments are 32 bit and return type is 64 bit.
// returns number of primes up to the limit provided
#[no_mangle]
pub extern "C" fn rust_1_thread(limit: c_int) -> c_longlong {
    let mut result = Vec::new();
    // units of num?
    let num = limit as u32;

    for i in 1..num {
        if is_prime(i) {
            result.push(i);
        }
    }

    result.len() as c_longlong
}

fn make_range(min: u32, max: u32) -> Vec<u32> {
	let mut range = Vec::new();
	for i in (min..max).filter(|x| x % 2 == 1) { // Add only odd numbers
		range.push(i);
	}
	range

}

fn prep_search(n: u32, num_threads: u32) -> Vec<Vec<u32>> {
	
	let range_size = n / num_threads;		// range sized divided evenly
	let mut reminder = n % num_threads;			// reminder to be spread out

	let mut range_sizes_vec = Vec::new();	// vector to hold each range size
	for _i in 0..num_threads {
		range_sizes_vec.push(range_size);	// initial size without reminder
	}

	// Spread the reminder
	for i in &mut range_sizes_vec {
		if reminder > 0 {
			*i += 1;
			reminder -= 1;
		}
	}

	let mut vec_of_vec = Vec::new();		// vector of vectors to be returned
	let mut min = 1;
	let mut max;

	for i in range_sizes_vec {
		max = min + i; 
		let temp = make_range(min, max);	// make range filters out even numbers
		//println!("{:?}", temp);
		vec_of_vec.push(temp);
		min = max; 
	}
	vec_of_vec
}

fn search(vectors: Vec<Vec<u32>>) -> Vec<u32> {
	let mut result: Vec<u32> = Vec::new();
	result.push(2);                         // Add 2 as we removed even numbers from list

	// Channels - send and receive
	let (tx, rx) = mpsc::channel();
	let mut children = Vec::new();

	let nthreads = vectors.len();

	for segment in vectors {
    	// The sender endpoint can be copied
        let thread_tx = tx.clone();

        // Each thread will send its results via the channel
        let child = thread::spawn(move || {
        	let mut temp: Vec<u32> = Vec::new();
        	for i in segment {
        		if is_prime(i) {
        			temp.push(i);
        		}
        	}
        	//println!("temp {:?}", temp);
        	thread_tx.send(temp).unwrap();
        });
        	
        children.push(child);
    }
        
    // Here, all the messages are collected
    for _ in 0..nthreads {
    	result.append(&mut rx.recv().unwrap());
    }
          
    // Wait for the threads to complete any remaining work
    for child in children {
        child.join().expect("oops! the child thread panicked");
    }

    result
}


#[no_mangle]
pub extern "C" fn rust_n_threads(limit: c_int, threads: c_int) -> c_longlong {
    let num = limit as u32;
    let num_threads = threads as u32;

    let search_vectors = prep_search(num, num_threads);

    let result = search(search_vectors); // perform the actual work

    result.len() as c_longlong
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_1_thread_in_1m() {
        assert_eq!(rust_1_thread(1000000), 78498);
    }

    #[test]
    fn test_n_threads_in_1m() {
        assert_eq!(rust_n_threads(1000000, 16), 78498);
    }
}

