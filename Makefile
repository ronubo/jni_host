#
# simple makefile to demonstrate building of 
# we don't bother ourselves with sonames, flags etc.
#
# Try not to make all before you fully understood 
#
# Ron Munitz DroidCon Tel-Aviv 2016
#

# basically one would use JAVA_HOME , but for this exercise 
# I would like you to choose your own JAVA folder.
# If you insist, just "make JVM_PATH=$JAVA_HOME"
JVM_PATH ?= /usr/lib/jvm/java-8-oracle

all: classes javah libs

classes:
	javac HelloWorld.java

javah:
	javah HelloWorld

libs:
	gcc -shared -fPIC \
	-I$(JVM_PATH)/include/linux  -I$(JVM_PATH)/include \
	HelloWorld.c  -o libHelloWorld.so 

run:
	java -Djava.library.path=. HelloWorld

.PHONY: clean 
clean:
	# Agressively remove all artifacts including javah generated files
	rm -f HelloWorld.class libHelloWorld.so HelloWorld.h
