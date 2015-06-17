       identification division.
       program-id. autoinc.

       environment division.
       input-output section.
       file-control.
           select optional idfile assign to '/tmp/autoinc.data'
               file status is file-status
               organization is line sequential.

       data division.
       file section.
       fd idfile.
          01 current-id binary-long unsigned.

       working-storage section.
       01 file-status pic 9(2).
       01 nl pic x value x'0a'.

       procedure division.
       open input idfile
       if file-status < 10 then
           read idfile end-read
           add 1 to current-id
           display "Updated id=", current-id upon syserr
       else
           display "New file: Initializing id=", current-id upon syserr
           move 1 to current-id
       end-if
       close idfile

       open output idfile
           if file-status < 10 then
               write current-id
               if file-status > 9 then
                   display "Failed to write new current id" upon syserr
               end-if
           else
               display "Failed to open id file: error=", file-status upon syserr
           end-if
       close idfile

       display
           "Content-type: text/html" nl
           "Status: 200 OK" nl
           nl
           current-id
       end-display

       goback.

       end program autoinc.
