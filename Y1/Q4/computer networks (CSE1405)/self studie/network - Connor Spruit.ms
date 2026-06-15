.TL
Self-Study Assignment Data-Link CSE1405
.AU
Connor Spruit
.AI
Delf University of Technology, The Netherlands

.NH
Question 1
.PP
A | 16 | 4  | 22
B | 11 | 15 | 18
C | 8  | 12 | 21
D | 9  | 13 | 22
E | 18 | 2  | 21
F | 22 | 6  | 17
G | 18 | 12 | 11

.NH
Question 2
.PP
every entry in the colmn gets +1.

.NH
question 3
.PP
A will forward data to B thinking it can forward it to C, any data B tries to send to C will not arive however.
B will then ask A if it knows how to get to C, which it does so B forwards data destined for C to A and A sends it to B.
A will subsecuently increase it's distance vector wich will propegate B's distance vector and so forth.
To prevent this you should store the whole path taken to get to the destination.

.NH
Question 4
.PP
A -2- E -1- F -6- B -3- H -2- I -3- D
            \           /    /
             \_3_ C _2_/    /
                   \_____3_/

.NH
Question 4 (link state rounting)
.PP
C | cost | outgoing line
F | 3    | F
H | 2    | H
I | 3    | I
A | 6    | F
B | 5    | H
C | 0    | C
D | 6    | I
E | 4    | F

.NH
Question 5 (link state Q3)
.PP
The message sent is remH? 
And then since we are doing link state rounting all the routers update their internal maps and compute a new route.
This would effect any node in C's routing table on outgoing line H (since the faster route to H was directly over H).
This means the H route is removed, and the route to B via H is r-routed to go over F with a cost of 9.

.NH
Question 6 (CIDR 1)
.PP
So as we can see Splinter can route any IP address;
Leonardo can route any address that follows 101.45.6.XXX;
Michelangelo can only handle 101.6.0.3;
As such:
101.6.0.3 -> Michelangelo   
101.6.0.4 -> splinter   
101.45.6.254 -> Leonardo   
166.1.33.5 -> splinter   
166.1.0.7 -> splinter    

.NH
Question 7 (CIDR 2)
.PP
leonardo -> 101.45.6.XXX
michelangelo -> 101.6.0.3
donatello -> 166.1.XXX.XXX
raphael -> 166.1.0<X<15.XXX

101.6.0.3 -> michelangelo  
101.6.0.4 -> splinter 
101.45.6.254 -> leonardo 
166.1.33.5 -> donalello 
166.1.0.7 -> raphael
