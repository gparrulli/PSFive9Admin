<#
.SYNOPSIS
    
    Function used to get agent group(s) from Five9
 
.PARAMETER NamePattern
 
    Returns only agent groups matching a given regex string
   
.EXAMPLE
    
    Get-Five9AgentGroup
    
    # Returns all agent groups
    
.EXAMPLE
    
    Get-Five9AgentGroup -NamePattern "Team Joe"
    
    # Returns agent group matching the string "Team Joe"
    
 
#>
function Get-Five9AgentGroup
{
    [CmdletBinding()]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop
        
        Write-Verbose "$($MyInvocation.MyCommand.Name): Returning Five9 agent groups using pattern '$($NamePattern)'" 
        return $global:DefaultFive9AdminClient.getAgentGroups($NamePattern)

    }
    catch
    {
        Write-Error $_
    }

}
