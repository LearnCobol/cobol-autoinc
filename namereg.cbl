       identification division.
       program-id. namereg.

       environment division.
       input-output section.
       file-control.
           select webinput assign to KEYBOARD
               file status is web-read-status.
           select optional authfile assign to '/tmp/auth.data'
               file status is auth-status
               organization is line sequential.

       data division.
       file section.
       fd webinput.
          01 chunk-of-post pic x(255).
       fd authfile.
          01 auth-entry pic x(255).

       working-storage section.
       01 request-method pic x(20).
       01 query-string pic x(255).
       01 web-read-status pic 9(2).
       01 auth-status pic 9(2).
       01 nl pic x value x'0a'.

       procedure division.
       accept request-method from environment 'REQUEST_METHOD' end-accept
       accept query-string from environment 'QUERY_STRING' end-accept
       if request-method = 'POST'
           display "Got POST request" upon syserr
           open input webinput
           if web-read-status < 10 then
               read webinput end-read
               if web-read-status > 9 then
                   move spaces to chunk-of-post
                   display chunk-of-post upon syserr
               end-if
           end-if
           close webinput

           move chunk-of-post to auth-entry
           open extend authfile
               if auth-status < 10 then
                   write auth-entry
                   if auth-status > 9 then
                       display "Failed to write new auth entry" upon syserr
                   end-if
               else
                   display "Failed to append to auth file: error=", auth-status upon syserr
               end-if
           close authfile

           display
               "Content-type: text/html" nl
               "Status: 201 Created" nl
               nl
               function trim (chunk-of-post trailing)
           end-display
       else
           display "Got GET request" upon syserr
           display
               "Content-type: text/html" nl
               "Status: 200 OK" nl
               nl
               "Query string: "
               function trim (query-string trailing)
           end-display
       end-if

       goback.

       end program namereg.
