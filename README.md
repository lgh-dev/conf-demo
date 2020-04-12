#  一种解决的读取配置文件的相对路径问题的项目结构示例
    IDE执行、单元测试、编译后项目运行三种情况都可以正确读取到配置文件。
## 只需写死项目目录名称
终点关注的文件
```
confg-demo
      config/config.go
      main.go
```
关键配置代码

```
package config

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"log"
	"runtime"
	"strings"
	"sync"
)

var Conf *viper.Viper

var once sync.Once // 单例工具。

const projectName = "conf-demo"

func init() {
	InitConfig(GetPath() + "/conf")
	WatchConfig()
}

// 获取全局变量 ,单例模式。
func InitConfig(path string) *viper.Viper {
	once.Do(func() {
		if Conf == nil {
			Conf = ReadConfigFile(path, "app", "yaml")
		}
	})
	return Conf
}

func GetPath() string {
	//获取当前文件的路径 /Users/lgh/Documents/leavemsg/config/config.go
	_, filename, _, _ := runtime.Caller(0)
	//获取项目目录 /Users/lgh/Documents/conf-demo
	filename = strings.Split(filename, projectName)[0] + projectName
	return filename
}

//读取配置文件。
func ReadConfigFile(path string, fileName string, configType string) *viper.Viper {
	v := viper.New()
	v.SetConfigName(fileName)   // name of config file (without extension)
	v.SetConfigType(configType) // REQUIRED if the config file does not have the extension in the name
	v.AddConfigPath(path)
	err := v.ReadInConfig() // Find and read the config file
	if err != nil {         // Handle errors reading the config file
		panic(fmt.Errorf("Fatal error config file: %s \n", err))
	}
	fmt.Print(v.AllKeys())
	return v
}
func WatchConfig() {
	Conf.WatchConfig()
	log.Println("start to watch config file!")
	viper.OnConfigChange(func(e fsnotify.Event) {
		fmt.Printf("Config file changed: %s\n", e.Name)
	})
}

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
然后进入`target/config-demo/bin/`下，执行二进制文件。
```
cd target/config-demo/bin/
linux执行
./demo_linux
mac执行
./demo_mac
window直接双击打开
demo.exe
```
