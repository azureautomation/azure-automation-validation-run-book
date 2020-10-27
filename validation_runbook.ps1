
<#      
THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
    
This sample is not supported under any Microsoft standard support program or service.  
    The script is provided AS IS without warranty of any kind. Microsoft further disclaims all 
    implied warranties including, without limitation, any implied warranties of merchantability 
    or of fitness for a particular purpose. The entire risk arising out of the use or performance 
    of the sample and documentation remains with you. In no event shall Microsoft, its authors, 
    or anyone else involved in the creation, production, or delivery of the script be liable for  
    any damages whatsoever (including, without limitation, damages for loss of business profits,  
    business interruption, loss of business information, or other pecuniary loss) arising out of  
    the use of or inability to use the sample or documentation, even if Microsoft has been advised  
    of the possibility of such damages, rising out of the use of or inability to use the sample script,  
    even if Microsoft has been advised of the possibility of such damages.  
#>

param ( 
    [Parameter(Mandatory=$false)]  
    [String]$AzureCredentialAssetName = 'AzureCredential', 
         
    [Parameter(Mandatory=$false)] 
    [String]$AzureSubscriptionIdAssetName = 'AzureSubscriptionId' 
) 


	$VerbosePreference = "Continue"
		
    #Troubleshooting messages
    Write-Verbose "$(Get-Date -f T) - Checking Azure connectivity"
    Write-Debug "About to check Azure connectivity"

    #Check for Azure credential
    $Cred = Get-AutomationPSCredential -Name $AzureCredentialAssetName 

        #Error handling
        if ($Cred) {

            #Write details of automation credential to screen
            Write-Verbose "$(Get-Date -f T) - Azure Automation credential found - $($Cred.Name)"

        }   #end of if ($Cred)
        else {

            #Write Error and exit
            Write-Error "Unable to obtain Azure Automation credential" -ErrorAction Stop

        }   #end of else ($Cred)

    #Add Azure account
    $Account = Add-AzureAccount -Credential $Cred

        #Error handling
        if ($Account) {

            #Write details of automation credential to screen
            Write-Verbose "$(Get-Date -f T) - Azure Account added - $($Cred.Name)"

        }   #end of if ($Account)
        else {

            #Write Error and exit
            Write-Error "Unable to add Azure Account" -ErrorAction Stop

        }   #end of else ($Account)


    #Get Azure Automation variable for target subscription
    $SubId = Get-AutomationVariable -Name $AzureSubscriptionIdAssetName 

        #Error handling
        if ($SubId) {

            #Write details of automation credential to screen
            Write-Verbose "$(Get-Date -f T) - Azure Automation variable obtained - $SubId "

        }   #end of if ($SubId)
        else {

            #Write Error and exit
            Write-Error "Unable to obtain Azure Automation variable" -ErrorAction Stop

        }   #end of else ($SubId)
    

    #Select current subscription
    Select-AzureSubscription -SubscriptionId $SubId 

    #Error handling
    if (!$?) {

        #Write Error and exit
        Write-Error "Unable to select subscription" -ErrorAction Stop       

    }   #end of if (!$?)

    #Check we have Azure connectivity
    $Subscription = Get-AzureSubscription -Current 

        #Error handling
        if ($Subscription) {

            #Write details of current subscription to screen
            Write-Verbose "$(Get-Date -f T) - Current subscription found - $($Subscription.SubscriptionName)"

        }   #end of if ($Subscription)
        else {

            #Write Error and exit
            Write-Error "Unable to obtain current Azure subscription details" -ErrorAction Stop

        }   #end of else ($Subscription)


