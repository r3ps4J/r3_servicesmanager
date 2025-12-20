-- FX information
fx_version "cerulean"
game "common"
lua54 "yes"
use_experimental_fxv2_oal "yes"

-- Resource information
name "r3_servicesmanager"
version "0.2.0"
description "Services manager for FXServer"
author "r3ps4J"
contact "discord.gg/bEWmBbg"

-- Manifest
shared_script "dist/main.lua"

client_script "providers/**/cl_*.lua"
server_script "providers/**/sv_*.lua"
