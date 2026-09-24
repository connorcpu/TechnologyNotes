.TL
CSE2115 Peer Assignment 2 – Domain Modeling
.AU
REDACTED
.AI 
Technische Universiteit Delft

.NH
Bounded Contexts

.NH 2
Eligibility & Enrollment
.PP
This context is responsible for determining whether a student is allowed to participate in the course project. It checks whether the student satisfies the required entry conditions before they can access the project or become part of a team. In exceptions, the program coordinator can manually override the eligibility decision.

.NH 2
Proposal Management
.PP
This context handles project proposals submitted by clients. Clients can create proposals and make changes to them until the deadline. The coordinator reviews submitted proposals and decides whether they should be accepted or rejected. Changes made to a proposal are logged so that the coordinator can see how it has been modified over time.

.NH 2
Team Formation
.PP
This context covers the process of students finding a project and creating a team. Eligible students can indicate interest in available projects and form a team with other interested students. Students who already formed a team outside the system can also register that team directly. The context enforces rules such as the standard team size (5 in this case) and the maximum number of projects in which a student may express interest (3 in this case).

.NH 2
Supervision Assignment
.PP
This context assigns staff to teams after those teams have been confirmed. Each team is connected to one supervisor and one TA. Once assigned, the supervisor and TA can access the information they need to follow the team's progress.

.NH 2
Contract & Payment
.PP
This context manages the legal side of a project. After a proposal has been accepted, a contract is generated using the government-provided template. The client may make limited changes before the contract is signed by the required people, including the client, students, and coordinator.

.NH 2
Feedback & Grading
.PP
This context handles assessment at the end of the project. Supervisors and TAs can provide feedback using the appropriate rubric as well as written comments. Their input is combined into a final result for each student. The coordinator can review and adjust the result before confirming it and exporting the final grade to MyTUDelft.

.NH
Core Contexts
.PP
We consider 
.B
Team Formation
.R
, 
.B
proposal managment
.R
, and 
.B
Feedback & Grading
.R
to be the core contexts.

.B
Proposal managment
.R
is core because it's the driving factor behind this project. It's one of the most important elements as it's one of the few elements that cannot be handled extrnally and brings the most quality of life to users.

.B
Team formation
.R
is core because it contains much of the specific requirements that the course needs. Matching students to projects, keeping track of project interest, and forming valid teams are the main and most important parts of how students interact with the system.

.B
Feedback & Grading
.R
is core because it handles the final academic outcome of the project. Feedback from different staff members has to be combined correctly, while the coordinator still needs final control over the grade before it is sent to MyTUDelft.

The remaining contexts -
.B
Eligibility & Enrollment
.R
, 
.B
Contract & payment
.R
, and 
.B
Supervision Assignment
.R
- are supporting contexts. 
They are necessary for the overall workflow, but their responsibilities are relatively standard administrative tasks such as checking eligibility, managing project information, and assigning staff. 
They are therefore less specific to this particular course than the three core contexts.
These contexts could be handled externally by for example, brightspace or simple E-mailing.
They are more should have's and could have's instead of must haves.

.NH
Cohesian and Coupling
.NH 2
Context Map
.PS
ellipse wid 2 "feedback & grading";
left
move
move
down
move
ellipse same "supervision assignement";
right
move 
move 
move
ellipse same "contract & payment";
left
move 
move 
move
move
move
down
move 
ellipse same "Team formation";
down
move
left
move
ellipse same "Proposal management";
right
move
move
move
move
move
move
ellipse same "eligibility & enrollment";
arrow from 1st ellipse to 2nd ellipse chop
arrow from 2nd ellipse to 4th ellipse chop
arrow from 3rd ellipse to 4th ellipse chop
arrow from 4th ellipse to 5th ellipse chop
arrow from 4th ellipse to 6th ellipse chop;
.PE

.NH 2
Explanation of Dependencies
.PP
.IP \[bu]
Team formation relies on eligibility because since only eligible students should be able to join teams
.IP \[bu]
Team formation relies on proposal management since students can show interest in projects and form a group that way. Or when they sign up as a group they do so with a preference for a number of given proposals. In both cases the proposals first need to be accepted.
.IP \[bu]
Supervision can only be assigned to a team which is formed, therefore supervision assignement relies on team formation.
.IP \[bu]
contract & payment relies on team formation since contracts are between a team. this also implies a depency on proposal management and eligibility. Since only eligible students can sign a contract with regards to a proposal which has been accepted this checks out.
.IP \[bu]
feedback & grading clearly relies on supervision assignement since the supervisors need to provide feedback to their assigned teams. This implies a depency with team formation, which makes sense since a team needs to be formed before they can recieve feedback.

.NH 2
Alternative Designs

.NH 3
Alternative 1
.PP
It would in theory be possible to combine contract handling and proposal management.
It would reduce the amount of contexts we have and eliminate the interactions between these two contexts.
On the other hand the cohesion would be lower since this new context would encapsulate the modules less well.
Managing proposals mostly pertains to the submitting, reviewing and displaying of proposals and their details.
Whereas contracts would mostly be a function concerning the collecting of signatures and the managing of contracts, after groups have been formed, beyond the 'proposal' phase.
In addition the security requirements are much tighter.
Because of these reasons we would argue that contract & payment should not be incorperated into the proposal management context.

.NH 3
Alternative 2
.PP
Another option could be to split team formation into the two ways of forming a team.
You could have "interest matching" which keeps track of what students are interested in what proposals.
While "team formation" would be just for teams signing up as a whole after forming the team in the real world.
Since these 2 processes are technically two entirely different ways of forming a team we would argue it actually improves cohesion.
The reason we chose to keep these as one node is mostly because it would complicate the context map massively since a lot of things rely on teams being formed.
Since they are also boch trying to achieve the same thing, reconsialing interested indiviual students with interested teams would require a lot of comunication between the contexts.
For these reasons we decided they should be kept as one singular node.
