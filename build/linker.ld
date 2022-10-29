OUTPUT_ARCH(riscv)

MEMORY
{
    SRAM (rx) : ORIGIN = 0x00000000, LENGTH = 4096
    RAM (rwx) : ORIGIN = 0x00001000, LENGTH = 4096
}

ENTRY(_start)

SECTIONS
{
    /*PROVIDE(__executable_start = SEGMENT_START("text-segment", 0x00000000)); */
    . = 0x00000000;
    .text :
    {
        *(.text.init)
        *(.text)
    } >SRAM
    
    . = ALIGN(4);
    .rodata :
    {
        *(.rodata)
    } >SRAM

    . = ALIGN(4);
    PROVIDE( __global_pointer$ = .);
    .data :
    {
        *(.data)
    } >SRAM
    PROVIDE( __global_pointer$ = . - __global_pointer$);
    PROVIDE( __global_pointer$ = . - __global_pointer$/2);

    . = ALIGN(4);
    .bss :
    {
        *(.bss)
        . = ALIGN(4);
        __bss_end = .;
    } >RAM

    

    /* define stack top */
    PROVIDE(__STACK_TOP = ORIGIN(RAM) + LENGTH(RAM));

    /* define stack end point */
    PROVIDE(__STACK_END = . );
    /* PROVIDE( end = . ); */
    
    /* define stack size */
    PROVIDE(__STACK_SIZE = __STACK_TOP - __STACK_END);

    . = ALIGN(4);
    .stack :
    {
        . = __STACK_SIZE;
    } >RAM
    
}