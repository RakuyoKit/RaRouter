#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2020.04.07

# 开始时间
start=$(date +%s)
startM=$(date +%M)

# log 颜色配置
Cyan='\033[0;36m'
Default='\033[0;m'

# 获取路径
project_path=$(cd `dirname $0` ; pwd);

cd $project_path

# 读取 podspec 文件
while read line
do

    # 获取 name
    if [[ $line =~ "s.name" ]] ; then
        name=`echo $line | cut -d = -f 2 | cut -d \' -f 2`
    fi

    # 获取版本号
    if [[ $line =~ "s.version" ]] ; then
        version=`echo $line | cut -d = -f 2 | cut -d \' -f 2`
        break # 结束循环
    fi

done  < $(find ./ -name '*.podspec')

# 当前时间
dateString=$(date "+%Y%m%d%H%M")

# info 文件路径
if [[ -f "Other/Info.plist" ]]; then
    infoPlist=$project_path"/Other/Info.plist"
else
    infoPlist=$project_path"/"${project_path##*/}"/Other/Info.plist"
fi

# 更新 info.plist 文件
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version" $infoPlist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $dateString" $infoPlist

# add info.plist
git add $infoPlist

echo "${Default}========================================================"
echo "  The info.plist file has been updated"
echo "${Default}========================================================"

# commit 信息
message="[Release Script] Version updated to $version $dateString"

# 提交 git
git add *.podspec && git commit -m $message && git push
git tag $version && git push origin $version

echo "${Default}========================================================"
echo "  Git push complete"
echo "${Default}========================================================"

echo "${Default}========================================================"
echo "  Start push ${Cyan}$name${Default} at $(date "+%F %r")"
echo "${Default}========================================================"

# 推送
pod trunk push $name.podspec --allow-warnings --skip-tests

# 计算时差
time=$(( $(date +%s) - $start ))
timeM=$(( $(date +%M) - $startM ))

echo "${Default}========================================================"
echo "  finish push ${Cyan}$name${Default}, time consuming $time second"
echo "${Default}========================================================"

say -v Mei-Jia "$name 推送完毕，耗时约为 $timeM 分钟"
