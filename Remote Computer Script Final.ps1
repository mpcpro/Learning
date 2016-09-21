clear
$PROCESS_ID = 0
$CONFIRM_TERMINATE = "No" 
$RUN_AGAIN = "Yes" 
$SERVICES = "" 
$SERVICE_TO_STOP = "" 
$SERVICE_TO_START = ""
$SERVICE_FOUND = "No"
$UserReplyRunningService = ""
$RemoteComputer = ""
$AdminLogin = "matthewc"
$LocalorRemote

Write-host "Local or Remote PC?"
Write-host ""
$LocalorRemote = read-host "Type Local/Remote"
if($LocalorRemote -eq "Local" -or $LocalorRemote -eq "L"){
    While($RUN_AGAIN -eq "Yes" -or $RUN_AGAIN -eq "Y"){
    Write-Host ""
    Write-Host "-----------Select a Menu Item-----------"
    Write-Host "List all processes                   [1]"
    Write-Host "Stop a process                       [2]"
    Write-Host "List all services                    [3]"
    Write-Host "Stop a running service               [4]"
    Write-Host "Start a running service              [5]"
    Write-Host "Script Author                        [6]"
    Write-Host "Quit the program?                    [7]"
    Write-Host ""
    $MY_SELECTION = Read-Host "Enter your selection: "
    Write-Host ""
    Switch ($MY_SELECTION)
        {
            1 {Get-Process}
            2 {
                $PROCESS_ID = Read-host "What process ID do you want to stop?"
                $PROCESSES = Get-Process
                foreach($Process in $Processes){
                    if($Process.ID -eq $PROCESS_ID){
                    $CONFIRM_TERMINATE = Write-Host $Process.ProcessName "Will be terminated (Yes/No)"
                        $CONFIRM_TERMINATE = Read-Host "Terminate Process (Yes/No)"
                        if($CONFIRM_TERMINATE -eq "Yes" -or $CONFIRM_TERMINATE -eq "Y"){
                            Write-Host "Terminate confirmed by the user. Ending process." $Process.ProcessName
                            Stop-Process -Id $PROCESS_ID -Force
                        }else{
                            Write-Host "Terminate not confirmed no action taken."
                        }
                    }
                }
            }
            3 {Get-Service}
            4 {
                $SERVICE_FOUND = "No"
                $SERVICE_TO_STOP = Read-Host "What is the Name of the service you would like to stop? (Note: Not the DisplayName)"
                $SERVICES = @(Get-Service)
                    foreach($SERVICE in $SERVICES){
                        if($SERVICE.Name -eq $SERVICE_TO_STOP){
                            if($SERVICE.Status -eq "Running"){
                                $SERVICE_FOUND = "Yes"
                                Write-Host $SERVICE.Name "Service found."
                                Write-Host "Stopping service now."
                                Stop-Service $SERVICE_TO_STOP -Force
                                Get-Service | ? {$_.Name -eq $SERVICE_TO_STOP}
                            }elseif($SERVICE.Status -eq "Stopped"){
                                $SERVICE_FOUND = "Yes"
                                Write-Host "The service is already stopped."
                            }
                    }
                }
                if($SERVICE_FOUND -eq "No"){
                    Write-Host "We did not find the service you entered, please try again."
                    }
            }
            5 {
            
            Write-Host "You want to start a running service?"
            $UserReplyRunningService = Read-Host "Yes/No?"
                if($UserReplyRunningService -eq "Yes" -or $UserReplyRunningService -eq "Y"){
                        $SERVICE_FOUND = "No"      
                        $SERVICE_TO_START = Read-Host "What is the Name of the service you would like to start? (Note: Not the DisplayName)"
                        $SERVICES = @(Get-Service)
                            foreach($SERVICE in $SERVICES){
                                if($SERVICE.Name -eq $SERVICE_TO_START){
                                    if($SERVICE.Status -eq "Stopped"){
                                        $SERVICE_FOUND = "Yes"
                                        Write-Host $SERVICE.Name "Service found."
                                        Write-Host "Starting service now."
                                        Start-Service $SERVICE_TO_START
                                        Get-Service | ? {$_.Name -eq $SERVICE_TO_START}
                                    }elseif($SERVICE.Status -eq "Running"){
                                        $SERVICE_FOUND = "Yes"
                                        Write-Host "The service is already running."
                                    }
                                }
                            }
                            if($SERVICE_FOUND -eq "No"){
                                Write-Host "We did not find the service you entered, please try again."
                                } 
                    }
                    elseif($UserReplyRunningService -eq "No"){
                        $RUN_AGAIN = Read-Host "Type 'Yes' or 'No' to run the program again"
                        }                                                
            }
            6 {
        Write-Host "     
        Script made by 'Matthew Paul Cupper' @ 31.08.2016

           ________________
         |'-.--._ _________:
         |  /    |  __    __\
         | |  _  | [\_\= [\_\
         | |.' '. \.........|
         | ( <)  ||:       :|_
          \ '._.' | :.....: |_(o
           '-\_   \ .------./
           _   \   ||.---.||  _
          / \  '-._|/\n~~\n' | \
         (| []=.--[===[()]===[) |
         <\_/  \_______/ _.' /_/
         ///            (_/_/
         |\\            [\\
         ||:|           | I|
         |::|           | I|
         ||:|           | I|
         ||:|           : \:
         |\:|            \I|
         :/\:            ([])
         ([])             [|
          ||              |\_
         _/_\_            [ -'-.__
        <]   \>            \_____.>
          \__/
        
        "
            }
            7 {exit}  
            default{"Error you did not select a valid option"}
        }
    Write-Host ""
    Write-Host ""
    $RUN_AGAIN = Read-Host "Type 'Yes' or 'No' to run the program again"
    }
}elseif($LocalorRemote -eq "Remote" -or $LocalorRemote -eq "R"){
Write-Host "Type in the host-name of the computer you would like to remote into:"
$RemoteComputer = read-host "Type the Host-Name"
Enter-PSSession -Computername $RemoteComputer -credential $AdminLogin

    While($RUN_AGAIN -eq "Yes" -or $RUN_AGAIN -eq "Y"){
    Write-Host ""
    Write-Host "-----------Select a Menu Item-----------"
    Write-Host "List all processes                   [1]"
    Write-Host "Stop a process                       [2]"
    Write-Host "List all services                    [3]"
    Write-Host "Stop a running service               [4]"
    Write-Host "Start a running service              [5]"
    Write-Host "Script Author                        [6]"
    Write-Host "Quit the program?                    [7]"
    Write-Host ""
    $MY_SELECTION = Read-Host "Enter your selection: "
    Write-Host ""
    Switch ($MY_SELECTION)
        {
            1 {Get-Process}
            2 {
                $PROCESS_ID = Read-host "What process ID do you want to stop?"
                $PROCESSES = Get-Process
                foreach($Process in $Processes){
                    if($Process.ID -eq $PROCESS_ID){
                    $CONFIRM_TERMINATE = Write-Host $Process.ProcessName "Will be terminated (Yes/No)"
                        $CONFIRM_TERMINATE = Read-Host "Terminate Process (Yes/No)"
                        if($CONFIRM_TERMINATE -eq "Yes" -or $CONFIRM_TERMINATE -eq "Y"){
                            Write-Host "Terminate confirmed by the user. Ending process." $Process.ProcessName
                            Stop-Process -Id $PROCESS_ID -Force
                        }else{
                            Write-Host "Terminate not confirmed no action taken."
                        }
                    }
                }
            }
            3 {Get-Service}
            4 {
                $SERVICE_FOUND = "No"
                $SERVICE_TO_STOP = Read-Host "What is the Name of the service you would like to stop? (Note: Not the DisplayName)"
                $SERVICES = @(Get-Service)
                    foreach($SERVICE in $SERVICES){
                        if($SERVICE.Name -eq $SERVICE_TO_STOP){
                            if($SERVICE.Status -eq "Running"){
                                $SERVICE_FOUND = "Yes"
                                Write-Host $SERVICE.Name "Service found."
                                Write-Host "Stopping service now."
                                Stop-Service $SERVICE_TO_STOP -Force
                                Get-Service | ? {$_.Name -eq $SERVICE_TO_STOP}
                            }elseif($SERVICE.Status -eq "Stopped"){
                            $SERVICE_FOUND = "Yes"
                                Write-Host "The service is already stopped."
                            }
                    }
                }
                if($SERVICE_FOUND -eq "No"){
                    Write-Host "We did not find the service you entered, please try again."
                    }
            }
            5 {
            
            Write-Host "You want to start a running service?"
            $UserReplyRunningService = Read-Host "Yes/No?"
                if($UserReplyRunningService -eq "Yes" -or $UserReplyRunningService -eq "Y"){
                        $SERVICE_FOUND = "No"      
                        $SERVICE_TO_START = Read-Host "What is the Name of the service you would like to start? (Note: Not the DisplayName)"
                        $SERVICES = @(Get-Service)
                            foreach($SERVICE in $SERVICES){
                                if($SERVICE.Name -eq $SERVICE_TO_START){
                                    if($SERVICE.Status -eq "Stopped"){
                                        $SERVICE_FOUND = "Yes"
                                        Write-Host $SERVICE.Name "Service found."
                                        Write-Host "Starting service now."
                                        Start-Service $SERVICE_TO_START
                                        Get-Service | ? {$_.Name -eq $SERVICE_TO_START}
                                    }elseif($SERVICE.Status -eq "Running"){
                                        $SERVICE_FOUND = "Yes"
                                        Write-Host "The service is already running."
                                    }
                                }
                            }
                            if($SERVICE_FOUND -eq "No"){
                                Write-Host "We did not find the service you entered, please try again."
                                } 
                    }
                    elseif($UserReplyRunningService -eq "No"){
                        $RUN_AGAIN = Read-Host "Type 'Yes' or 'No' to run the program again"
                        }                                                
            }
          6 {
                Write-Host "     
         Script made by 'Matthew Paul Cupper' @ 31.08.2016

           ________________
         |'-.--._ _________:
         |  /    |  __    __\
         | |  _  | [\_\= [\_\
         | |.' '. \.........|
         | ( <)  ||:       :|_
          \ '._.' | :.....: |_(o
           '-\_   \ .------./
           _   \   ||.---.||  _
          / \  '-._|/\n~~\n' | \
         (| []=.--[===[()]===[) |
         <\_/  \_______/ _.' /_/
         ///            (_/_/
         |\\            [\\
         ||:|           | I|
         |::|           | I|
         ||:|           | I|
         ||:|           : \:
         |\:|            \I|
         :/\:            ([])
         ([])             [|
          ||              |\_
         _/_\_            [ -'-.__
        <]   \>            \_____.>
          \__/
        
        "
            }
          7 {
            write-host "Remember to type 'Exit' to leave the remote powershell if you are running this in ISE"
            Start-sleep -s 3
            exit
            }  
          default{"Error you did not select a valid option"}
        }
    Write-Host ""
    Write-Host ""
    $RUN_AGAIN = Read-Host "Type 'Yes' or 'No' to run the program again"
    Write-Host ""
    Write-Host ""
    write-host "If you typed 'No' remember to type 'Exit' to leave the remote powershell if you are running this in ISE"
    Start-sleep -s 3
    }
}
else{
Write-host "Invalid"
}

# Ting å fikse:
# Fikse "Enter" som default for Yes.
