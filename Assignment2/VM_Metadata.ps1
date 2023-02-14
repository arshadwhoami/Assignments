﻿connect-AzAccount
$VMResources = Get-AzVM #get all the VMs
$vmdetails = New-Object System.Collections.ArrayList #variable to hold vm details in arraylist
$singleVMDetails = [ordered]@{} #show the list in the order
Write-Host "###########################"
Write-Host "RGName, VMName, Tags" -ForegroundColor Red
Write-Host "###########################" -ForegroundColor White
foreach($VMResource in $VMResources) #loop through each VM
{
$existingTags = (Get-AzResource -ResourceGroupName $VMResource.ResourceGroupName -Name $VMResource.Name).Tags #get tags
$singleVMDetails.'RGName' = $VMResource.ResourceGroupName
$singleVMDetails.'VMName' = $VMResource.Name
$singleVMDetails.'Tags' = $existingTags
$vmdetails.Add((New-object PSObject -Property $singleVMDetails)) | Out-Null
Write-Host $VMResource.ResourceGroupName "," $VMResource.Name "," $existingTags -ForegroundColor White #Display details on screen
}
$vmdetails | ConvertTo-Json
