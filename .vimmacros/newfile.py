import os
from algorithms import *
import sys

directory=bufferDirectory(sys.argv[1])
def createNewFile():
    try:
        os.chdir(directory)
        fileName = str(input())
        print("Create new file: "+fileName)
        try:
            os.system("touch "+fileName)
        except:
            print("This filename is invalid")
    except:
        print("The directory of this buffer does not exist")
