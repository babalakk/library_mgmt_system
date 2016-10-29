# Prerequire
* docker
* host port 80
* git

```
git clone https://github.com/ddzero2c/library_mgmt_system.git $HOME/
```

# Build image
```
docker build -t "ubuntu/lms" ${library_mgmt_system_forder}
```

# Run
```
docker run -d --name lms -v /opt/mysql/:/var/lib/mysql -v $HOME/library_mgmt_system/lms:/lms -p 80:80 ubuntu/lms
```

> note. /opt/mysql on docker host will be deleted

