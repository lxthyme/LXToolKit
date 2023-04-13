#!/bin/bash -e

PROJECT_NAME=${PWD##*/}  #获取当前目录

branch=master
# branch="damon/07-19_亮证"
branch="damon_v1"

# git stash
git pull origin  --tags
git pull origin $branch
# git stash pop

VersionString=`grep -E 's.version.*=' $PROJECT_NAME.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`
NewVersionNumber=$VersionNumber

read -n1 -p "❓是否更新 tag(current: $VersionNumber)?(Y | y)" shouldAddTag
case $shouldAddTag in
	Y | y)
NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' $PROJECT_NAME.podspec | cut -d : -f1`
esac

echo "\ncurrent version is ${VersionNumber}, new version is ${NewVersionNumber}"

sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" $PROJECT_NAME.podspec

case $shouldAddTag in
	Y | y)
git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin --tags
git push origin $branch
esac

cd ~/.cocoapods/repos/LXRepo
git pull origin $branch
cd -
pod repo push LXRepo $PROJECT_NAME.podspec --verbose --allow-warnings --use-libraries --use-modular-headers # --sources='https://gitlab.bl.com/iOS/BLRepositories.git'
#,https://cdn.cocoapods.org/'

# pod bin auto --configuration=Release --env=debug_iphoneos
# pod repo push LXRepo *.podspec --verbose --allow-warnings --use-libraries --use-modular-headers
