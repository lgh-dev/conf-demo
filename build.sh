#!/bin/bash

#!/bin/bash
# 命令执行目录、配置目录、前端代码目录
bin_dir="bin"
conf_dir="conf"
view_dir="view"

# 编译输出平台 win64
targetFile_win64="bin/demo.exe"

#编译输出平台 linux
targetFile_linux="bin/demo_linux"

#编译输出平台 mac
targetFile_mac="bin/demo_mac"

# 目标编译包file
 mainfile="main.go"

# 输出编译包
build_target_dir="target/conf-demo"

build() {
# 编译window平台执行文件
build_cmd=$(GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o "${targetFile_win64}" "${mainfile}" 2>&1)
# 编译linux平台执行文件
build_cmd=$(GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o "${targetFile_linux}" "${mainfile}" 2>&1)
# 编译mac平台执行文件
build_cmd=$(GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w" -o "${targetFile_mac}" "${mainfile}" 2>&1)
# 构建编译后的项目目录
build_cmd=$(rm -rf $build_target_dir)
build_cmd=$(mkdir -p $build_target_dir)
build_cmd=$(cp -r $bin_dir $build_target_dir/)
build_cmd=$(cp -r $conf_dir $build_target_dir/)
build_cmd=$(cp -r $view_dir $build_target_dir/)
build_cmd=$(chmod  -R 777 $build_target_dir/)

if [ -z "${build_cmd}" ]; then
echo "success"
fi
echo "${build_cmd}"

}

build


