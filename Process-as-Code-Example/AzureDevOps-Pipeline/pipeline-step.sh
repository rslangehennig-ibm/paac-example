##
## NOTE THIS STEP uses the "Shell Exec" plugin for Azure DevOps - classic pipeline
##

#export PATH=$PATH:/Users/rlange/Documents/git-ado/paac-0.1.0.1171817
export PATH=$PATH:/Users/rlange/Documents/git-ado/paac-2.0.1173150

pwd
ls -al

# -----------------------------------------------------------------------
# Change directory to the application folder (Process-as-Code-Example)
# -----------------------------------------------------------------------
cd Process-as-Code-Example
ls -al

# -------------------------------------------------------------------------------------------------
# 1.  Change directory to the JSON component process folder
#
#     Check for recent commits to the TXT files or JSON files in the folder.  
#        TRUE -> If we find recent changes, run the "upload-component-process" command to
#                       upload the changes to IBM DevOps Deploy
#
#        FALSE -> If no recent changes are found, no need to upload an update to the component 
#                        process
# -------------------------------------------------------------------------------------------------
cd Process-as-Code
ls -al
FOUND_CHANGES=false

######
# The -cmin 5 is used to check to changes in the last 5 minutes
######
for name in `find . -name "*.txt" -cmin -5`
do
         echo Changes made to $name
         FOUND_CHANGES=true
done

######
# The -cmin 5 is used to check to changes in the last 5 minutes
######
for name in `find . -name "*.json" -cmin -5`
do
         echo Changes made to $name
         FOUND_CHANGES=true
done

if [[ $FOUND_CHANGES == "true" ]]
then
      echo "Changes were found to the component process.   Running the upload-component-process command..."
      #upload-component-process $(deploy-username) $(deploy-password) $(deploy-server-url) Deploy Process-as-Code deploy.json
      upload-component-process $(deploy-username) $(deploy-password) $(deploy-server-url) deploy.json "$(Build.SourceVersionMessage)"
      echo "Upload of component process was successful"
else
      echo "No code changes found"
fi
