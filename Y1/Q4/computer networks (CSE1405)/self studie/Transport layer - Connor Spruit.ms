.TL
Self-Study Assignment Data-Link CSE1405
.AU
Connor Spruit
.AI
Delf University of Technology, The Netherlands

.NH
Question 1
.PP
Since the sequence number is initial sequence number plus the previously sent bytes we end up with:
15+23+567 which means the sequence number by the time we arive at segment 3 is 605, plus 1 for the handshake, 606.

.NH
Question 2 
.PP
The ack number is the initial sequence number of the partner (alice, 15) plus the amount of bytes recieved.
It is worth noting the amount of bytes recieved in the message you are ack'ing is also counted.
Therefore: 15+23+567+117=722, plus 1 for the handshake so 723
Alternatively we could be using piggybacking.
In this case Alice sends bob 590 bytes so bob is going to ack with 605.
then bob sends 71 bytes with ISQN 102. this means Alice should ack with 173, This number will be the ack number encoded into the third segment she sends to bob.
But don't forget the handshake so 174.

.NH
Question 3 (forbidden region)
.PP
So you've got 2^20 available numbers and ever second we 'use up' 2^10 of those.
2^20 / 2^10 = 2^10 = 1024 seconds.

.NH
Question 4 (forbidden region 2)
.PP
So the way to graph this is with the initial sequence number line with a directional cooeficient of 1024.
The tosh data goes with an D.R. of 5., at t=1024 the initial sequence number line hits 2^20 and resets to 0 with the same rate of growth.
Since the network can retain data for 10 sec we should not send anymore if the seqence number is 10 sec behind the the clock.
basically T=10sec -> T=10240.
in essence, we can transmit for up to 1014 sec. then we should halt and resyncronize the sequence number.

.NH
Question 5 (congestion)
.PP
The threshold at the start of the trace is where the slow start cuts off and transitions to linear scaling. this is around 32.
if the trasmition of number ~25 fails the congestion window is moved to roughly 25. as it's divided by the multiplicative factor.

.NH
Question 6 (congestion 2)
.PP
So after the reaching the initial threshold there are 5 more successfull ack's with a linear addetive increase of 4kb, so +20kb means 52kb.
Then a packed is lost so the new congestion window is set to 1/4th of that, which is 13. The new threshold is 1/2 of the old congestion window so 26kb.
Then there are 3 more steps. Since the window size is under the threshold we switch to slow start, so for every ack we recieve we double the window until we reach the threshold.
so we send the first of the 3 secondary packets which get's ack'ed successfully so we double to 26.
then we increase linearly by 4 for 2 rounds, so +8 in total for 34kb.

.NH
Question 7 (flow control)
.PP
So if batman sends say 10mb at a rate of 5mbps the buffer is full after 8/5 sec. 
after 1 sec superman processes 1 byte so we surive 1/5 of a sec longer. than that, at t=9/5 sec the buffer is full again.
depending on exactly how the byte is processed we might drop the byte sent at t=2 sec or the buffer might just about be clear.
so either 9 or 10mb.

.NH
Question 8 (flow control 2)
.PP
so to send the 10mb I'm guessing we'd send it would take 2 sec. then we slow down to 1mbps so 5 more sec.
total time is then 7 sec.

