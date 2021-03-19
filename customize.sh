#!/bin/bash
echo '.______    __       __    __   _______     __    __       ___      .______      ____    ____  _______      _______..___________.'
echo '|   _  \  |  |     |  |  |  | |   ____|   |  |  |  |     /   \     |   _  \     \   \  /   / |   ____|    /       ||           |'
echo '|  |_)  | |  |     |  |  |  | |  |__      |  |__|  |    /  ^  \    |  |_)  |     \   \/   /  |  |__      |   (----``---|  |----`'
echo '|   _  <  |  |     |  |  |  | |   __|     |   __   |   /  /_\  \   |      /       \      /   |   __|      \   \        |  |     '
echo '|  |_)  | |  `----.|  `--   | |  |____    |  |  |  |  /  _____  \  |  |\  \----.   \    /    |  |____ .----)   |       |  |     '
echo '|______/  |_______| \______/  |_______|   |__|  |__| /__/     \__\ | _| `._____|    \__/     |_______||_______/        |__|     '
echo
echo 'Welcome developer!'
echo 'Please provide the requested input in order to customize the template for your project.'
echo

echo 'First of all, please provide your company name.'
echo 'Make sure it'"'"'s all lowercase and separated by dash (\"-\") characters. The default is (blueharvest)'
read -p "Company Name: " COMPANY_NAME
if [[ -z COMPANY_NAME ]]; then
  COMPANY_NAME="blueharvest"
fi
echo "Great, you work at ${COMPANY_NAME}! What a great company!"
echo

echo 'Please provide your team name.'
echo 'Make sure it'"'"'s all lowercase and separated by dash (\"-\") characters. The default is (bluedev)'
read -p "Team Name: " TEAM_NAME
if [[ -z $TEAM_NAME ]]; then
  TEAM_NAME="bluedev"
fi
echo "Great Team ${TEAM_NAME}!"
echo

echo 'Please provide the name of this (micro)service.'
echo 'Make sure it'"'"'s the all lowercase and separated by dash (\"-\") characters. The default is (bedrocksb)'
read -p "Service Name: " SERVICE_NAME
if [[ -z $SERVICE_NAME ]]; then
  SERVICE_NAME="bedrocksb"
fi
echo "Great, you'll rock building ${SERVICE_NAME}!"
echo

echo 'Alright, ready for the next one?. Please provide the name of your main class'
echo 'Make sure it'"'"'s Capital Case and doesn'"'"'t contain any special characters or numbers. The default is (BedrockSbApplication)'
read -p "Main Class Name: " MAIN_CLASS_NAME
if [[ -z MAIN_CLASS_NAME ]]; then
  MAIN_CLASS_NAME="BedrockSbApplication"
fi
echo "Great, you'll rock building ${MAIN_CLASS_NAME}!"
echo

echo 'That'"'"'s it! Crazy right? You were in the zone as well!'
echo

echo 'Now please give me a few milliseconds to customize your project...'
echo

# Replace argument $1 by argument $2 in file $3
replace() {
    sed --version >/dev/null 2>&1 || system="isUnix"
    if [[ $system = "isUnix" ]]
    then
        sed -i '' "s/$1/$2/g" $3
    else
        sed -i "s/$1/$2/g" $3
    fi
}

COMPANY_NAME_WITHOUT_DASH=${COMPANY_NAME//-}
TEAM_NAME_WITHOUT_DASH=${TEAM_NAME//-}
SERVICE_NAME_WITHOUT_DASH=${SERVICE_NAME//-}
MAIN_PACKAGE_PATH="com.${COMPANY_NAME_WITHOUT_DASH}.${TEAM_NAME_WITHOUT_DASH}.${SERVICE_NAME_WITHOUT_DASH}"

echo '[INFO] Customizing pom.xml'
replace "com.blueharvest.bluedev" "com.${COMPANY_NAME_WITHOUT_DASH}.${TEAM_NAME_WITHOUT_DASH}" "./pom.xml"
replace "blueharvest" ${COMPANY_NAME} "./pom.xml"
replace "bluedev" ${TEAM_NAME} "./pom.xml"
replace "bedrocksb" ${SERVICE_NAME} "./pom.xml"
echo

echo '[INFO] Customizing Dockerfile'
replace "blueharvest-bluedev" ${TEAM_NAME} "./Dockerfile"
replace "com.blueharvest.bluedev.bedrocksb.BedrockSbApplication" "${MAIN_PACKAGE_PATH}.${MAIN_CLASS_NAME}" "./Dockerfile"
echo

echo '[INFO] Customizing ./src/main/resources/logback-spring.xml'
replace "com.blueharvest.bluedev.bedrocksb" ${MAIN_PACKAGE_PATH} "./src/main/resources/logback-spring.xml"
echo

echo '[INFO] Refactoring the project packages and directories'
for f in $(find . -type f -name "*.java")
do
  replace "com.blueharvest.bluedev.bedrocksb" ${MAIN_PACKAGE_PATH} "$f"
  replace "BedrockSbApplication" ${MAIN_CLASS_NAME} "$f"
done
git mv ./src/main/java/com/blueharvest/bluedev/bedrocksb/BedrockSbApplication.java ./src/main/java/com/blueharvest/bluedev/bedrocksb/${MAIN_CLASS_NAME}.java
git mv ./src/test/java/com/blueharvest/bluedev/bedrocksb/BedrockSbApplicationTests.java ./src/test/java/com/blueharvest/bluedev/bedrocksb/${MAIN_CLASS_NAME}Tests.java
git mv ./src/main/java/com/blueharvest/bluedev/bedrocksb ./src/main/java/com/blueharvest/bluedev/${SERVICE_NAME_WITHOUT_DASH}
git mv ./src/test/java/com/blueharvest/bluedev/bedrocksb ./src/test/java/com/blueharvest/bluedev/${SERVICE_NAME_WITHOUT_DASH}
git mv ./src/main/java/com/blueharvest/bluedev ./src/main/java/com/blueharvest/${TEAM_NAME_WITHOUT_DASH}
git mv ./src/test/java/com/blueharvest/bluedev ./src/test/java/com/blueharvest/${TEAM_NAME_WITHOUT_DASH}
git mv ./src/main/java/com/blueharvest ./src/main/java/com/${COMPANY_NAME_WITHOUT_DASH}
git mv ./src/test/java/com/blueharvest ./src/test/java/com/${COMPANY_NAME_WITHOUT_DASH}
echo

echo 'Done! Enjoy your fresh project, happy developing!'
echo 'And don'"'"'t forget to pull updates regularly from the bedrock!'
