<#
.SYNOPSIS
    
    Function used to remove an existing call variable group


.PARAMETER Name
 
    Name of existing call variable group to be removed
   

.EXAMPLE
    
    Remove-Five9CallVariableGroup -Name Salesforce -Description
    
    # Deletes existing call variable group named "Salesforce"


 
#>

function Remove-Five9CallVariableGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )

    
    $response = $global:DefaultFive9AdminClient.deleteCallVariablesGroup($Name)

    return $response

}



