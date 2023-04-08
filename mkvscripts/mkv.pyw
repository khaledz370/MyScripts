import subprocess
import os
import sys
import PySimpleGUI as psg
# import glob


def main():
    tomkvLayout = [
        [psg.Text("convert video to mkv", size=(600, 0), justification="center")],
        # Radio
        [psg.Text("Select"),psg.Radio("directory", 'tomkvRadio', key="dirTomkv",enable_events=True, default=True),
         psg.Radio("files", 'tomkvRadio', enable_events=True, key="fileTomkv")],

        [psg.Text("Select a file", expand_x=True, justification="center")],
        # browser
        [psg.LBox([], size=(20, 10),enable_events=True, expand_x=True,expand_y=True, key="tomkvList",select_mode="multiple"),
         psg.Column([
            [psg.Listbox(['.mp4','.mkv','.flv', '.ts','.avi'],enable_events=True,select_mode="multiple",size=(10, 6),key='fileTypes')],
            [psg.Input(visible=False, enable_events=True,key="myFiles", expand_x=True),psg.FilesBrowse(size=(10, 0),key="filesBrowser",visible=False)],
            [psg.Input(visible=False, enable_events=True,key="myFolders", expand_x=True),psg.FolderBrowse(size=(10, 0),key="folderBrowser",visible=True)],
            [psg.Button("delete",key="delBtn",enable_events=True,size=(10, 0))]
            ])],
        
        [psg.Text("Output folder")],
                
        [psg.Button("convert", key="converToMkv", size=(15, 0))],
    ]

    tomkvTab = [psg.Tab('To Mkv', tomkvLayout)]

    layout = [
        [psg.TabGroup([tomkvTab])],
        [psg.ProgressBar(100, orientation='h', expand_x=True, size=(20, 20),  key='pBar')],
        [psg.OK(), psg.Exit()]
    ]
    window = psg.Window("my first app", layout,
                        resizable=True, size=(600, 420))
    selectedDir = ""
    
    while True:
        event, values = window.read()
        print(event)
        if event in (psg.WIN_CLOSED, "Exit"):
            break
        if event == "myFiles":
            window["tomkvList"].Update(values["myFiles"].split(";"))
            selectedFilesList = str(values["myFiles"]).split(";")
            if len(selectedFilesList):
                selectedDir = str(splitPath(selectedFilesList[0])["path"])
        
        if event == "dirTomkv":
            window["filesBrowser"].Update(visible=False)
            window["fileTypes"].Update(visible=True)
            window["folderBrowser"].Update(visible=True)
            
        if event == "fileTomkv":
            window["filesBrowser"].Update(visible=True)
            window["fileTypes"].Update(visible=False)
            window["folderBrowser"].Update(visible=False)
           
        if event=="fileTypes":
            if len(values["myFolders"]):
                ftypesArray= values["fileTypes"]
                if not len(ftypesArray):
                    ftypesArray = ['.mp4','.mkv','.flv', '.ts','.avi']
                fArray = [x for x in os.listdir(values["myFolders"]) if x.endswith(tuple(ftypesArray))]
                window["tomkvList"].Update(fArray)
                selectedFilesList = fArray
        
        if event == "myFolders":
            ftypesArray= values["fileTypes"]
            selectedDir = str(values["myFolders"])
            print(selectedDir)
            if not len(ftypesArray):
                ftypesArray = ['.mp4','.mkv','.flv', '.ts','.avi']
            fArray = [x for x in os.listdir(selectedDir) if x.endswith(tuple(ftypesArray))]
            window["tomkvList"].Update(fArray)
            selectedFilesList = fArray

        if event == "tomkvList":
            print(values["tomkvList"])
 
        if event == "delBtn":
            if len(values["myFolders"]):
                ftypesArray= values["fileTypes"]
                selectedFiles = values["tomkvList"]
                newArray = [x for x in os.listdir(values["myFolders"]) if not x in tuple(selectedFiles) and x.endswith(tuple(ftypesArray))]
                window["tomkvList"].Update(newArray)
                selectedFilesList = newArray

        # convert to mkv
        if event == "converToMkv":
            if len(selectedFilesList):
                mkvMerge = "C:\Program Files\MKVToolNix\mkvmerge.exe"
                print(selectedDir)
                
                if not os.path.exists(("{}\\mkvmerge_old").format(selectedDir)):
                    mkdirCommand = ('mkdir {}\\mkvmerge_old').format(selectedDir)
                    runCommand(mkdirCommand)

                for index, file in enumerate(selectedFilesList):
                    print(file)
                    textMove = "move \"{}\\{}\" \"{}\\mkvmerge_old\\{}\""
                    commandMove = textMove.format(selectedDir,splitPath(file)["file"], selectedDir, splitPath(file)["file"])
                    print(commandMove)
                    runCommand(commandMove)

                    mkvCommandText = "\"{}\" --output \"{}\\{}.mkv\" \"{}\\mkvmerge_old\\{}\""
                    mkvCommand = mkvCommandText.format(mkvMerge, selectedDir, splitPath(
                        file)["wExt"], selectedDir, splitPath(file)["file"])
                    # print(mkvCommand)
                    window["pBar"].Update(current_count=(100*index/len(selectedFilesList)))
                    runCommand(mkvCommand)
                    window["pBar"].Update(current_count=(100*(index+1)/len(selectedFilesList)))
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
