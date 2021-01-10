# Flask Base
[![Python](https://img.shields.io/badge/python-3.8--slim-blue.svg)]() [![](https://img.shields.io/badge/flask--restplus-0.13.0-red.svg)]() 

My template base to build Flask RESTful APIs using [Flask RESTPlus](https://flask-restplus.readthedocs.io/en/stable/index.html), [JWT Extended](https://flask-jwt-extended.readthedocs.io/en/latest/) and [PyMongo](https://flask-pymongo.readthedocs.io/en/latest/).

You can just clone this repo and start to create/customize your own RESTful API using this code as your template base :)

## JWT, PyMongo... Do i need all of this ???

__NO !__ You can remove JWT, PyMongo and Bcrypt (used for hashing users password on database), excluding all the references on the [app](app/__init__.py), [config](config.py) and the files that makes use of them.

These _"extensions"_ and the _users_ endpoints are there just to help you, if you need to implement all of the boilerplate required to work with JWT, PyMongo and so on.

Don't forget to remove the dependencies from [requirements.txt](requirements.txt) too.

# Getting Started

## Installing

To install the Flask Base you will need to:

```
pip install -r requirements.txt
```

## Usage

### Development

```
# if you are not using mongo and jwt, forget these exports
export MONGO_URI="mongodb://<your_mongo_host>:27017/<your_database>"
export JWT_SECRET_KEY="<randomic_key>"
python3 entrypoint.py
```

## Docker


### Build

```
docker build -t flask-app .
```

### Start a New Container

```
docker run -d \
--name flask-app \
-p 5000:5000 \
-e MONGO_URI="mongodb://<your_mongo_host>:27017/<your_database>" \
-e JWT_SECRET_KEY="<randomic_key>" \
flask-app
```

## Swagger

After the application goes up, open your browser on `localhost:5000/api/v1/docs` to see the self-documented interactive API:

![](/imgs/swagger.png)


## Project Structure

The project structure is based on the official [Scaling your project](https://flask-restplus.readthedocs.io/en/stable/scaling.html#multiple-apis-with-reusable-namespaces) doc with some adaptations (e.g `v1` folder to agroup versioned resources).


```
.
├── app
│   ├── helpers
│   │   ├── __init__.py
│   │   ├── parsers.py
│   │   └── password.py
│   ├── __init__.py
│   └── v1
│       ├── __init__.py
│       └── resources
│           ├── auth
│           │   ├── __init__.py
│           │   ├── login.py
│           │   └── serializers.py
│           ├── __init__.py
│           └── users
│               ├── __init__.py
│               ├── models.py
│               ├── serializers.py
│               └── user.py
├── config.py
├── Dockerfile
├── LICENSE
├── README.md
├── requirements.txt
├── run.py
├── tests
│   ├── conftest.py
│   ├── fake_data
│   │   └── users.json
│   ├── __init__.py
│   ├── integration
│   │   ├── __init__.py
│   │   └── users
│   │       ├── __init__.py
│   │       └── test_users_api.py
│   └── unit
│       ├── helpers_test
│       │   ├── __init__.py
│       │   └── test_password.py
│       ├── __init__.py
│       └── users
│           ├── __init__.py
│           └── test_users.py
└── tox.ini

```

### Folders

* `app` - All the RESTful API implementation is here.
* `app/helpers` - Useful function/class helpers for all modules.
* `app/v1` - Resource agroupment for all `v1` [Namespaces](https://flask-restplus.readthedocs.io/en/stable/scaling.html#multiple-namespaces).
* `app/v1/blueprints` - All `v1` resources are implemented here.


### Files

* `app/__init__.py` - The Flask Application factory (`create_app()`) and it's configuration are done here. Your [Blueprints](https://flask-restplus.readthedocs.io/en/stable/scaling.html#use-with-blueprints) are registered here.
* `app/v1/__init__.py` - The Flask RESTPlus API is created here with the versioned Blueprint (e.g `v1`). Your [Namespaces](https://flask-restplus.readthedocs.io/en/stable/scaling.html#multiple-namespaces) are registered here.
* `config.py` - Config file for envs, global config vars and so on.
* `Dockerfile` - Dockerfile used to build a Docker image (using [Docker Multistage Build](https://docs.docker.com/develop/develop-images/multistage-build/))
* `LICENSE` - MIT License, i.e. you are free to do whatever is needed with the given code with no limits.
* `.dockerignore` - Lists files and directories which should be ignored while Docker build process.
* `.gitignore` - Lists files and directories which should not be added to git repository.
* `requirements.txt` - All project dependencies.
* `entrypoint.py` - The Application entrypoint.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.