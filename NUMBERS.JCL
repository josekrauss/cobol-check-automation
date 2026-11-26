//NUMBERSJ JOB 1,NOTIFY=&SYSUID
//*******************************************************
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=&SYSUID..CBL(CBL0001),DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(CBL0001),DISP=SHR
//*******************************************************
// IF RC = 0 THEN
//*******************************************************
//RUN     EXEC PGM=NUMBERS
//STEPLIB   DD DSN=&SYSUID..LOAD,DISP=SHR
//ACCTREC   DD DSN=&SYSUID..DATA,DISP=SHR
//PRTLINE   DD SYSOUT=*,OUTLIM=15000
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//*******************************************************
COBOL Programming
Course #4 3.2.0|
260924-1126
[30/44]
// ELSE
// ENDIF
