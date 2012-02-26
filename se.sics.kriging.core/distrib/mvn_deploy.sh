#!/bin/bash

# This script will deploy the package to the specified repository

mvn deploy:deploy-file -X -Dfile=core.jar\
 -DgroupId=se.sics.kriging\
 -DartifactId=matlab-kriging\
 -Dversion=0.3\
 -Dpackaging=jar\
 -DrepositoryId=sics-release-repository\
 -DgeneratePom=true\
 -Durl=scpexe://kompics.sics.se/home/maven2/repository

# -Durl=http://kompics.sics.se/maven/repository

mvn deploy:deploy-file -Dfile=javabuilder.jar\
 -DgroupId=se.sics.kriging\
 -DartifactId=matlab-javabuilder\
 -Dversion=2011a\
 -Dpackaging=jar\
 -DrepositoryId=sics-release-repository\
 -DgeneratePom=true\
 -Durl=scpexe://kompics.sics.se/home/maven2/repository

