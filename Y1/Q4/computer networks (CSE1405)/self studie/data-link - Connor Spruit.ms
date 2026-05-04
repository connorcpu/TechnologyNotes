.TL
Self-Study Assignment Data-Link CSE1405
.AU
Connor Spruit
.AI
Delf University of Technology, The Netherlands
.NH
Question 1
.NH 2
.PP
Erie sends 200-byte frames over a connection with a bandwidth of 500 bytes per second.
This means it will take 400ms to send 1 frame.
The communication delay is 250ms.
This means that after 650ms Piyush has received the whole frame and starts sending the acknowledgement.
At a bandwidth of 500 bytes per second it takes 8ms to send the acknowledgement.
Of course here too we encounter 250ms communication channel latency.
This means Erie receives the acknowledgement 258ms after Piyush has sent it.
Since 650ms + 258ms = 908ms, it takes 908ms for Erie to receive the acknowledgement from the moment she starts sending a frame (assuming no errors).
.NH 2
.PP
If we were to ignore the transmission delay of the acknowledgement we would save 8ms \*[*]
.FS
this is assuming the "transmission delay" refers 
.B
only 
.R
to the time it takes to transmit the data over the link. The question is however slightly ambiguous.
.FE
We can easily tell that if we were to disregard the 8ms delay associated with the acknowledgement we arrive at 900ms.

.NH 
Question 2
.PP
Lorum Ipsum

.NH
Question 3
.NH 2
Go Back N
.PP
Lorum Ipsum 
.NH 2
Selective Repeat
.PP
Lorum Ipsum
