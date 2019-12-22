<#
.SYNOPSIS
    
    Function used to modify an existing agent group

.PARAMETER Name
 
    Name of existing agent group. Case sensitive

.PARAMETER NewName
 
    Optional parameter. New name value for existing agent group
   
.PARAMETER Description
 
    Optional parameter. New description value for existing agent group
   
.EXAMPLE
    
    Set-Five9AgentGroup -Name "Team Joe" -NewName "Team Joseph"
    
    # Changes name of agent group "Team Joe" to "Team Joseph"
    
#>

function Set-Five9AgentGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$false)][string]$NewName,
        [Parameter(Mandatory=$false)][string]$Description
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop
        $agentGroupToModify = $null
        try
        {
            $agentGroupToModify = $global:DefaultFive9AdminClient.getAgentGroup($Name)
        }
        catch
        {
        
        }

        if ($agentGroupToModify.Count -gt 1)
        {
            throw "Multiple agent groups were found using query: ""$Name"". Please try using the exact name of the agent group you're trying to modify."
            return
        }

        if ($agentGroupToModify -eq $null)
        {
            throw "Cannot find a agent group with name: ""$Name"". Remember that Name is case sensitive."
            return
        }

        if ($PSBoundParameters.Keys -contains "NewName")
        {
            $agentGroupToModify.Name = $NewName
        }

        if ($PSBoundParameters.Keys -contains "Description")
        {
            $agentGroupToModify.Description = $Description
        }


        Write-Verbose "$($MyInvocation.MyCommand.Name): Modifying agent group '$Name'." 
        $response =  $global:DefaultFive9AdminClient.modifyAgentGroup($agentGroupToModify, $null, $null)

        return $response

    }
    catch
    {
        Write-Error $_
    }

}



