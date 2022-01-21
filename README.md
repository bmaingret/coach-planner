# coach-planner

Example of a Dockerfile with Poetry and Google Cloud Build.

You can have more explaination in the article I wrote [here](https://bmaingret.github.io/blog/2021-11-15-Docker-and-Poetry).

## Usage

Building image:
```console
$ docker build --tag poetry --file docker/Dockerfile .
```

Building image with specific target
```console
$ docker build --target development -t poetry --file docker/Dockerfile .
```


Running built image
```console
$ docker run -p 8888:8888 -it poetry
```

Getting a shell
```console
$ docker run -p 8888:8888 --entrypoint /bin/bash -it poetry
```


## Contributors

Thanks:

* https://github.com/zzztimbo 
* https://github.com/MartinWallgren 
