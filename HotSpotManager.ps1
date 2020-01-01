$connectionProfile = [Windows.Networking.Connectivity.NetworkInformation,Windows.Networking.Connectivity,ContentType=WindowsRuntime]::GetInternetConnectionProfile()
$tetheringManager = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager,Windows.Networking.NetworkOperators,ContentType=WindowsRuntime]::CreateFromConnectionProfile($connectionProfile)
 

while($true){

    # Check Mobile Hotspot state
    if ($tetheringManager.TetheringOperationalState -eq 'InTransition'){
        
        # Rebooting PC, because Hotspot may stuck in 'InTransition' state :(
        Write-Verbose "I will reboot your PC in a few seconds, because Mobile Hotspot is bugging. Kill this window to stop it :)"
        Start-Sleep -Seconds 7
        Restart-Computer -Force

    }
    elseif($tetheringManager.TetheringOperationalState -eq 'Off'){
 
        # Start Mobile Hotspot
        $tetheringManager.StartTetheringAsync()
        Write-Output -Verbose "$(Get-Date) --- Wifi set to On"
        Start-Sleep -Seconds 600
        
    }
    elseif($tetheringManager.TetheringOperationalState -eq 'On'){

        # Stop Mobile Hotspot
        [System.__ComObject]($tetheringManager.StopTetheringAsync())
        Write-Output -Verbose "$(Get-Date) --- Wifi set to Off"
        Start-Sleep -Seconds 7

    }
}