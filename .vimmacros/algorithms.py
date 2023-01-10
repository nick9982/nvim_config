import os

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
