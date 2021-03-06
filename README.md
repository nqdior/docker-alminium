
[![Licence](https://img.shields.io/npm/l/express.svg)](https://github.com/ayapapa/docker-alminium/edit/master/LICENSE)
[![](https://images.microbadger.com/badges/image/ayapapa/docker-alminium.svg)](https://microbadger.com/images/ayapapa/docker-alminium "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/ayapapa/docker-alminium.svg)](https://microbadger.com/images/ayapapa/docker-alminium "Get your own version badge on microbadger.com")

# What?
This is ALMinium's docker version. Once you install docker and docker-compose, you can use ALMinium easily with command "docker-compose up -d", and custormize easily by modifying docker-compose.yml.

(Japanese) ALMiniumのDocker版を作ってみるサイトです。
docker-composeを利用していますので、docker-compose.ymlのホスト名、ポート番号や環境変数を変更することでカスタマイズ出来ます。起動は、"docker-compose up -d"と叩くだけです。  

refs:  
* ALMinium: https://github.com/ayapapa/alminium, which is forked from https://github.com/alminium/alminium  
* Dockerized ALMinium: https://github.com/ayapapa/docker-alminium  
* Docker image: https://hub.docker.com/r/ayapapa/docker-alminium/  

# Prerequisites
## install docker
for example, in the case of Ubunt16.04:
```shell
sudo apt-get update && sudo apt-get -y dist-upgrade
curl -fsSL https://get.docker.com/ | sh
```
see https://docs.docker.com/engine/installation/   
see https://get.docker.com/

## install docker-compose
see https://docs.docker.com/compose/  or https://github.com/docker/compose/releases  
for example:
```shell
sudo su
[sudo] password for user-name: (your password)
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

# How to start  
## Start with docker-compose
```shell
git clone https://github.com/ayapapa/docker-alminium.git  
cd docker-alminium  
sudo docker-compose up -d  
```
see https://docs.docker.com/compose/  
You can use AMinium(Redmine + several plugins) trough web-browser with URL http://localhost:10080.  
And you can change the hostname and the port number(defaults to 10080) by editing docker-composer.yml and restarting.  
**After the ```sudo docker-compose up -d``` execution, initialization processing of several tens of seconds to several minutes is done. If the display error occurs in the browser, please wait for a while and then display again.**  
(Japanese)ブラウザで http://localhost:10080 をアクセスするとALMiniumが表示されます。  
ホスト名、ポート番号など適切な設定に変更してお使いください。  
**```sudo docker-compose up -d``` 実行後に、数十秒～数分程度の初期化処理が行われます。ブラウザーで表示エラーになる場合は、しばらく待ってから、再表示してください。**

## Jenkins initialization
After installation, when accessing Jenkins service for the first time, the initialization process starts. For initial password, use ```/home/jenkins/secrets/initialAdminPassword```.
Also, when doing authentication collaboration with ALMinium (Redmine), please activate ** Redmine plugin ** at initialization or after initialization.
After that, set "Jenkins management" → "Global security setting" → "Enable security" → "Select Redmine user authentication" and set as follows.
* Redmine DBMS	: MySQL
* DB Server	: db
* Port		: 3306
* DB name	: alminium
* DB user	: alminium
* DB passwoerd: alminium
* Redmine version: 1.2.0以上

If you need Jenkins configuration file, you can find /home/jenkins on the host PC.

(Japanese)インストール後、最初にJenkinsサービスにアクセスすると、初期化処理が開始されます。初期パスワードは、 ```/home/jenkins/secrets/initialAdminPassword``` を利用してください。
また、ALMinium(Redmine)と認証連携をする場合は、初期化時あるいは初期化後に、**Redmine plugin**を有効化してください。
その後、「Jenkinsの管理」→「グローバルセキュリティの設定」→「セキュリティを有効化」→「Redmineユーザー認証を選択」し、以下の通り設定してください。

* Redmine DBMS	: MySQL
* DBサーバー	: db
* ポート番号	: 3306
* データベース名: alminium
* DBユーザー	: alminium
* DBパスワード	: alminium
* Redmineバージョン: 1.2.0以上

※Jenkins設定ファイルは、/home/jenkinsに格納されています。


## To use behind a proxy 
To use behind a proxy, please add environment variables, **http_proxy** and **https_proxy**, into docker-compose.yml.

# Environment Variables  
You can configure by modifying Envitonment Variables in docker-compose.yml.  

| name | description |
|:-----|:------------|
| ALM_HOSTNAME | The hostname of the ALMinium server. It should be set to server name or IP address, to be accessable from clients. |
| ALM_PORT | The port of the ALMinium server. This value indicates the public port on which the ALMinium application will be accessible on the network and appropriately configures ALMinium to generate the correct urls. It does not affect the port on which the internal apache2 server will be listening on. Defaults to 443 if ALM_ENABLE_SSL=y, else defaults to 80. |
| ALM_ENABLE_SSL | Enable SSL, y(es) or N(o). Defaults to N. Enabling this, self-signed certification will be created and used automatically(*). |
| ALM_RELATIVE_URL_ROOT | The relative url of the ALMinium server. If set "alminium", you can access http://localhost:10080/alminium/ Defaults to null, means no sub-directory. |
| ALM_ENABLE_AUTO_BACKUP | Enable auto backup, y(es) or N(o). Defaults to y. | 
| ALM_BACKUP_MINUTE | Auto backup schedule, crontab minute section(0-59). Defaults to 0. |
| ALM_BACKUP_HOUR   | Auto backup schedule, crontab hour section(0-23). Defaults to 3. |
| ALM_BACKUP_DAY    | Auto backup schedule, crontab day section(0-31). Defaults to */2. |
| ALM_BACKUP_EXPIRY | Auto backup schedule, how long (in days) to keep backups before they are deleted. Defaults to 14. |
| JENKINS_ENABLED | Enable Jenkins, true or false. Defaults to false. If true, you can access Jenkins through "http[s]://{ALMinium Host}/jenkins" |
| JENKINS_URL | Jenkins URL. If JENKINS_ENABLED is true, you must specify this. Defaults to http://jenkins:8080/jenkins |
| SMTP_ENABLED | Enable smtp mail delivery, true or false. Defaults to false. |
| SMTP_ENALBLE_STARTTLS_AUTO | Enable STARTTLS, true or false. Defaults to true. |
| SMTP_ADDRESS | SMTP server host address. Defaults to smtp.gmail.com |
| SMTP_PORT    | SMTP server port. Defaults to 587. |
| SMTP_DOMAIN  | SMTP domain. Defaults to smtp.gmail.com |
| SMTP_AUTHENTICATION | Specify the SMTP authentication method. Defaults to :login. |
| SMTP_USER_NAME | SMTP username. |
| SMTP_PASS      | SMTP password. |

*If you like to change the certification file, you should dive into ALMinium container with command "docker exec -it (container's name) /bin/bash", and then put your certification file on the place you like, and change /etc/opt/alminium/redmine-ssl.conf's certification description.

