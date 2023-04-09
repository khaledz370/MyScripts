import os,shutil,sys,subprocess
import PySimpleGUI as psg
# import glob


def main():
    mkvMerge = "C:\Program Files\MKVToolNix\mkvmerge.exe"
    selectedDir = ""
    tomkvLayout = [
        [psg.Text("convert video to mkv", size=(
            600, 0), justification="center")],
        # Radio
        [psg.Text("Select"), psg.Radio("directory", 'tomkvRadio', key="tomkvDir", enable_events=True, default=True),
         psg.Radio("files", 'tomkvRadio', enable_events=True, key="tomkvFiles")],

        [psg.Text("Select a folder",key="tomkvSelectText", expand_x=True, justification="center")],
        # browser
        [psg.LBox([], size=(20, 10), enable_events=True, expand_x=True, expand_y=True, key="tomkvList", select_mode="multiple"),
         psg.Column([
             [psg.Listbox(['.mp4', '.mkv', '.flv', '.ts', '.avi'], enable_events=True,
                          select_mode="multiple", size=(10, 5), key='tomkvFileTypes')],
             [psg.Input(visible=False, enable_events=True, key="tomkvMyFiles", expand_x=True), psg.FilesBrowse(size=(10, 0), key="tomkvFilesBrowser", visible=False),
                 psg.Input(visible=False, enable_events=True, key="tomkvMyFolders", expand_x=True), psg.FolderBrowse(size=(10, 0), key="tomkvFolderBrowser", visible=True)],
             [psg.Button("delete", key="tomkvDelBtn", disabled=True,
                         enable_events=True, size=(10, 0))]
         ])],
        [psg.Button("convert", key="converToMkv", size=(15, 0))],
    ]
    
    toaudioLayout = [
        [psg.Text("convert video to audio", size=(
            600, 0), justification="center")],
        # Radio
        [psg.Text("Select"), psg.Radio("directory", 'toaudioRadio', key="toaudioDir", enable_events=True, default=True),
         psg.Radio("files", 'toaudioRadio', enable_events=True, key="toaudioFiles")],

        [psg.Text("Select a folder",key="toaudioSelectText", expand_x=True, justification="center")],
        # browser
        [psg.LBox([], size=(20, 10), enable_events=True, expand_x=True, expand_y=True, key="toaudioList", select_mode="multiple"),
         psg.Column([
             [psg.Listbox(['.mp4', '.mkv', '.flv', '.ts', '.avi'], enable_events=True,
                          select_mode="multiple", size=(10, 5), key='toaudioFileTypes')],
             [psg.Input(visible=False, enable_events=True, key="toaudioMyFiles", expand_x=True), psg.FilesBrowse(size=(10, 0), key="toaudioFilesBrowser", visible=False),
                 psg.Input(visible=False, enable_events=True, key="toaudioMyFolders", expand_x=True), psg.FolderBrowse(size=(10, 0), key="toaudioFolderBrowser", visible=True)],
             [psg.Button("delete", key="toaudioDelBtn", disabled=True,
                         enable_events=True, size=(10, 0))]
         ])],
        [psg.Button("convert to audio", key="converToaudio", size=(15, 0))],
    ]
    
  
    tomkvTab = [psg.Tab('to Mkv', tomkvLayout, key="tomkv"),
                psg.Tab("to Audio", toaudioLayout, key="toaudio")]

    layout = [
        [psg.TabGroup([tomkvTab],change_submits=True,key="myTabs")],
        [psg.ProgressBar(100, orientation='h', expand_x=True, size=(20, 20),  key='PBar')],
        [psg.OK(), psg.Exit(),psg.Text("",key="currentFile")]
    ]

    window = psg.Window("my first app", layout,
                        resizable=True, size=(600, 400))

    while True:
        event, values = window.read()
        activeTab = window['myTabs'].Get() 
        print(event)
        if event in (psg.WIN_CLOSED, "Exit"):
            break

        # switch between folder/file selection tomkv
        if event == f"{activeTab}Dir":
            window[f"{activeTab}FilesBrowser"].Update(visible=False)
            window[f"{activeTab}FileTypes"].Update(visible=True)
            window[f"{activeTab}FolderBrowser"].Update(visible=True) 
            window[f"{activeTab}SelectText"].Update("Select a folder") 
        if event == f"{activeTab}Files":
            window[f"{activeTab}FilesBrowser"].Update(visible=True)
            window[f"{activeTab}FileTypes"].Update(visible=False)
            window[f"{activeTab}FolderBrowser"].Update(visible=False)
            window[f"{activeTab}SelectText"].Update("Select files") 

        # browse for files
        if event == f"{activeTab}MyFiles":
            window["tomkvList"].Update(values["tomkvMyFiles"].split(";"))
            selectedFilesList = str(values["tomkvMyFiles"]).split(";")
            if len(selectedFilesList):
                selectedDir = fixPath(str(splitPath(selectedFilesList[0])["path"]))

        # browse for folder
        if event == f"{activeTab}MyFolders":
            ftypesArray = values[f"{activeTab}FileTypes"]
            selectedDir = fixPath(str(values[f"{activeTab}MyFolders"]))
            if not len(ftypesArray):
                ftypesArray = ['.mp4', '.mkv', '.flv', '.ts', '.avi']
            newArray = []
            for x in os.listdir(selectedDir):
                if x.endswith(tuple(ftypesArray)):
                    newArray.append((f"{selectedDir}\\{x}"))
            selectedFilesList = newArray
            # print(selectedFilesList)
            window[f"{activeTab}List"].Update(selectedFilesList)

        # on select file types
        if event == f"{activeTab}FileTypes":
            if len(values[f"{activeTab}MyFolders"]):
                ftypesArray = values[f"{activeTab}FileTypes"]
                if not len(ftypesArray):
                    ftypesArray = ['.mp4', '.mkv', '.flv', '.ts', '.avi']
                newArray = []
                for x in os.listdir(selectedDir):
                    if x.endswith(tuple(ftypesArray)):
                        newArray.append((f"{selectedDir}\\{x}"))
                selectedFilesList = newArray
                window[f"{activeTab}List"].Update(selectedFilesList)
                
        # enable and disable delete button
        if event == f"{activeTab}List":
            selectedItemsInList = values[f"{activeTab}List"]
            # print(selectedItemsInList)
            if len(selectedItemsInList):
                window[f"{activeTab}DelBtn"].Update(disabled=False)
            else:
                window[f"{activeTab}DelBtn"].Update(disabled=True)

        # on delete item
        if event == f"{activeTab}DelBtn":
            print("this is the selected file list=>",selectedFilesList)
            if len(values[f"{activeTab}MyFolders"]):
                ftypesArray = values[f"{activeTab}FileTypes"]
                selectedFiles = values[f"{activeTab}List"]
                print("this is the next deleted files=>",selectedFiles)
                newArray = selectedFilesList
                for x in selectedFiles:
                    newArray.remove(str(x))
                selectedFilesList = newArray
                window[f"{activeTab}List"].Update(selectedFilesList)
            if not len(selectedFilesList):
                window[f"{activeTab}DelBtn"].Update(disabled=True)

        # convert to mkv
        if event == "converToMkv":
            arraySize = len(selectedFilesList)
            if arraySize:
                print("the selected dir =>"+selectedDir)
                # create mkvmerge_old if not exist
                if not os.path.exists((f"{selectedDir}\\mkvmerge_old")):
                    os.makedirs((f"{selectedDir}\\mkvmerge_old"))
                    # print(mkdirCommand)
                for index, file in enumerate(selectedFilesList):
                    window["currentFile"].Update(str(file))
                    fName = splitPath(file)["file"]
                    fNameNoExt = splitPath(file)["wExt"]                    
                    mkvmerge_old = (f"{selectedDir}\mkvmerge_audio\{fName}")
                    shutil.move(file,mkvmerge_old)
                    mkvCommand = f"\"{mkvMerge}\" --output \"{selectedDir}\\{fNameNoExt}.mkv\" \"{selectedDir}\\mkvmerge_old\\{fName}\""
                    # print(mkvCommand)
                    presentage=(100*(index+1)/arraySize)
                    window["PBar"].Update(current_count=presentage)
                    runCommand(mkvCommand)
            selectedFilesList= [] 
            window["tomkvList"].Update([])
            window["PBar"].Update(current_count=0)
            window["currentFile"].Update("")
        # end of convert to mkv
        
        # convert to audio
        if event == "converToaudio":
            arraySize = len(selectedFilesList)
            if arraySize:
                print("the selected dir =>"+selectedDir)
                # create mkvmerge_old if not exist
                if not os.path.exists((f"{selectedDir}\\mkvmerge_audio")):
                    os.makedirs((f"{selectedDir}\\mkvmerge_audio"))
                    # print(mkdirCommand)
                for index, file in enumerate(selectedFilesList):
                    window["currentFile"].Update(str(file))
                    fName = splitPath(file)["file"]
                    fNameNoExt = splitPath(file)["wExt"]                    
                    mkvCommand = f"\"{mkvMerge}\" --output \"{selectedDir}\\mkvmerge_audio\\{fNameNoExt}.mka\" --no-video --language 1:und  \"{selectedDir}\\{fName}\""
                    # print(mkvCommand)
                    presentage=(100*(index+1)/arraySize)
                    window["PBar"].Update(current_count=presentage)
                    runCommand(mkvCommand)
            selectedFilesList= [] 
            window["toaudioList"].Update([])
            window["PBar"].Update(current_count=0)
            window["currentFile"].Update("")
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
