<#
.SYNOPSIS
    
    Function used to add a new role to a user

.PARAMETER Username
 
    Username of user role is being added to

.PARAMETER RoleName
 
    Name of role being added. Role permissions will be default. Use Set-Five9User<RoleName>Role to change permissions on role. i.e. Set-Five9UserAgentRole
   

.EXAMPLE
    
    Add-Five9UserRole -Username 'jdoe@domain.com' -RoleName Reporting
    
    # Adds default reporting role to user
    

#>
function Add-Five9UserRole
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Username,
        [Parameter(Mandatory=$true)][ValidateSet("Agent", "Admin", "Supervisor", "Reporting")][string]$RoleName
    )


    $userToModify = $null
    try
    {
        $userToModify = $global:DefaultFive9AdminClient.getUserInfo($Username)
    }
    catch
    {

    }

    if ($userToModify.Count -gt 1)
    {
        throw "Multiple user matches were found using query: ""$Username"". Please try using the exact username of the user you're trying to modify."
        return
    }

    if ($userToModify -eq $null)
    {
        throw "Cannot find a Five9 user with username: ""$Username"". Remember that username is case sensitive."
        return
    }

    if ($userToModify.roles.$RoleName -ne $null)
    {
        throw "$RoleName has already been added to this user. Please use Set-Five9User$($RoleName)Role to modify role permisisons."
        return
    }


    $userRoles = New-Object -TypeName PSFive9Admin.userRoles

    if ($RoleName -eq "Agent")
    {
        $agentRole = New-Object -TypeName PSFive9Admin.agentRole
        $agentRole.permissions = @()

        $userRoles.agent = $agentRole

    }
    elseif ($RoleName -eq "Admin")
    {
        $userRoles.admin = @()
    }
    elseif ($RoleName -eq "Supervisor")
    {
        $userRoles.supervisor = @()
    }
    elseif ($RoleName -eq "Reporting")
    {
        $userRoles.reporting = @()
    }

    $response = $global:DefaultFive9AdminClient.modifyUser($userToModify.generalInfo, $userRoles, $null)

    return $response.roles

}

