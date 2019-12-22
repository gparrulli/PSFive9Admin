<#
.SYNOPSIS
    
    Function used to create a new call variable group


.PARAMETER Name
 
    Name for new call variable group


.PARAMETER Description
 
    Description for new call variable group
   

.EXAMPLE
    
    New-Five9CallVariableGroup -Name Salesforce -Description "Call variables used for Salesforce reporting"
    
    # Creates new call variable group named "Salesforce". 
    # Use New-Five9CallVariable to create a variable and add it to your new group

#>

function New-Five9CallVariableGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$false)][string]$Description
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop   
        $response = $global:DefaultFive9AdminClient.createCallVariablesGroup($Name, $Description)

        return $response
    }
    catch
    {
        Write-Error $_
    }

}



