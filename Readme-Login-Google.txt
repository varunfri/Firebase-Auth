Login Panel Using Flutter and Firebase with Google auto signin 

First create a project in firebase 
Then install the prerequisites required for firebase 
We need npm, install it from npm website 
!!Remember, while activating the firebase for 
then create the code in flutter

 After creating the project in firebase, for web authorization we 

 need to get the client-id from the "https://console.cloud.google.com/" Google Cloud Console
 In the credentials tab, we can get the OAuth Client-id
 for web, get the client id and register the domain name in the web-application URI for 
 redirecting the OAuth site for Sign-in.

Deploying the resources: 
> Run the cmd, Firebase deploy
> In Project Folder, make sure Firbase.json is created and change the path of web-app folder
> where web-app has built, at hosting key change to "build/web" it will bw deployed into machine and 
> automatically alternate domain will be generated. 
> After deployment you need to add the domain name to Google cloud console(IMP).
> Follow the generated link for hosting-site and the project-console for other configs.

> Make sure you generated the SHA1 and SHA256 fingerprints using 
> keytool -printcert -

> ex: Project Console: https://console.firebase.google.com/project/firebae-app-1/overview
> eX: Hosting URL: https://firebae-app-1.web.app

> Used different providers like Google, Github, Facebook, and Phonenumber authorization