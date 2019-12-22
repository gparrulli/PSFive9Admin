<#
.SYNOPSIS
    
    Function used to get call variable group(s) from Five9

.PARAMETER GroupName
 
    Returns only call variable groups matching a given regex string. If omitted, all groups will be returned
   
.EXAMPLE
    
    Get-Five9CallVariableGroup
    
    # Returns all call variable groups
    
.EXAMPLE
    
    Get-Five9CallVariableGroup -GroupName "Agent"
    
    # Returns call variable group matching group name "Agent"
#>

function Get-Five9CallVariableGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$GroupName = '.*'
    )
    
    try
    {
        Test-Five9Connection -ErrorAction: Stop

        Write-Verbose "$($MyInvocation.MyCommand.Name): Returning Five9 call variable group '$Group'." 
        return $global:DefaultFive9AdminClient.getCallVariableGroups($GroupName)
    }
    catch
    {
        Write-Error $_
    }


}



