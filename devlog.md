Devlog


05/01/2026 8:03 AM
I started by defining the basic data model for the scheduler. 


05/02/2026 10:24 AM
I built the main plan/1 predicate to generate a full schedule for morning, 
evening, and night. The scheduler gathers all employees first, then passes the 
remaining employee list from one shift to the next.


05/03/2026 9:15 AM
I added logic for finding active workstations for each shift. 
This made it possible to skip  workstations marked idle, such as 
workstation 3 during the morning shift.


05/04/2026 2:37 PM
I implemented recursive workstation assignment. Each workstation chooses a valid 
number of workers between its minimum and maximum staffing requirements.


05/05/2026 10:08 PM
I added checks for employee restrictions. Workers are now rejected if they are 
assigned to a shift or workstation they should avoid.


05/08/2026 9:54 PM
I finished the worker selection logic and removed assigned workers from the available 
pool after each assignment. The final version generates a complete plan where every 
employee is used once, idle stations are skipped, 
and all listed restrictions are respected.
