#!/bin/bash
set -e

# WEB_HOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=02f06bd0-97cd-40b4-8dad-aae48c68e046"
WEB_HOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=80e29eca-bebd-4d74-9b7f-6d0b57cb2b4b"  # test
CI_BASE_URL="https://github.com/BangWork/ones-cn/actions/runs"

REPO_NAME="ones-cn"
BUILD_STATUS=$1
TAG_NAME=$2
RUN_NUM=$3

message(){
    if [[ ${BUILD_STATUS} == "success" ]]; then
        info_title="✅构建成功"
    fi
    if [[ ${BUILD_STATUS} == "failed" ]]; then
        info_title="❌构建失败"
    fi

    ci_url=${CI_BASE_URL}/${RUN_NUM}

    echo "${info_title}\n项目：${REPO_NAME}, 标签：**${TAG_NAME}**
\n链接：${ci_url}"
}

send(){
    local body
    body=$(cat <<EOF
{"msgtype": "markdown","markdown": {"content": "$(message)"}}
EOF
)
    # echo ${body}
    curl ${WEB_HOOK_URL} -H "Content-Type: application/json" -d "${body}"
}



echo "build notify params:" $1 $2 $3

send
