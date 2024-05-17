#![no_std]
#![no_main]
#![panic_handler]
use core::panic;
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

fn _start() {}
