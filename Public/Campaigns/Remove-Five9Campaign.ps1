<#
.SYNOPSIS
    
    Function used to delete an existing campaign in Five9

.PARAMETER Name

    Name of existing campaign to be removed

.EXAMPLE
    
    Remove-Five9InboundCampaign -Name "Cold-Calls"
    
    # Removes campaign named "Cold-Calls"

#>
function Remove-Five9Campaign
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )

    $response = $global:DefaultFive9AdminClient.deleteCampaign($Name)

    return $response

}

