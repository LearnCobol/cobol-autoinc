       identification division.
       program-id. hello.

       environment division.

       data division.
       working-storage section.
       01 name pic x(255).

       procedure division.
           display "Hi! What's your name? " with no advancing
           accept name
           display "Hello, ", function trim (name trailing), "!"
           end-display.
