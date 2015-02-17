Tastypie Cheat Sheet
====================
Start a new project with `newpy whatev --tasty`, then view your new directory
structure with `tree`.

    % tree -Fa -I 'env|*.pyc' mysite
    mysite
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    ├── whatev/
    │   ├── admin.py
    │   ├── __init__.py
    │   ├── migrations/
    │   │   └── __init__.py
    │   ├── models.py
    │   ├── tests.py
    │   └── views.py
    └── wsgi.py

    2 directories, 10 files

#### Create a new model
Define the new model in `mysite/whatev/models.py`
- subclass `models.Model`

    from django.db import models

    class MyModel(models.Model):
        ...

#### Define authorization to access model through API
Define authorization in `mysite/whatev/api/authorization.py`
- subclass `DjangoAuthorization`
- define `<CRUD>_list` and `<CRUD>_detail` methods, where CRUD in create, read,
  update, delete

    from tastypie.authorization import DjangoAuthorization

    class MyModelAuthorization(DjangoAuthorization):
        def read_list(self, ...):
            ...
        def read_detail(self, ...):
            ...

#### Define the resource
Define the resource in `mysite/whatev/api/v1/resources.py`
- import the model and authorization created in previous steps
- subclass `ModelResource`
- set Meta options in the inner `class Meta`

    from tastypie.resources import ModelResource
    from mysite.whatev.models import MyModel
    from mysite.whatev.api.authorization import MyModelAuthorization

    class MyModelResource(ModelResource):
        class Meta:
            queryset = MyModel.objects.all()
            allowed_methods = ('get',)
            resource_name = 'myresource'
            authorization = MyModelAuthorization()

#### Register the resource
Register the resource to the api in `mysite/whatev/urls.py`

    from tastypie.api import Api
    from mysite.whatev.api.v1.resources import MyModelResource

    v1_whatev = Api(api_name='v1/whatev')
    v1_whatev.register(MyModelResource())
