#![no_std]
// Type your code here, or load an example.
pub fn bubble_sort(arr: &mut [isize]) {
    let mut swapped = true;
    while swapped {
        // No swap means array is sorted.
        swapped = false;
        for i in 1..arr.len() {
            if arr[i - 1] > arr[i] {
                arr.swap(i - 1, i);
                swapped = true
            }
        }
    }
}

fn main() {
    //println!("Hello, world!");
}
