Prolog_Scheduler

This project generates a daily workstation schedule using SWI-Prolog.

Files:

scheduler.pl - contains core logic

facts.pl - facts provided by example input provided by prof. Salazar

testing.pl - used for testing scheduler.pl implementation, also provided by prof. Salazar

How to Run:

Start SWI-Prolog with the scheduler file:

swipl -s scheduler.pl

Then run:

?- plan(Plan).

To exit SWI-Prolog, run:

?- halt.
