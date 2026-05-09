:- consult(facts).
:- use_module(library(lists)).

% plan(-Plan)

plan(plan(Morning, Evening, Night)) :-

    findall(E, employee(E), Employees),

    build_shift(
        morning,
        Employees,
        Remaining1,
        Morning
    ),

    build_shift(
        evening,
        Remaining1,
        Remaining2,
        Evening
    ),

    build_shift(
        night,
        Remaining2,
        [],
        Night
    ),

    !.

% build_shift(+Shift,+Available,-Remaining,-Schedule)

build_shift(
    Shift,
    Available,
    Remaining,
    Schedule
) :-

    active_workstations(
        Shift,
        Workstations
    ),

    assign_workstations(
        Workstations,
        Shift,
        Available,
        Remaining,
        Schedule
    ).

% active_workstations(+Shift,-Stations)

active_workstations(Shift, Stations) :-

    findall(
        workstation(Name,Min,Max),
        (
            workstation(Name,Min,Max),
            \+ fact(workstation_idle(Name,Shift))
        ),
        Stations
    ).

% assign_workstations(
%   +Workstations,
%   +Shift,
%   +Available,
%   -Remaining,
%   -Schedule
% )

assign_workstations(
    [],
    _,
    Remaining,
    Remaining,
    []
).

assign_workstations(
    [workstation(Name,Min,Max)|RestStations],
    Shift,
    Available,
    Remaining,
    Schedule
) :-

    assign_workers(
        Available,
        Shift,
        Name,
        Min,
        Max,
        Workers,
        AfterWorkers
    ),

    assign_workstations(
        RestStations,
        Shift,
        AfterWorkers,
        Remaining,
        RestSchedule
    ),

    Schedule =
    [workstation(Name,Workers)|RestSchedule].

% assign_workers(
%   +Available,
%   +Shift,
%   +Station,
%   +Min,
%   +Max,
%   -Workers,
%   -Remaining
% )

assign_workers(
    Available,
    Shift,
    Station,
    Min,
    Max,
    Workers,
    Remaining
) :-

    between(Min, Max, Count),
    choose_workers(Available, Count, Workers),

    valid_workers(
        Workers,
        Shift,
        Station
    ),

    subtract(
        Available,
        Workers,
        Remaining
    ).

% valid_workers(+Workers,+Shift,+Station)

valid_workers([], _, _).

valid_workers(
    [Worker|Rest],
    Shift,
    Station
) :-

    \+ fact(avoid_shift(Worker, Shift)),

    \+ fact(avoid_workstation(Worker, Station)),

    valid_workers(
        Rest,
        Shift,
        Station
    ).

% fact(:Goal)

fact(Goal) :-

    current_predicate(_, Goal),
    call(Goal).

% choose_workers(+Available, +Count, -Workers)

choose_workers(_, 0, []).

choose_workers([Worker|Available], Count, [Worker|Workers]) :-

    Count > 0,
    NextCount is Count - 1,

    choose_workers(Available, NextCount, Workers).

choose_workers([_|Available], Count, Workers) :-

    Count > 0,

    choose_workers(Available, Count, Workers).
