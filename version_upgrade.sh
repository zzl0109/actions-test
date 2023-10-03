BRANCH=$1
IMAGE_NAME=$2


# 获取当前版本号  
current_version=$(curl -s https://registry.hub.docker.com/v2/repositories/zhangzhulei/$IMAGE_NAME/tags | jq -r '.results[0].name')  
  
if [[ $current_version == 'null' ]]; then  
  major=0  
  minor=0  
  patch=0  
else  
  major=$(echo ${current_version} | awk -F. '{print $1}')  
  minor=$(echo ${current_version} | awk -F. '{print $2}')  
  patch=$(echo ${current_version} | awk -F. '{print $3}')  
fi  
  
# echo "major ${major}"  
# echo "minor ${minor}"  
# echo "patch ${patch}"  
  
if [ $BRANCH == "master" ]; then  
  major=$((major+1))  
  minor=0  
  patch=0  
elif [ $BRANCH == "develop" ]; then  
  minor=$((minor+1))  
  patch=0  
else  
  patch=$((patch+1))  
fi

new_version="$major.$minor.$patch"

echo $new_version