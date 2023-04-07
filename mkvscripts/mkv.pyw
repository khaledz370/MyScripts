import subprocess
import os
import sys
import PySimpleGUI as psg


def main():
    mainLayout = [
        [
            psg.Text(
                "Select a file",
                expand_x=True,
                justification="center",
            )
        ],
        [
            psg.LBox([], size=(20, 10), expand_x=True, expand_y=True, key="-LIST-"),
            psg.Input(
                visible=False,
                enable_events=True,
                key="myFiles",
                expand_x=True,
            ),
            psg.FilesBrowse(),
        ],
        [psg.Text("Output folder")],
        [psg.Text("select output folder",justification="center",), psg.FolderBrowse(key="outputFolder"),],
        [psg.Button("convert", key="convertTsToMkv")],
        [psg.OK(), psg.Exit()],
    ]
    window = psg.Window("my first app", mainLayout, resizable=True , size=(600,350))

    while True:
        event, values = window.read()
        print(event)
        if event in (psg.WIN_CLOSED, "Exit"):
            break
        if event == "myFiles":
            window["-LIST-"].Update(values["myFiles"].split(";"))
            selectedFilesList = str(values["myFiles"]).split(";")
            
            
        if event == "convertTsToMkv":
            if len(selectedFilesList)>0 and window["outputFolder"]!="" :
                mkvMerge = "C:\Program Files\MKVToolNix\mkvmerge.exe" 
                if not os.path.exists(("{}\\mkvmerge_old").format(values["outputFolder"])):
                    runCommand(('mkdir {}\\mkvmerge_old').format(values["outputFolder"]))
                for index, file in enumerate(selectedFilesList):
                    textMove = "move \"{}\" \"{}\\mkvmerge_old\\{}\""
                    commandMove = textMove.format(file,splitPath(file)["path"],splitPath(file)["file"])
                    # print(commandMove)
                    runCommand(commandMove)
                    #  %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
                    mkvCommandText =  "\"{}\" --output \"{}\\{}.mkv\" \"{}\\mkvmerge_old\\{}\""
                    mkvCommand = mkvCommandText.format(mkvMerge,splitPath(file)["path"],splitPath(file)["wExt"],splitPath(file)["path"],splitPath(file)["file"])
                    print(mkvCommand)
                    runCommand(mkvCommand)
                    
    window.close()


# run cmd commands
def runCommand(cmd, timeout=None, window=None):
    cmd = fixPath(cmd)
    p = subprocess.Popen(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
    )
    output = ""
    for line in p.stdout:
        line = line.decode(
            errors="replace" if (sys.version_info) < (3, 5) else "backslashreplace"
        ).rstrip()
        output += line
        print(line)
        window.Refresh() if window else None  # yes, a 1-line if, so shoot me
    retval = p.wait(timeout)
    return (retval, output)


# getting file dir and name
def splitPath(fullPath):
    head, tail = os.path.split(fullPath)
    fileNameSplit = tail.split('.')
    fullname = {"path": head, "file": tail,"wExt":fileNameSplit[0],"ext":fileNameSplit[1]}
    return fullname

def fixPath(path):
    return path.replace("/", "\\")

if __name__ == "__main__":
    main()
