<#
.SYNOPSIS
    
    Function used to delete an agent group


.PARAMETER Name
 
    Name of group being removed
   

   
.EXAMPLE
    
    Remove-Five9AgentGroup -Name "Team Joe"
    
    # Deletes agent group named "Team Joe"
    
#>

function Remove-Five9AgentGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name
    )
    
    try
    {
        Test-Five9Connection -ErrorAction: Stop
       
        Write-Verbose "$($MyInvocation.MyCommand.Name): Removing Five9 agent group '$Name'." 
        $response =  $global:DefaultFive9AdminClient.deleteAgentGroup($Name)

        return $response

    }
    catch
    {
        Write-Error $_
    }
}



