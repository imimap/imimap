Docker deployment & Assets
===========================

or: When should the assets be compiled when deploying with docker, and how should they be served in the production environment?


When should the assets be precompiled when deploying with docker?
----------------------------
There are basically three options:

1. Within the docker build:
    - pro: docker image is self-containing
    - pro: rails application detects assets at startup, asset_urls are correctly determined
    - pro: fast container startup compared to 3)
    - contra: environment specific dockerfile
    - contra: it is not trivial to make the assets available outside the docker container
2. during deployment
    - pro: generic docker builds for all environments
    - pro: seems more correct from a cd-perspective
    - contra: needs to be done within the container; then container has already started up once without the assets and would need to be restarted
3. during container startup
    - contra: slows down container startup considerably
    - contra: should only be done once after new deployment, not with every startup

Assets for IMI-Map
--------------------------
Although it means specific Dockerfiles for production, I've decided to follow
option 1) with the imimap.

To make the assets available to nginx for serving, the assets are copied from
the container to a directory on the host dir.

The former option with a docker mount did not work, as the directory on the
host machine would overwrite the directory within the container, leading to
non-existent or old assets in the directory.


Overview Blog-Articles
==========================================
I've looked at a couple of Blog articles, here's a short summary:

Using Docker for Rails in a Production Environment
-----------------------------
June 26, 2017 | By Christopher Rigor | Docker, Ruby on Rails
[https://www.engineyard.com/blog/using-docker-for-rails](https://www.engineyard.com/blog/using-docker-for-rails)

- during the docker container build
CMD starts the rails server, specialized Docker file for production

Rails Asset Pipeline compilation and Docker
---------------------------------------------------
[http://www.eq8.eu/blogs/42-rails-asset-pipeline-compilation-and-docker](http://www.eq8.eu/blogs/42-rails-asset-pipeline-compilation-and-docker)

This article is not in complete sentences, but makes the case that having
specific docker files for specific environments may defeat the idea of
deploying the same image everywhere.

also, CMD run.sh which also does assets:precompile not a good idea, as it
slows down server starting/ container startup significantly.

assets:precompile should be part of the image build as the images should be
complete and self-contained.

The proposed solution though is too complicated, generating a Dockerfile
looping over a bunch of environments.

article without author, and the case is for different RAILS_ENV
 (staging, production) -which shouldn't be used as pointed out by Daniel
 Huckstep in one of the comments. I second that.


Docker and assets and Rails, OH MY!
---------------------------------------------------
Jon Yardley
[https://blog.red-badger.com/blog/2016/06/22/docker-and-assets-and-rails-oh-my](https://blog.red-badger.com/blog/2016/06/22/docker-and-assets-and-rails-oh-my)


This article is about serving assets via a cdn which has its own problem that
the asset urls need the correct host name:
"Referenced assets were not resolving to the correct location when running assets:precompile."

Thus, they seem to build different images passing in the different host names.

they also make the case that precompiling the assets while
bringing up the server slows down server startup too much.

but the way they do it is copying the assets from the docker image to another
location on the host:

mkdir -p rails_assets
id=$(docker create <my_image_with_assets>)
docker cp $id:/app/public/assets rails_assets
aws s3 cp --recursive rails_assets/ s3://<my_s3_bucket_name> --cache-control max-age=604800

also found in a gist: https://gist.github.com/jonyardley/47f6bd8847c860f68ed7e0fa463d6d23


Deploying your Docker Rails App
------
 updated: 2017-06-19
by Leigh Halliday
[https://blog.codeship.com/deploying-docker-rails-app/](https://blog.codeship.com/deploying-docker-rails-app/)

He does't discuss the issue just makes assets:precompile part of the image build.
