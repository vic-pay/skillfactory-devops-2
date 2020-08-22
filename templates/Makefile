SHELL := /bin/bash
PATH = /opt/sync-mirror
HTML_PATH = $(PATH)/html
URL = https://www.chiark.greenend.org.uk/~sgtatham

define sync_func
$(shell rm $(HTML_PATH)/$(1))
$(shell wget -P $(HTML_PATH) $(URL)/$(1))
endef

sync: sync_en sync_br sync_cn sync_cz sync_da \
	sync_de sync_es sync_fr sync_hu sync_it \
	sync_jp sync_nl sync_pl sync_ru sync_tw

sync_en:
	$(call sync_func,bugs.html)
	
sync_br:
	$(call sync_func,bugs-br.html)
	
sync_cn:
	$(call sync_func,bugs-cn.html)
	
sync_cz:
	$(call sync_func,bugs-cz.html)
	
sync_da:
	$(call sync_func,bugs-da.html)
	
sync_de:
	$(call sync_func,bugs-de.html)
	
sync_es:
	$(call sync_func,bugs-es.html)
	
sync_fr:
	$(call sync_func,bugs-fr.html)
	
sync_hu:
	$(call sync_func,bugs-hu.html)
	
sync_it:
	$(call sync_func,bugs-it.html)
	
sync_jp:
	$(call sync_func,bugs-jp.html)
	
sync_nl:
	$(call sync_func,bugs-nl.html)
	
sync_pl:
	$(call sync_func,bugs-pl.html)
	
sync_ru:
	$(call sync_func,bugs-ru.html)
	
sync_tw:
	$(call sync_func,bugs-tw.html)
	
deploy:
	#Searching for running containers
	$(eval RUNNING_CONTAINERS = $(shell /usr/bin/docker ps -q --filter ancestor=syncmirror:1.0))
	
	#Stopping running containers
	/bin/bash -c "/usr/bin/docker container stop $(RUNNING_CONTAINERS);:;"
	
	#Searching containers that use image
	$(eval CONTAINERS = $(shell /usr/bin/docker container ls -aq --filter ancestor=syncmirror:1.0))
	
	#Deleting containers that use image
	/bin/bash -c "/usr/bin/docker container rm $(CONTAINERS);:;"
	
	#Deleting image
	/bin/bash -c "/usr/bin/docker image rm syncmirror:1.0;:;"
	
	#Building image
	/bin/bash -c "/usr/bin/docker build -f $(PATH)/Dockerfile -t syncmirror:1.0 $(PATH)"
	
	#Starting container
	/bin/bash -c "/usr/bin/docker run -d -p 80:80 syncmirror:1.0"
