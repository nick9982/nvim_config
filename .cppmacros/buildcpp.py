import os
import sys
from includecpp import *

bufferDirectory(sys.argv[1]) 
while True:
    parentDirectory = parseDirectory(os.getcwd())
    if parentDirectory == "/": break
    if parentDirectory == "src" or parentDirectory == "Source" or parentDirectory == "source":
        os.system("cmake -S . -B ../Build")
        try:
            os.chdir("../Build")
            os.system("make")
            findAndRunExecutable()
        except:
            print("The directory 'Build' does not exist.")
        break
    os.chdir("../")


