.TL
Self-Study Assignment Data-Link CSE1405
.AU
Connor Spruit
.AI
Delf University of Technology, The Netherlands
.NH
Question 1
.PP
The first one has 5 ones.
The second has 10.
The third has 5.
the forth has 4.
therefore rows 1 and 3 are guaranteed to be wrong.

.NH
Question 2
.PP
No, there is no way to trace back which bit should be flipped.
It is also not possible with 1 bit to detect if 2 bit flips have occured.

.NH
Question 3
.PP
No, as discussed in question 2, it is possible 2 bits have been flipped.

.NH 
Question 4 (parity words)
.PP
No the reciever does not find any error.
The reciever does not know if the sequence is correct as we are unable to tell if multiple bit flips occured.

.NH
Question 5 (internet checksum)
.PP
add them up, add overflow back to the front (how the fuck).
then flip bits add to the end.

.NH
Question 6 (crc computation)
.PP
the division is 110 100 011 000 over 1101 which gives 1 0000 0000 & r=011.
Therefore the message is 110 100 011 011.

.NH
Question 7 (crc error detection)
.PP
1100 1110 0111 1000 01 over 110010 is 1000010000100 with remainder 11001.
Thus there has been an error.

.NH
Question 8 (crc - parity)
.PP
 k = 5 - 1 = 4. 
 Thuis 4 0's are added to the message befored deviding by the generator.
 this leads to 10001111 r=101.
 thus the message becomes 101101000101.
 this is even parity so a 0 is added to the end to create
 1011010001010.

.NH
Question 9 (parity blocks)
.PP
1 0 1 1 | 1    
0 0 0 1 | 1   
1 0 0 0 | 1    
0 1 1 1 | 1     
-----------   
0 1 0 1 | 0     

.NH
Question 10 (hamming codes)
.PP
So the way to do hamming codes is that powers of 2 should be parity bits, so for 11 bits total bits 1 2 4 8 should be parity bits.
Then fill the data in the non-parity bits. then based on the binary expanion calculate what the parity should be.
