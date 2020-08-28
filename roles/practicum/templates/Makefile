SHELL := /bin/bash
PATH = {{ practicum_path }}
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
	{{ practicum_path }}/deploy.sh
