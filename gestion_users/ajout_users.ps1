# SCRIPT DE CREATION D'UTILISATEUR ACTIVE DIRECTORY#

###############################################

# Chargement des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

###############################################

############# CREATION DE LA FENETRE ###############

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Ajouter un utilisateur"
$objForm.Size = New-Object System.Drawing.Size(300,400) 
$objForm.StartPosition = "CenterScreen"
$objForm.BackColor = "#02ACE5"

###############################################

function create_ad_user {

# Génération des variables saisies dans l'application

$departement = $objTextBox.Text
$prenom = $objTextBox2.Text
$nom = $objTextBox3.Text
$mdp = $objTextBox4.Text

# Construction de l'identifiant

$lettre_prenom = $prenom.Substring(0,1)
$identifiant = $lettre_prenom.ToLower()+$nom.ToLower()

if (Get-ADUser -F {SamAccountName -eq $identifiant})
       {

               #Si l’utilisateur existe, éditez un message d’avertissement

               Write-Warning "L'utilisateur $identifiant existe deja dans L'Active Directory."

       }
       else
       {

            #Si un utilisateur n’existe pas, créez un nouveau compte utilisateur
          
            #Parametre de l'utilisateur

              New-ADUser `
            -SamAccountName $identifiant `
            -UserPrincipalName "$identifiant@afip.lab" `
            -Name "$prenom $nom" `
            -GivenName $prenom `
            -Surname $nom `
            -Enabled $True `
            -Path "OU=Utilisateurs,DC=afip,DC=lab" `
            -ChangePasswordAtLogon $True `
            -DisplayName "$nom, $prenom" `
            -Department $departement `
            -AccountPassword (convertto-securestring $mdp -AsPlainText -Force)



            #Ajout de L'utilisateur dans le groupe $departement

            Add-ADGroupMember -Identity $departement -Members $identifiant -PassThru

            ############# Texte : "Recapitulatif " ###############

            $objRecap = New-Object System.Windows.Forms.Label
            $objRecap.Location = New-Object System.Drawing.Size(10,240) 
            $objRecap.Size = New-Object System.Drawing.Size(280,100)
            $objRecap.Font = New-Object System.Drawing.Font ("Arial", 9, [System.Drawing.FontStyle]::Bold)
            $objRecap.ForeColor = "White"
            $objRecap.Text = "L'utilisateur a été créé avec succès `n Prenom: $prenom `n Nom: $nom `n Identifiant: $identifiant"
            $objForm.Controls.Add($objRecap)
            Sleep -s 2
            $objForm.Controls.Remove($objRecap)
            $objTextBox2.Text = ''
            $objTextBox3.Text = ''
            $objTextBox4.Text = ''
        }
}

###############################################

############# Texte : "Choisir le département" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,20) 
$objLabel.Size = New-Object System.Drawing.Size(280,20)
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisir le departement"
$objForm.Controls.Add($objLabel) 

# Liste déroulante département #

$objTextBox = New-Object System.Windows.Forms.Combobox
$objTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
$objTextBox.DropDownStyle = "DropDownList"
$objTextBox.Items.AddRange(("Commercial", "Communication", "Comptabilite", "Developpeur", "DSI", "Finance", "RH"))
$objForm.controls.add($objTextBox)

###############################################

############# Texte : "Entrer le Prénom" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,70) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Entrer le Prénom"
$objForm.Controls.Add($objLabel) 

#Box de Saisi 2#

$objTextBox2 = New-Object System.Windows.Forms.TextBox 
$objTextBox2.Location = New-Object System.Drawing.Size(10,90) 
$objTextBox2.Size = New-Object System.Drawing.Size(260,20) 
$objForm.Controls.Add($objTextBox2) 

###############################################

############# Texte : "Entrer le Nom" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,130) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Entrer le Nom"
$objForm.Controls.Add($objLabel) 

#Box de Saisi 3#

$objTextBox3 = New-Object System.Windows.Forms.TextBox 
$objTextBox3.Location = New-Object System.Drawing.Size(10,150) 
$objTextBox3.Size = New-Object System.Drawing.Size(260,20) 
$objForm.Controls.Add($objTextBox3) 

###############################################

############# Texte : "Entrer le Mot de Passe" ###############

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,190) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Entrer le Mot de Passe"
$objForm.Controls.Add($objLabel) 

#Box de Saisi 3#

$objTextBox4 = New-Object System.Windows.Forms.MaskedTextBox
$objTextBox4.PasswordChar = '*'
$objTextBox4.Location = New-Object System.Drawing.Size(10,210) 
$objTextBox4.Size = New-Object System.Drawing.Size(260,20) 
$objForm.Controls.Add($objTextBox4) 

###############################################

############# VALIDER QUITTER OU RETOUR ###############

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(30,320)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Précédent"
$CancelButton.ForeColor = "White"
$CancelButton.Add_Click({$objForm.Close();.\gestion_users\choix_action_users.ps1})
$objForm.Controls.Add($CancelButton)

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(105,320)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "Valider"
$OKButton.ForeColor = "White"
$OKButton.Add_Click({create_ad_user})
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



