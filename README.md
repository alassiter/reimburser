### NOTES

- This project was intended only to be used as an rspec test target.

- I started with a Rails project, then decided I didn't need a database to accomplish this task. I remove unneeded Rails libs, but left in some configuration files. #TODO: Remove unneeded config files

### JOURNAL
#### November 5, 2018
- I thought I wouls start a journal, though I'm wrapping up the assignment
- A lot of what I have currently are different ideas fleshed out
- I finally (as of now) decided that really, I just need to expand the dates, then calculate each reimbursement then add them together
- I'm trying to decide how many objects to create
  + ~~Project (a collection of TravelDays and FullDays ?)~~
  + ProjectSet (a collection of projects)
  + ~~? TravelDay (travel_day.low_reimbursement, travel_day.high_reimbursement)~~
  + ~~? FullDay (full_day.low_reimbursement, full_day.high_reimbursement)~~
- I can't calculate days per project as there might be overlapping days
- So I'm thinking the majority of work will be done in the ProjectSet Class at first, then if I have time I may extract things out
- I'm thinking about something like 
  + `{ [date as key] => :low, [date] => :high...}`
- I want to use a hash, but I realize, i'll be overwriting the key if I run into a colliding date. Since a `:high` date takes priority, i'll need to check if the date I'm about to append exists and if so, pick `:high or :low`
- It comes to mind that while for this exercise DateTime will work for keys, I could get away with just a date. or perhaps an integer representing the DateTime, which given a lot of calculations I expect would perform better
- I ran into something - I can't compare if `:high > :low` because if I only use symbols, alphabetically, that will never be true. So, I plan to use constants where `LOW = 0` and `HIGH = 1`, then set the value to the constant that I can use in a comparison
- Scratch that... easier to set `CITY_VALUES = { low: 0, high: 1 }` then I can do
  + `CITY_VALUES[city_value]` where `value` is one of :high or :low