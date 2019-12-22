<#
.SYNOPSIS
    
    Function used to remove an existing call variable


.PARAMETER Name
 
    Name of existing call variable to be removed

.PARAMETER Group
 
    Group name of existing call variable to be removed
   
   

.EXAMPLE
    
    Remove-Five9CallVariable -Name "SalesforceId" -Group "Salesforce"
    
    # Deletes existing call variable named "SalesforceId" which is in the "Salesforce" call variable group


 
#>

function Remove-Five9CallVariable
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$true)][string]$Group
    )

    
    $response = $global:DefaultFive9AdminClient.deleteCallVariable($Name, $Group)

    return $response

}



