#lnmp兼容百度BAE的Docker

LNMP(Centos 7, Nginx 1.10, MySQL 5.7, PHP 7.0) 的Dcoker版本，兼容百度云BAE专业版

首先说下，目前已经有很多Docker版的LNMP镜像，这个跟其他LNMP的区别是：

* 不是YUM安装，而是 ** 编译** ，文件来自 [lnmp.org](http://www.lnm.org/) 用的是lnmp1.3下载版。
* 兼容百度的BAE专业版，也就是 */home/wwwroot/app* 是软连到*/home/bae/app* ，兼容BAE的代码更新。
* 好玩的地方是 */home/wwwroot/app*  下面vhost你可以放置nginx配置文件，web放置网站文件。每次更新都会自动生效。


> 吐槽下百度云，只提供了镜像仓库，而没有提供构建工具，这个就需要你在其他地方构建好后，在push过去到百度云里面。

--------
## 解决办法


#### 1、用github来管理代码

#### 2、用阿里云的Docker来构建，地址为：[https://cr.console.aliyun.com/](http://https://cr.console.aliyun.com/) 在里面选择github导入就可以了。

####3、构建完成后，再在阿里云用ECC云服务器跑几条命令，将镜像推送给百度云。如果你没有，就开个后付费的，一般也就是十来分钟就可以搞定。

--------

##  在ECC或自己服务器上需要做下中转的几个命令


###1、拉取镜像

`mkdir ~/__ORG__/; cd ~/__ORG__/;`

`docker login --username=[ID] registry.aliyuncs.com`

`docker pull registry.aliyuncs.com/admin/lnmp`

== 需要替换相应的登陆名和镜像地址 ==

###2、提交到百度

> 如果你在自己的机器上构建的话，登陆百度仓库后就可以通过 
`docker build -t registry.bce.baidu.com/[ID]/lnmp:lastest ./` 
来构建你的镜像。由于我们将这个工作交给阿里云的，就这里就直接提交给百度就可以了

#### 登陆的命令。
`docker login -u [AK] -p [SK] registry.bce.baidu.com`

##### 提交命令
`docker build -t registry.bce.baidu.com/[ID]/lnmp:lastest ./`

`docker push registry.bce.baidu.com/[ID]/test`


--------
剩下的就就是去百度BAE里面查看镜像，部署到你的设备上。

使用中有有问题，都建议 [在这里提交Issue](http://https://github.com/lyhiving/baelnmp/issues/new)   加微信：689562 交流。


—by lyhiving










