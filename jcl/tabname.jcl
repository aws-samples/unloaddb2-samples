//UNLDLIST JOB (DB2UNLOAD),'GETLIST OF TABS',CLASS=A,MSGCLASS=A,               
//         TIME=1440,NOTIFY=&SYSUID                                  
//* Update all the lines tagged with //update marker to desired
//* site specific values.
//*                                                                  
//* UNLOAD ALL THE TABLE NAMES FOR A PARTICULAR SCHEMA               
//*                                                                  
//STEP01  EXEC PGM=IEFBR14                                           
//*                                                                  
//DD1      DD  DISP=(MOD,DELETE,DELETE),                             
//         UNIT=SYSDA,                                               
//         SPACE=(1000,(1,1)),                                       
//         DSN=<USER.TABLIST>                                         // Update 
//*                                                                  
//DD2      DD  DISP=(MOD,DELETE,DELETE),                             
//         UNIT=SYSDA,                                               
//         SPACE=(1000,(1,1)),                                       
//         DSN=<USER.SYSPUNCH>                                        // Update 
//*                                                                  
//UNLOAD  EXEC PGM=IKJEFT01,DYNAMNBR=20                          
//SYSTSPRT DD  SYSOUT=*                   
//* Steplib values should be replaced with users site specific
//* values for users DSN libs.                      
//STEPLIB  DD  DISP=SHR,DSN=DSNC10.DBCG.SDSNEXIT                      // Update
//         DD  DISP=SHR,DSN=DSNC10.SDSNLOAD                           // Update
//         DD  DISP=SHR,DSN=CEE.SCEERUN                               // Update
//         DD  DISP=SHR,DSN=DSNC10.DBCG.RUNLIB.LOAD                   // Update
//SYSTSIN  DD  *                                                
 DSN SYSTEM(<db2_ssid>)                                               // Update
 RUN  PROGRAM(DSNTIAUL) PLAN(<plan_name>) PARMS('SQL') -              // Update
      LIB('DSNC10.DBCG.RUNLIB.LOAD')                                  // Update
 END                                                            
//SYSPRINT DD SYSOUT=*                                          
//*                                                             
//SYSUDUMP DD SYSOUT=*                                          
//*                                                             
//SYSREC00 DD DISP=(NEW,CATLG,DELETE),                          
//            UNIT=SYSDA,SPACE=(32760,(1000,500)),              
//            DSN=<USER.TABLIST>                                      // Update 
//*                                                             
//SYSPUNCH DD DISP=(NEW,CATLG,DELETE),                          
//            UNIT=SYSDA,SPACE=(32760,(1000,500)),               
//            VOL=SER=SCR03,RECFM=FB,LRECL=120,BLKSIZE=1200,     
//            DSN=<USER.SYSPUNCH>                                     // Update
//* Update query to get your desired subset of tables.                          
//SYSIN    DD *                                                  
  SELECT CHAR(CREATOR), CHAR(NAME)                               
    FROM SYSIBM.SYSTABLES                                        
   WHERE OWNER = 'DSN81210'                                          // Update
     AND TYPE = 'T';             
/*
//
//* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//* SPDX-License-Identifier: MIT-0                                         
