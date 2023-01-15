import os
import stat

def findAndRunExecutable():
    executable = stat.S_IEXEC | stat.S_IXGRP | stat.S_IXOTH
    for filename in os.listdir('.'):
        if os.path.isfile(filename):
            st = os.stat(filename)
            mode = st.st_mode
            if mode & executable:
                os.system("./"+filename)

def parseDirectory(directory):
    idx = 0
    for i in reversed(directory):
        if i == '/':
            return directory[-idx:]
        idx+=1
    return directory

def bufferDirectory(directory):
    idx = 0
    for i in reversed(directory):
        if i == '/':
            directory = directory[:-idx-1]
            break
        idx+=1
    try:
        os.chdir(directory)
        os.system("pwd")
    except:
        print("The directory of this buffer does not exist.")
