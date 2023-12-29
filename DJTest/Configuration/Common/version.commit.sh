# git=`sh /etc/profile; which git`
number_of_commits=`git rev-list HEAD --count`
git_release_version=`git rev-parse --short HEAD`
CONFIGURATION='Debug'
build_version=''
if [ $CONFIGURATION = "Debug" -o $CONFIGURATION = "AdHoc" ]; then
branchName=`git rev-parse --abbrev-ref HEAD`
branchName=${branchName//\//_}
current_date=$(date "+%Y%m%d")
build_version=$branchName$current_date-$number_of_commits-$git_release_version
else
build_version=$number_of_commits
fi

key_version='MARKETING_VERSION'
file_config='Common.xcconfig'
previous_build_number=$(awk -F "=" '/'$key_version' = / {print $2}' $file_config | tr -d ' ')
echo "-->build version[$CONFIGURATION]: $previous_build_number -> $build_version"

# 每 20 个 commit 变更一次版本号
mod=$(($number_of_commits % 20))
if [ $mod -eq 0 ]; then
sed -i -e "/$key_version =/ s/= .*/= $build_version/" $file_config
rm -f $file_config-e
else
echo "skipping[$mod]..."
fi
