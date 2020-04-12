#  一种解决的读取配置文件的相对路径问题的项目结构示例
    IDE执行、单元测试、编译后项目运行三种情况都可以正确读取到配置文件。
## 只需写死项目目录名称

```
1. confg-demo
  1. config/config.go
  1. main.go
```

1. 下载工程。


## 可以直接通过IDE运行main.go。我用的是goland，实测没问题。不依赖工作目录。

## 可以执行单元测试。
```
config-demo目录下。
go test ./...
```

## 可以通过sh进行编译。已包含window、linux、ma三种平台。
1. 执行命令。
```
./build.sh
```
然后进入`target/config-demo/bin/下，执行二进制文件。
```
cd target/config-demo/bin/
linux执行
./demo_linux
mac执行
./demo_mac
window直接双击打开
demo.exe
```
