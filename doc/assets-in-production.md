Assets in Production are precompiled as a deployment step.

There are two reasons for that:

- it makes it possible to use the same Dockerfile for all builds.
- in order for nginx to be able to serve them, they need to be available on a
   mount. as the mount will be created empty, they have to be regenerated.


nginx config:

    location ~ ^/assets/ {
            root   /home/deployer/rails/public;
            gzip_static on;
            expires max;
            add_header Cache-Control public;
        }


        
