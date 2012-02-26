#!/bin/bash

# This script will install the package into mvn local repository 

mvn install:install-file -Dfile=core.jar\
 -DgroupId=se.sics.kriging\
 -DartifactId=matlab-kriging\
 -Dversion=0.3\
 -Dpackaging=jar\
 -DgeneratePom=true

mvn install:install-file -Dfile=javabuilder.jar\
 -DgroupId=se.sics.kriging\
 -DartifactId=matlab-javabuilder\
 -Dversion=2011a\
 -Dpackaging=jar\
 -DrepositoryId=sics-release-repository\
 -DgeneratePom=true\

