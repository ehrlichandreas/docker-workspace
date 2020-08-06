#!/usr/bin/env bash

repository_prefix="ehrlichandreas/workbase-"
date_suffix="2020.0806.1945";

awscli_version="1.18.112"
awscli_repo_version="${awscli_version}-${date_suffix}"
docker_version="19.03.12"
docker_repo_version="${docker_version}-${date_suffix}"
environment_version="${date_suffix}"
environment_repo_version="${environment_version}"
ide_base_version="${date_suffix}"
ide_base_repo_version="${ide_base_version}"
intellij_idea_c_version="2020.2"
intellij_idea_c_repo_version="${intellij_idea_c_version}-${date_suffix}"
intellij_idea_u_version="2020.2"
intellij_idea_u_repo_version="${intellij_idea_u_version}-${date_suffix}"
lyx_version="2.3.5"
lyx_repo_version="${lyx_version}-${date_suffix}"
python_version="3.8.2"
python_repo_version="${python_version}-${date_suffix}"
terraform_version="0.12.29"
terraform_repo_version="${terraform_version}-${date_suffix}"
ubuntu_version="20.04"
ubuntu_repo_version="${ubuntu_version}-${date_suffix}"
util_base_version="${date_suffix}"
util_imagemagick_version="${date_suffix}"
util_pdf_version="${date_suffix}"
util_scanner_version="${date_suffix}"

##
# aws cli
##
awscli_repository="${repository_prefix}awscli"
awscli_parent_repository="${repository_prefix}python"
#awscli_parent_repository="${python_repository}"
awscli_parent_version="${python_repo_version}"

##
# docker
##
docker_repository="${repository_prefix}dind"
docker_parent_repository="${repository_prefix}ubuntu"
#docker_parent_repository="${ubuntu_repository}"
docker_parent_version="${ubuntu_repo_version}"

##
# environment
##
environment_repository="${repository_prefix}environment"
environment_parent_repository="${repository_prefix}terraform"
#environment_parent_repository="${terraform_repository}"
environment_parent_version="${terraform_repo_version}"

##
# ide base
##
ide_base_repository="${repository_prefix}ide-base"
ide_base_parent_repository="${repository_prefix}dind"
#ide_base_parent_repository="${docker_repository}"
ide_base_parent_version="${docker_repo_version}"

##
# intellij idea community
##
intellij_idea_c_repository="${repository_prefix}intellij-idea-c"
intellij_idea_c_parent_repository="${repository_prefix}ide-base"
#intellij_idea_c_parent_repository="${ide_base_repository}"
intellij_idea_c_parent_version="${ide_base_repo_version}"

##
# intellij idea ultimate
##
intellij_idea_u_repository="${repository_prefix}intellij-idea-u"
intellij_idea_u_parent_repository="${repository_prefix}ide-base"
#intellij_idea_u_parent_repository="${ide_base_repository}"
intellij_idea_u_parent_version="${ide_base_repo_version}"

##
# lyx
##
lyx_repository="${repository_prefix}lyx"
lyx_parent_repository="${repository_prefix}ubuntu"
#lyx_parent_repository="${ubuntu_repository}"
lyx_parent_version="${ubuntu_repo_version}"

##
# python
##
python_repository="${repository_prefix}python"
python_parent_repository="${repository_prefix}dind"
#python_parent_repository="${docker_repository}"
python_parent_version="${docker_repo_version}"

##
# terraform
##
terraform_repository="${repository_prefix}terraform"
terraform_parent_repository="${repository_prefix}awscli"
#terraform_parent_repository="${awscli_repository}"
terraform_parent_version="${awscli_repo_version}"

##
# ubuntu
##
ubuntu_repository="${repository_prefix}ubuntu"
ubuntu_parent_repository="ubuntu"
ubuntu_parent_version="${ubuntu_version}"

##
# util base
##
util_base_repository="${repository_prefix}util-base"
util_base_parent_repository="${repository_prefix}ubuntu"
#util_base_parent_repository="${ubuntu_repository}"
util_base_parent_version="${ubuntu_repo_version}"

##
# util imagemagick
##
util_imagemagick_repository="${repository_prefix}util-imagemagick"
util_imagemagick_parent_repository="${repository_prefix}util-base"
#util_imagemagick_parent_repository="${util_base_repository}"
util_imagemagick_parent_version="${util_base_version}"

##
# util pdf
##
util_pdf_repository="${repository_prefix}util-pdf"
util_pdf_parent_repository="${repository_prefix}util-imagemagick"
#util_pdf_parent_repository="${util_imagemagick_repository}"
util_pdf_parent_version="${util_imagemagick_version}"

##
# util scanner
##
util_scanner_repository="${repository_prefix}util-scanner"
util_scanner_parent_repository="${repository_prefix}util-base"
#util_scanner_parent_repository="${util_base_repository}"
util_scanner_parent_version="${util_base_version}"
