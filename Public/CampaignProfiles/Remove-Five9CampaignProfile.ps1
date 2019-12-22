<#
.SYNOPSIS
    
    Function used to remove an existing campaign profile in Five9

.PARAMETER Name

    Name of existing campaign profile to be removed

.EXAMPLE

    Set-Five9CampaignProfile -Name "Cold-Calls-Profile" 

    # Removes existing campaign profile named "Cold-Calls-Profile"

#>
function Remove-Five9CampaignProfile
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )

    $campaignProfileToRemove = $null
    try
    {
        $campaignProfileToRemove = $global:DefaultFive9AdminClient.getCampaignProfiles($Name)
    }
    catch
    {

    }
    
    if ($campaignProfileToRemove.Count -gt 1)
    {
        throw "Multiple campaign profiles were found using query: ""$Name"". Please try using the exact name of the campaign profile you're trying to remove."
        return
    }

    if ($campaignProfileToRemove -eq $null)
    {
        throw "Cannot find a campaign profile with name: ""$Name"". Remember that Name is case sensitive."
        return
    }

    $campaignProfileToRemove = $campaignProfileToRemove | select -First 1
    

    $response = $global:DefaultFive9AdminClient.deleteCampaignProfile($Name)

    return $response

}
