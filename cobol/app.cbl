       IDENTIFICATION DIVISION.
       PROGRAM-ID. IDSS-MAIN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ARGUMENT  PIC X(256).

       PROCEDURE DIVISION.
       ACCEPT WS-ARGUMENT FROM COMMAND-LINE.
           
       IF FUNCTION TRIM(WS-ARGUMENT) = "--version" THEN
           DISPLAY "v1.0.0"
       ELSE IF FUNCTION TRIM(WS-ARGUMENT) = "--docs" THEN
           DISPLAY "Initial D street stage VFS headers"
           DISPLAY "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
           DISPLAY "Docs for using the headers"
           DISPLAY "idk man, read the headers lul"
           DISPLAY ""
           DISPLAY "Sponsored by the nerds and cute catgirrrrs :3"
       ELSE
           DISPLAY "Initial D street stage VFS headers"
           DISPLAY "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
           DISPLAY "--version: display version of the installed headers"
           DISPLAY "--docs:    display simple docs for using headers"
       END-IF.
           
       STOP RUN.
