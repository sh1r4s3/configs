
define qemu_riscv_init
       target extended-remote :1234
       add-inferior
       inferior 2
       attach 2
       set schedule-multiple
       info threads
end
