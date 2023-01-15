from includecpp import *
import os
import sys

bufferDirectory(sys.argv[1])
while True:
    parentDirectory = parseDirectory(os.getcwd())
    if parentDirectory == "/": break
    if parentDirectory == "src" or parentDirectory == "Source" or parentDirectory == "source":
        try:
            os.chdir("../Build")
            findAndRunExecutable()
        except:
            print("The directory '../Build' does not exist. Try to build your project")
        break
    os.chdir("../")
