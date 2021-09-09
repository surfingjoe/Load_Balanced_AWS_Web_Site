#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade
hostnamectl set-hostname Controller
apt-get install unzip
apt-get install -y awscli
apt-get install -y ansible
aws s3 cp s3://surfingjoes-ansible-files/ansible.cfg /etc/ansible/ansible.cfg
aws s3 cp s3://surfingjoes-ansible-files/hosts /etc/ansible/hosts 
