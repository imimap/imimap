Neuen Dump erzeugen
========================================

Vorraussetzung hierzu ist, dass ssh key hinterlegt ist.

ssh local@imi-map.f4.htw-berlin.de

db password kann man in der Konfiguration nachsehen:

less /home/deployer/apps/ImiMaps/current/config/database.yml


pg_dump -h localhost -U imi_map  imi_map_production > imi-map.pgdump



Kopieren des dump
==========================================

    scp local@imi-map.f4.htw-berlin.de:imi-map.pgdump .



das geht alles schnell, der dump ist nicht so groß.
