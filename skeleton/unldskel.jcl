//&USRPFX.U JOB (DB2UNLOAD),'UNLOAD',CLASS=A,MSGCLASS=A,       
//         TIME=1440,NOTIFY=&SYSUID                           
//* DELETE DATASETS                                           
//STEP01   EXEC PGM=IEFBR14                                   
//DD01     DD DISP=(MOD,DELETE,DELETE),                       
//            UNIT=SYSDA,                                     
//            SPACE=(TRK,(1,1)),                              
//            DSN=&USRPFX..DB2.PUNCH.&JOBNAME                 
//DD02     DD DISP=(MOD,DELETE,DELETE),                       
//            UNIT=SYSDA,                                     
//            SPACE=(TRK,(1,1)),                              
//            DSN=&USRPFX..DB2.UNLOAD.&JOBNAME                
//*                                                           
//* RUNNING DB2 EXTRACTION BATCH JOB FOR AWS DEMO             
//*                                                           
//UNLD01   EXEC PGM=DSNUTILB,REGION=0M,                       
//         PARM='<db2_ssid>,UNLOAD'                                 // Update
//STEPLIB  DD  DISP=SHR,DSN=DSNC10.DBCG.SDSNEXIT                    // Update
//         DD  DISP=SHR,DSN=DSNC10.SDSNLOAD                         // Update
//SYSPRINT DD  SYSOUT=*                                         
//UTPRINT  DD  SYSOUT=*                                         
//SYSOUT   DD  SYSOUT=*                                         
//SYSPUN01 DD  DISP=(NEW,CATLG,DELETE),                         
//             SPACE=(CYL,(1,1),RLSE),                          
//             DSN=&USRPFX..DB2.PUNCH.&JOBNAME                  
//SYSREC01 DD  DISP=(NEW,CATLG,DELETE),                         
//             SPACE=(CYL,(10,50),RLSE),                        
//             DSN=&USRPFX..DB2.UNLOAD.&JOBNAME                 
//SYSPRINT DD SYSOUT=*                                          
//SYSIN    DD *                                                 
 UNLOAD                                                         
 DELIMITED COLDEL ','                                           
 FROM TABLE &TABNAME                                            
 UNLDDN SYSREC01                                                
 PUNCHDDN SYSPUN01                                              
 SHRLEVEL CHANGE ISOLATION UR;                                  
/*                                                              
//*                                                                 
//* FTP TO AMAZON S3 BACKED FTP SERVER IF UNLOAD WAS SUCCESSFUL     
//*                                                                 
//SFTP EXEC PGM=BPXBATCH,COND=(4,LE),REGION=0M                      
//STDPARM DD *                                                      
SH cp "//'&USRPFX..DB2.UNLOAD.&JOBNAME'"                            
  &TABNAME..csv;                                                    
echo "ascii             " >> uplcmd;                                
echo "PUT &TABNAME..csv " >>>> uplcmd;                              
sftp -b uplcmd -i .ssh/id_rsa &FTPUSER.@&FTPSITE;                   
rm &TABNAME..csv;                                                   
//SYSPRINT DD SYSOUT=*                                              
//STDOUT DD SYSOUT=*                                                
//STDENV DD *                                                       
//STDERR DD SYSOUT=*                         
//* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//* SPDX-License-Identifier: MIT-0                                         
