MATLAB Builder JA Read Me

1. Prerequisites for Deployment 

. Verify the MATLAB Compiler Runtime (MCR) is installed and ensure you    
  have installed version 7.15. 

. If the MCR is not installed, run MCRInstaller, located in:
 
  <matlabroot>*/toolbox/compiler/deploy/glnxa64/MCRInstaller.bin

  For more information on the MCR Installer, see the MATLAB Compiler 
  documentation.  

. Ensure you have the version (1.6.0) of the Java Runtime Environment (JRE). See section 
  5A.

. core.jar must be included in your CLASSPATH.

. javabuilder.jar must be included in your CLASSPATH.
  
 
2. Files to Deploy and Package

-core.jar
-MCRInstaller.bin 
   - include when building component by clicking "Add MCR" link 
     in deploytool
-Javadoc   
   - javadoc for core is in the doc directory. While  
     distributing the javadoc, this entire directory should be distributed.
-This readme file


3. Resources

To learn more about:			See:
=================================================================================
Deploying Java applications on the Web 	MATLAB Builder JA User's Guide
Examples of Java Web Applications 	Application Deployment Web Example Guide      


4. Definitions

For a complete list of product terminology, go to 
http://www.mathworks.com/help and select MATLAB Builder JA.



* NOTE: <matlabroot> is the directory where MATLAB is installed on the target machine.


5. Appendix 

A. On the target machine, add the MCR directory to the system path    
   specified by the target system's environment variable. 


    i. Locate the name of the environment variable to set, using the  
       table below:

    Operating System        Environment Variable
    ================        ====================
    Windows                 PATH
    Linux                   LD_LIBRARY_PATH
    Mac                     DYLD_LIBRARY_PATH


     ii. Set the path by doing one of the following:

        NOTE: <mcr_root> is the directory where MCR is installed
              on the target machine.         
 
        On Windows systems:

        . Add the MCR directory to the environment variable by opening 
        a command prompt and issuing the DOS command, specifying either 
        win32 or win64:

            set PATH=<mcr_root>\v715\runtime\{win32|win64};%PATH% 

        Alternately, for Windows, add the following pathname:
            <mcr_root>\v715\runtime\{win32|win64}
        to the PATH environment variable, specifying either win32 or  
        win64, by doing the following:
            1. Right click Computer from Start Menu.
            2. Click Properties.
            3. Click Advanced System Settings.
            4. Click Environment Variables.   

        On Linux or Mac systems:

        . Add the MCR directory to the environment variable by issuing 
          the following commands:

        Linux
            setenv LD_LIBRARY_PATH
                <mcr_root>/v715/runtime/glnx86:
                <mcr_root>/v715/sys/os/glnx86:
                <mcr_root>/v715/sys/java/jre/glnx86/jre/lib/i386/native_threads:
                <mcr_root>/v715/sys/java/jre/glnx86/jre/lib/i386/server:
                <mcr_root>/v715/sys/java/jre/glnx86/jre/lib/i386
            setenv XAPPLRESDIR <mcr_root>/v715/X11/app-defaults

        Linux x86-64
            setenv LD_LIBRARY_PATH
                <mcr_root>/v715/runtime/glnxa64:
                <mcr_root>/v715/sys/os/glnxa64:
                <mcr_root>/v715/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:
                <mcr_root>/v715/sys/java/jre/glnxa64/jre/lib/amd64/server:
                <mcr_root>/v715/sys/java/jre/glnxa64/jre/lib/amd64 
            setenv XAPPLRESDIR <mcr_root>/v715/X11/app-defaults
                
        Maci64
            setenv DYLD_LIBRARY_PATH
                <mcr_root>/v715/runtime/maci64:
                <mcr_root>/v715/sys/os/maci64:
                <mcr_root>/v715/bin/maci64:
                /System/Library/Frameworks/JavaVM.framework/JavaVM:
                /System/Library/Frameworks/JavaVM.framework/Libraries    
            setenv XAPPLRESDIR <mcr_root>/v715/X11/app-defaults


        NOTE: To make these changes persistent after logout on Linux or 
              Mac machines, modify the .cshrc file to include this  
              setenv command.
        NOTE: On Windows, the environment variable syntax utilizes 
              backslashes (\), delimited by semi-colons (;). 
              On Linux or Mac, the environment variable syntax utilizes   
              forward slashes (/), delimited by colons (:).  
        NOTE: On Maci64, ensure you are using 64-bit JVM.
