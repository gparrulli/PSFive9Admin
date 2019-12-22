<#
.SYNOPSIS
    
    Function used to remove a user role

.PARAMETER Username
 
    Username of user role is being removed from

.PARAMETER RoleName
 
    Name of role being removed

.NOTES

    All users must have at least one role. You cannot remove a user's only role.
   

.EXAMPLE
    
    Remove-Five9UserRole -Username 'jdoe@domain.com' -RoleName Reporting
    
    # Removes reporting role to user
    

#>
function Remove-Five9UserRole
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

    if ($userToModify.roles.$RoleName -eq $null)
    {
        throw "Cannot remove role, user is not assigned the $RoleName role."
        return
    }


    $roleCount = 0

    foreach ($role in @("Agent", "Admin", "Supervisor", "Reporting"))
    {
        if ($userToModify.roles.$role -ne $null)
        {
            $roleCount++
        }
    }

    if ($roleCount -lt 2)
    {
        throw "You cannot remove the $RoleName role becasue it is this user's only role. Please use Add-Five9UserRole to add another role, then try again. All users must have at least one role."
        return
    }


    if ($RoleName -eq "Admin")
    {
        $roleToRemove = 'DomainAdmin'
    }
    else
    {
        $roleToRemove = $RoleName
    }



    $response = $global:DefaultFive9AdminClient.modifyUser($userToModify.generalInfo, $null, $roleToRemove)

    return $response.roles

}

