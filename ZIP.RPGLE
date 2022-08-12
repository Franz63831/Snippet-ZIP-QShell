      //---------------------------------------------------------------
      //  zipAllFilesInDirectory:
      //---------------------------------------------------------------
      
     dcl-Proc zipAllFilesInDirectory;   
       dcl-PI                               *ind;
         inJahr                             like(w1Jahr) Value;
         inMon                              like(w1Mon ) Value;
       end-PI;
      
      
      // Systembefehle ausführen
        dcl-PR executeCmd                   extpgm('QCMDEXC');
          Command                           like(cmd   ) Const;
          CommandLen                        like(cmdlen) Const;
        end-PR;         
     
        dcl-s cmd                           char(512);
        dcl-s cmdLen                        packed(15:5) inz(%size(cmd));
        
        dcl-s zipDir                        char(64);
        dcl-s Success                       *ind inz(*on);
      
        zipDir = '/home/Franz/WD_' +
                   %editc(inJahr:'X') +
                   %editc(inMon :'X');

        cmd = 'strQSH cmd(''jar cMf /home/Franz/WorkDir' +
                             %editc(inJahr:'X') + %editc(inMon:'X') + '.zip' +
                    ' -C ' + %trim(zipDir) + '/ .'')';
        monitor;
        executeCmd( cmd: cmdlen );
          on-Error;
      //    sndErrorMSg( cmd );
          Success = *off;
        endmon;

        return Success;
      
     end-Proc zipAllFilesInDirectory;

      //---------------------------------------------------------------                                   
    
    
    
     alternativ der Code in None-free:
    
      *---------------------------------------------------------------
      *  zipAllFilesInDirectory:
      *---------------------------------------------------------------
      *
     P zipAllFilesInDirectory...
     P                 B
     d                 PI              N
     d  inJahr                             like(w1Jahr) Value
     d  inMon                              like(w1Mon ) Value
      *
      *
      * Systembefehle ausführen
     d executeCmd      PR                  extpgm('QCMDEXC')
     d  Command                            like(cmd   ) Const
     d  CommandLen                         like(cmdlen) Const            
     
     d cmd             s            512A
     d cmdLen          s             15 5  inz(%size(cmd))
     
     d zipDir          s             64A
     d Success         s               N   inz(*ON)
      *
      *
      /free
         zipDir = '/home/Franz/WD_' +
                   %editc(inJahr:'X') +
                   %editc(inMon :'X');

         cmd = 'strQSH cmd(''jar cMf /home/Franz/WorkDir' +
                             %editc(inJahr:'X') + %editc(inMon:'X') + '.zip' +
                    ' -C ' + %trim(zipDir) + '/ .'')';
         monitor;
         executeCmd( cmd: cmdlen );
           on-Error;
         // sndErrorMSg( cmd );
           Success = *off;
         endmon;

         return Success;
       /end-free
       
     P zipAllFilesInDirectory...
     P                 E

      *---------------------------------------------------------------     
               
