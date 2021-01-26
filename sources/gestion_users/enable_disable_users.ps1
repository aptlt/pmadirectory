# SCRIPT CHOIX DE L'ACTION UTILISATEUR #

###############################################

# Chargement des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

############# CREATION DE LA FENETRE ###############

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Activer ou D�sactiver un utilisateur"
$objForm.Size = New-Object System.Drawing.Size(300,400) 
$objForm.StartPosition = "CenterScreen"
$objForm.BackColor = "#02ACE5"

###############################################

# Liste déroulante users #

$objComboboxUser = New-Object System.Windows.Forms.Combobox
$objComboboxUser.Location = New-Object System.Drawing.Size(30,100) 
$objComboboxUser.Size = New-Object System.Drawing.Size(220,40) 
$objComboboxUser.DropDownStyle = "DropDownList"

function recup_ad_users {

# Fonction appelée pour recupérer la liste des utilisateurs #

$OU = "OU=Utilisateurs,DC=afip,DC=lab"

if ($listUsers -ne $null){
    $listUsers = ""
}

$listUsers = Get-ADUser -Filter * -SearchBase $OU 

# Ajout des Utilisateus dans la Liste

foreach($user in $listUsers.sAMAccountName)
{
    $objComboboxUser.Items.add($user)
}

$objForm.controls.add($objComboboxUser)

}

function enable_disable_user {

    # Chargement des variables des Combobox
    $identifiant = $objComboboxUser.Text
    $choix_user = $objComboboxChoix.Text

    # Verification du souhait : activer ou désactiver l'utilisateur
    if ($choix_user -eq "Activer") {

        $enableOrDisable = Get-ADUser -Filter {samAccountName -eq $identifiant} -Property Enabled

        if (-not $enableOrDisable.Enabled) {
            Get-ADUser -Filter {samAccountName -eq $identifiant} | Enable-ADAccount
            $objRecap2 = New-Object System.Windows.Forms.Label
            $objRecap2.Location = New-Object System.Drawing.Size(30,240) 
            $objRecap2.Size = New-Object System.Drawing.Size(280,100)
            $objRecap2.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
            $objRecap2.ForeColor = "White"
            $objRecap2.Text = "L'utilisateur $identifiant a bien été activé"
            $objForm.Controls.Add($objRecap2)
            Sleep -s 2
            $objForm.Controls.Remove($objRecap2)  
        }
        elseif ($enableOrDisable.Enabled) {
            $objRecap = New-Object System.Windows.Forms.Label
            $objRecap.Location = New-Object System.Drawing.Size(30,240) 
            $objRecap.Size = New-Object System.Drawing.Size(280,100)
            $objRecap.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
            $objRecap.ForeColor = "White"
            $objRecap.Text = "L'utilisateur $identifiant est déjà activé"
            $objForm.Controls.Add($objRecap)
            Sleep -s 2
            $objForm.Controls.Remove($objRecap)          
        }
    }

    elseif ($choix_user -eq "Desactiver"){

        $enableOrDisable = Get-ADUser -Filter {samAccountName -eq $identifiant} -Property Enabled

        if (-not $enableOrDisable.Enabled) {
            $objRecap2 = New-Object System.Windows.Forms.Label
            $objRecap2.Location = New-Object System.Drawing.Size(30,240) 
            $objRecap2.Size = New-Object System.Drawing.Size(280,100)
            $objRecap2.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
            $objRecap2.ForeColor = "White"
            $objRecap2.Text = "L'utilisateur $identifiant est déjà desactivé"
            $objForm.Controls.Add($objRecap2)
            Sleep -s 2
            $objForm.Controls.Remove($objRecap2)  
        }
        elseif ($enableOrDisable.Enabled){
            Get-ADUser -Filter {samAccountName -eq $identifiant} | Disable-ADAccount
            $objRecap = New-Object System.Windows.Forms.Label
            $objRecap.Location = New-Object System.Drawing.Size(30,240) 
            $objRecap.Size = New-Object System.Drawing.Size(280,100)
            $objRecap.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
            $objRecap.ForeColor = "White"
            $objRecap.Text = "L'utilisateur $identifiant a bien été désactivé"
            $objForm.Controls.Add($objRecap)
            Sleep -s 2
            $objForm.Controls.Remove($objRecap)          
        }
    }
}

###############################################

############# Texte : "Choisissez l'utilisateur" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(30,70) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisissez l'utilisateur"
$objForm.Controls.Add($objLabel) 

# Liste déroulante users #

$objComboboxUser = New-Object System.Windows.Forms.Combobox
$objComboboxUser.Location = New-Object System.Drawing.Size(30,90) 
$objComboboxUser.Size = New-Object System.Drawing.Size(220,40) 
$objComboboxUser.DropDownStyle = "DropDownList"

# Affichage de la liste déroulante utilisateurs

recup_ad_users

############# Texte : "Choisissez l'action" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(30,130) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisissez l'action a effectuer"
$objForm.Controls.Add($objLabel) 

# Liste déroulante enable_disable #

$objComboboxChoix = New-Object System.Windows.Forms.Combobox
$objComboboxChoix.Location = New-Object System.Drawing.Size(30,150) 
$objComboboxChoix.Size = New-Object System.Drawing.Size(220,20) 
$objComboboxChoix.DropDownStyle = "DropDownList"
$objComboboxChoix.Items.AddRange(("Activer", "Desactiver"))
$objForm.controls.add($objComboboxChoix)

############# VALIDER QUITTER OU RETOUR ###############

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(30,320)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Precedent"
$CancelButton.ForeColor = "White"
$CancelButton.Add_Click({$objForm.Close();.\gestion_users\choix_action_users.ps1})
$objForm.Controls.Add($CancelButton)

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(105,320)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "Valider"
$OKButton.ForeColor = "White"
$OKButton.Add_Click({enable_disable_user})
$objForm.Controls.Add($OKButton)


$QuitButton = New-Object System.Windows.Forms.Button
$QuitButton.Location = New-Object System.Drawing.Size(180,320)
$QuitButton.Size = New-Object System.Drawing.Size(75,23)
$QuitButton.Text = "Quitter"
$QuitButton.ForeColor = "White"
$QuitButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($QuitButton)


###############################################

# Affichage des éléments

$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()


###############################################
