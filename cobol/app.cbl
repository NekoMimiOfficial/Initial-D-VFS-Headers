       IDENTIFICATION DIVISION.
       PROGRAM-ID. IDSS-MAIN.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile ASSIGN TO "/usr/share/idss/doc.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD InputFile.
       01 InputRecord PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-EOF PIC X(1) VALUE 'N'.
           88 EndOfFile VALUE 'Y'.

       01 WS-ARGUMENT PIC X(256).

       PROCEDURE DIVISION.
       100-MAIN-LOGIC.
           ACCEPT WS-ARGUMENT FROM COMMAND-LINE.
           
           IF FUNCTION TRIM(WS-ARGUMENT) = "--version" THEN
               DISPLAY "v1.0.2"
           ELSE IF FUNCTION TRIM(WS-ARGUMENT) = "--docs" THEN
               PERFORM 200-PRINT-DOCS
           ELSE
               DISPLAY "Initial D street stage VFS headers"
               DISPLAY "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
               DISPLAY " ^ ^  | IDSS VFS Headers"
               DISPLAY "=UwU= | email               year license"
               DISPLAY " w w  | nekomimi@tilde.team 2025 Nekocense (c)"
               DISPLAY ""
               DISPLAY "--version: display version of the headers"
               DISPLAY "--docs:    display simple docs for headers"
           END-IF.
           
           STOP RUN.

       200-PRINT-DOCS.
           DISPLAY "Initial D street stage VFS headers"
           DISPLAY "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

           OPEN INPUT InputFile

           PERFORM UNTIL EndOfFile
               READ InputFile
                   AT END
                       SET EndOfFile TO TRUE
                   NOT AT END
                       DISPLAY InputRecord
               END-READ
           END-PERFORM
           DISPLAY " "
           DISPLAY "Sponsored by the nerds and cute catgirrrrs :3"

           CLOSE InputFile.
