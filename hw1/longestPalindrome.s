.data
str:
        .string "abccccdd"

.text
main:
        la      a0,str       # a0 = str
        call    longestPalindrome    # longestPalindrome(str)
        li      a7,1         # print result
        ecall
        li      a7,10        # exit
        ecall
        
longestPalindrome:
        addi    sp,sp,-504
        sw      ra,500(sp)
        sw      s0,496(sp)
        addi    s0,sp,504
        
        # initialize array elements to 0
        li      t0,0
        li      t1,492
init_loop:
        bgt     t0,t1,init_loop_end
        add     t2,sp,t0
        sw      zero,0(t2)
        addi    t0,t0,4
        j       init_loop
init_loop_end:
        
        # count the number of occurences of each letter
        li      a1,0         # ans = 0
        mv      t0,a0        # ptr = str
count_times_loop:
        lbu     t1,0(t0)     # *ptr
        beq     t1,zero,count_times_loop_end    # *ptr == '\0'
        slli    t1,t1,2      # calculate offset of the integer array
        add     t1,sp,t1     # &count[*ptr]
        lw      t2,0(t1)     # count[*ptr]
        addi    t2,t2,1      # ++count[*ptr]
        sw      t2,0(t1)
        addi    t0,t0,1      # ptr++
        j       count_times_loop
count_times_loop_end:
        sub     a2,t0,a0     # length = ptr - s
        
        # count each pair
        li      t0,65        # i = 'A'
        li      t1,122       # 'z'
count_pairs_loop:
        bgt     t0,t1,count_pairs_loop_end      # i > 'z'
        slli    t2,t0,2      # calculate offset of the integer array
        add     t2,sp,t2     # &count[i]
        lw      t2,0(t2)     # count[i]
        andi    t2,t2,-2     # count[i] & 0xfffffffe
        add     a1,a1,t2     # ans += (count[i] & 0xfffffffe)
        addi    t0,t0,1      # ++i
        j       count_pairs_loop        
count_pairs_loop_end:

        bge     a1,a2,else
        li      t0,1
        j       result
else:
        li      t0,0
result:
        add     a0,a1,t0
        lw      s0,496(sp)
        lw      ra,500(sp)
        addi    sp,sp,504
        ret
