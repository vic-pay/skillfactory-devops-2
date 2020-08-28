#!/bin/sh

ansible-playbook playbook.yml -i inventory.yml --ask-become-pass
