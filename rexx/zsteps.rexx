/*REXX - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 
/* 10/27/2021 - added new parms to accomodate ftp */      
/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. */
/** SPDX-License-Identifier: MIT-0                                    */        

Trace "o"                                                               
    parse arg usrpfx ftpuser ftpsite                                    
    Say "Start"                                                         
    Say "Ftpuser: " ftpuser "Ftpsite:" ftpsite                          
    Say "Reading table name list"                                       
    "EXECIO * DISKR TABLIST (STEM LINE. FINIS"                          
    DO I = 1 TO LINE.0                                                  
      Say I                                                             
      suffix = I                                                        
      Say LINE.i                                                        
      Parse var LINE.i schema table rest                                
      tabname = schema !! "." !! table                                  
      Say tabname                                                       
      tempjob= "LOD" !! RIGHT("0000" !! i, 5)                           
      jobname=tempjob                                                   
      Say tempjob                                                       
      ADDRESS ISPEXEC "FTOPEN "                                        
      ADDRESS ISPEXEC "FTINCL UNLDSKEL"                                
      /* member will be saved in ISPDSN library allocated in JCL */    
      ADDRESS ISPEXEC "FTCLOSE NAME("tempjob")"                        
    END                                                                
                                                                       
    ADDRESS TSO "FREE F(TABLIST) "                                     
    ADDRESS TSO "FREE F(ISPFILE) "                                     
                                                                       
exit 0                                                                 
