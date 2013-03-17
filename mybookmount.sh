#!/bin/bash
mount -t cifs -o username=admin,password=password //192.168.1.104/Public/Shared\ Videos/Movies /media/movies
mount -t cifs -o username=admin,password=password //192.168.1.104/Public/Reprap /media/reprap
mount -t cifs -o username=admin,password=password //192.168.1.104/Public/Shared\ Music /media/music
