
#define bwMCDR2_ADDRESS 4
#define bsMCDR2_ADDRESS 17
#define bmMCDR2_ADDRESS BIT_MASK(MCDR2_ADDRESS)

#define BIT_MASK(__bf)
(((1U << (bw ## __bf)) - 1)
<< (bs ## __bf))

#define SET_BITS(__dst, __bf, __val)
\
((__dst) = ((__dst) & ~(BIT_MASK(__bf)))
| \
(((__val) << (bs ## __bf))
& (BIT_MASK(__bf))))

SET_BITS(MCDR2, MCDR2_ADDRESS,
RegisterNumber); 


/*_INTSIZEOF(n)整个做的事情就是将n的长度化为int长度的整数倍*/
/*比如n为5，二进制就是101b，int长度为4，二进制为100b，那么n化为int长度的整数倍就应该为8。
 *~(sizeof(int) – 1) )就应该为~（4-1）=~（00000011b）=11111100b.
 *这样任何数& ~(sizeof(int) – 1) )后最后两位肯定为0，就肯定是4的整数倍了。
 *(sizeof(n) + sizeof(int) – 1）就是将大于4m但小于等于4（m+1）的数提高到大于等于4（m+1）       
 * 但小于4 (m+2)，这样再& ~(sizeof(int) – 1) )后就正好将原长度补齐到4的倍数了。
 */ 

#define _INTSIZEOF(n) (sizeof(n)+sizeof(int)-1)&~(sizeof(int)-1)

