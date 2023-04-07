import subprocess
import os
import sys
import PySimpleGUI as psg


def main():
    tomkvLayout = [
        [psg.Text("convert video to mkv", size=(
            600, 0), justification="center")],
        [
            psg.Text(
                "Select a file",
                expand_x=True,
                justification="center",
            )
        ],
        [
            psg.LBox([], size=(20, 10), expand_x=True,
                     expand_y=True, key="tomkvList"),
            psg.Input(
                visible=False,
                enable_events=True,
                key="myFiles",
                expand_x=True,
            ),
            psg.FilesBrowse(size=(10, 0)),
        ],
        [psg.Text("Output folder")],
        [psg.FolderBrowse(key="outputFolder",size=(15, 0)), psg.Text(
            "select output folder", justification="center",)],
        [psg.Button("convert", key="converToMkv", size=(15, 0))],
    ]

    tomkvTab = [psg.Tab('To Mkv', tomkvLayout)]

    layout = [
        [psg.TabGroup([tomkvTab])],
        [psg.OK(), psg.Exit()]
    ]
    window = psg.Window("my first app", layout,
                        resizable=True, size=(600, 400))

    while True:
        event, values = window.read()
        print(event)
        if event in (psg.WIN_CLOSED, "Exit"):
            break
        if event == "myFiles":
            window["tomkvList"].Update(values["myFiles"].split(";"))
            selectedFilesList = str(values["myFiles"]).split(";")
        
        # convert to mkv   
        if event == "converToMkv":
            if len(selectedFilesList) > 0 and window["outputFolder"] != "":
                mkvMerge = "C:\Program Files\MKVToolNix\mkvmerge.exe"
                if not os.path.exists(("{}\\mkvmerge_old").format(values["outputFolder"])):
                    runCommand(('mkdir {}\\mkvmerge_old').format(
                        values["outputFolder"]))
                    
                for index, file in enumerate(selectedFilesList):
                    textMove = "move \"{}\" \"{}\\mkvmerge_old\\{}\""
                    commandMove = textMove.format(file, splitPath(
                        file)["path"], splitPath(file)["file"])
                    # print(commandMove)
                    runCommand(commandMove)
                    #  %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
                    mkvCommandText = "\"{}\" --output \"{}\\{}.mkv\" \"{}\\mkvmerge_old\\{}\""
                    mkvCommand = mkvCommandText.format(mkvMerge, splitPath(file)["path"], splitPath(
                        file)["wExt"], splitPath(file)["path"], splitPath(file)["file"])
                    print(mkvCommand)
                    runCommand(mkvCommand)
                    
                    # if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
                    # for %%A in ("%CD%\*.%extention%") do (
                    # if not exist "%CD%\%%~nA.mkv" (
                    #     move "%CD%\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
                    # ) else (
                    #     move "%CD%\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
                    #     move "%CD%\%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.mkv"
                    # )
                    #     %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
                    # )
        # end of convert to mkv 

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
            errors="replace" if (sys.version_info) < (
                3, 5) else "backslashreplace"
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
    fullname = {"path": head, "file": tail,
                "wExt": fileNameSplit[0], "ext": fileNameSplit[1]}
    return fullname


def fixPath(path):
    return path.replace("/", "\\")


if __name__ == "__main__":
    main()
