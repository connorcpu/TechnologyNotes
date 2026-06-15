.TL
Self-Study Assignment Data-Link CSE1405
.AU
Connor Spruit
.AI
Delf University of Technology, The Netherlands

.NH
Question 1
.PP
The chance a station will send if the channnel is free is higher causing more collision.

.NH
Question 2
.PP
In a bit-map protecol the worst case occurs when you are the last station to be allowed to send.
This means that if there are for example 8 station, you have to wait until the end of the current stations are done sending.
in the worst case that's 7 frames, then wait through the contenion period, ofcourse do send in your own contion window.
wait 7 frames, then send your frame.

.NH
Question 3
.PP
If higher priority stations are continuesly sending, or several higher priority stations are sending intermittmitendly but together continues.
Then the lower priority never gets to send.

.NH
Question 4
.PP
pure aloha is quite wastefull and about half the performance of slotted aloha, the higher load factor, the lower the throughput for both.
CSMA performs better under higher load, especiallly for low p values or non-persistant.
CD is used in ethernet because we can listen and transmit at the same time, which is more eficient than CA.
In wireless however CA is required since we cannot send and recieve at the same time 

.NH
Question 5 (backoff)
.PP
At t=7 The channel falls idle, at T=10 C backoff runs out and he starts sending. at t=18 he is done and B can imediatly start.
.PP
The mistake here is that the backoff timer only runs when the channel is idle.

.NH
Question 6 (RTS/CTS)
.PP
Yes, the diagram is A <-> B <-> D <-> C.
When the RTS's are sent fram A & C to B & D respectivly ofcourse everything goes well.
Neither B nor D is aware of the other RTS and sends a CLS, which the other recieving station does
recieve but that's fine. when A & C start transmitting the data clobbers between B & D where no one cares about it.

