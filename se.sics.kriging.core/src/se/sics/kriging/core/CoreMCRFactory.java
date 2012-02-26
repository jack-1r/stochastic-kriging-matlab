/*
 * MATLAB Compiler: 4.15 (R2011a)
 * Date: Sun Feb 26 14:42:36 2012
 * Arguments: "-B" "macro_default" "-W" "java:se.sics.kriging.core,Kriging" "-T" 
 * "link:lib" "-d" "/home/hieu/workspace/kriging_matlab_code/se.sics.kriging.core/src" 
 * "-w" "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w" 
 * "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w" "enable:demo_license" 
 * "-v" 
 * "class{Kriging:/home/hieu/workspace/kriging_matlab_code/drawGraph.m,/home/hieu/workspace/kriging_matlab_code/mseMin.m,/home/hieu/workspace/kriging_matlab_code/pMSE.m,/home/hieu/workspace/kriging_matlab_code/predictMin.m,/home/hieu/workspace/kriging_matlab_code/SKfiting.m}" 
 */

package se.sics.kriging.core;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class CoreMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "core_2380E8B64796843DE835E1E1487355E7";
    
    /** Component name */
    private static final String sComponentName = "core";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(CoreMCRFactory.class)
        );
    
    
    private CoreMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            CoreMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{7,15,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
