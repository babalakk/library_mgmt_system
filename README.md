# Prerequire
* docker
* host port 80
* git

```
git clone https://github.com/ddzero2c/library_mgmt_system.git $HOME/library_mgmt_system
```

# Build image
```
docker build -t "ubuntu/lms" $HOME/library_mgmt_system
```

# Run
```
docker run -d --name lms -v /opt/mysql/:/var/lib/mysql -v $HOME/library_mgmt_system/lms:/lms -p 80:80 ubuntu/lms
```

> note. /opt/mysql on docker host will be deleted

