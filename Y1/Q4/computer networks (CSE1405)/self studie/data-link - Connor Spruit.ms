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
So Aniket sends frame 1 of size 150 bytes at t=0, 0.3 seconds later she sends frame 2, the timer is started on 500ms at t=0.6.
Then frame 2 is lost. at t=0.6 frame 3 is sent. after frame 3 arrives thorsten sends a negative ack which arives at t=1.25.
at t=0.9 the next frame could be sent, since the timer started at t=0.6 it overruns at t=1.1. at t=1.25 the negative ack arives so the frame is already resent due to the timer overrun.

.NH
Question 3
.PP
Go Back N
      | go back N | Selective repeat 
------|-----------|---------
600ms | 5,6,7,8,9 | 5
210ms | 5,6,7,8   | 5
150ms | 5,6,7     | 5

.NH 
Question 4 (sliding window frames)
.PP
It takes 0.5 sec to send 1 frame, that means to send the 4 frames in the window, it takes 2 sec. 
230ms after the last byte of the last frame leaves theoden, faramir recieves it.
The first ack is sent 0.73 sec after theoden started sending the first frame.
it arives exactl 1 sec after theoden started sending thi first frame.
since 1 is less then 2. yes, the ack arives before the 4e frame is done transmitting

.NH
question 5 (sliding window)
.LP
Sliding window with window size 1 is pracitally stop-and-wait. 
To this end, a frame takes 1/16 sec to transmit, and 540ms more to recieve the ack. 
So it takes 602.5ms to send one frame, then the next frame can be sent.
The throughput is hence 1 frame every 602.5ms or 1.66 frames per second.
Assuming the channel can handle 2-way communication at the same time,
.LP
for a window of size 7, the first ack arives at t=602.5ms. 
at t=437.5 the 7th frame was done sending, the moment the ack arives one more frame is sent, and 1 more with the next ack.
since no time period is given we cannot determine an average, we can however determine that after the initial spike in sent frames,
all frames from frame 8 onwards are sent at the same rate as a window size of 1, hence once every 602.5ms or 1.66 frames per sec.
.LP
for a window of size 15, the first ack again arives at t=602.5ms.
at t=937.5ms the last frame was done sending, this means the next frame can be sent right away.
By the time that frame is done sending we should have recieved another ack. this means we can keep sending at the full data rate of 16 frames per sec
.LP
there is no reason why a window of size 127 would act any differnt than a window of size 15. 
therefore, 16 frames per sec.


