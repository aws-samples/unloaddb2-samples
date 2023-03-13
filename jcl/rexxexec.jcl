//RUNREXX JOB (CREATEJCL),'RUNS ISPF TABLIST',CLASS=A,MSGCLASS=A,      
//         TIME=1440,NOTIFY=&SYSUID                         
//* Most of the values required can be updated to your site specific
//* values using the command 'TSO ISRDDN' in your ISPF session. 
//* Update all the lines tagged with //update marker to desired
//* site specific values.
//ISPF    EXEC PGM=IKJEFT01,REGION=2048K,DYNAMNBR=25        
//SYSPROC   DD DISP=SHR,DSN=<SYSPROC.LIB>                         //Update 
//SYSEXEC   DD DISP=SHR,DSN=<USER.SYSEXEC.LIB>                    //Update
//ISPPLIB   DD DISP=SHR,DSN=ISP.SISPPENU                          
//ISPSLIB   DD DISP=SHR,DSN=ISP.SISPSENU                          
//          DD DISP=SHR,DSN=<USER.TEST.ISPSLIB>                   //Update
//ISPMLIB   DD DSN=ISP.SISPMENU,DISP=SHR       
//ISPTLIB   DD DDNAME=ISPTABL                               
//          DD DSN=ISP.SISPTENU,DISP=SHR                          
//ISPTABL   DD LIKE=ISP.SISPTENU,UNIT=VIO                         
//ISPPROF   DD LIKE=ISP.SISPTENU,UNIT=VIO                         
//ISPLOG    DD SYSOUT=*,RECFM=VA,LRECL=125                  
//SYSPRINT  DD SYSOUT=*                                     
//SYSTSPRT  DD SYSOUT=*                                     
//SYSUDUMP  DD SYSOUT=*                                     
//SYSDBOUT  DD SYSOUT=*                                    
//SYSTSPRT  DD SYSOUT=*                                    
//SYSUDUMP  DD SYSOUT=*                                    
//SYSDBOUT  DD SYSOUT=*                                    
//SYSHELP   DD DSN=SYS1.HELP,DISP=SHR                      
//SYSOUT    DD SYSOUT=*                                    
//* Input list of tablenames                               
//TABLIST   DD DISP=SHR,DSN=<USER.TABLIST>                         //Update
//* Output pds where the output JCLs will be created                            
//ISPFILE   DD DISP=SHR,DSN=<USER.OUTPUT.JOBGEN>                   //Update     
//* Replace batch_user with the TSO user running the job
//* Replace ftp_user with user id of the ftp destination site
//* Replace ftp_dest_site with ip address of the destination
//SYSTSIN   DD *                                           
ISPSTART CMD(ZSTEPS <batch_user> <ftp_user> <ftp_dest_site>)       //Update
/*                                                         
//  
//* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//* SPDX-License-Identifier: MIT-0                                              
